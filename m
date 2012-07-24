From: zhanzhenbo@gmail.com (=?GB2312?B?1b/V8bKo?=)
Date: Tue, 24 Jul 2012 18:54:30 +0800
Subject: Why the region area don't decrease 1 in function sanity_check_meminfo?
Message-ID: <CAKvkGKeqzAiqRAj+H+E-eoN9SOOMP-aMhUJYmUb0UK4ei=jouA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this function, have these codes:

/*
		 * Check whether this memory bank would partially overlap
		 * the vmalloc area.
		 */
		if (__va(bank->start + bank->size) > vmalloc_min ||
		    __va(bank->start + bank->size) < __va(bank->start)) {
			unsigned long newsize = vmalloc_min - __va(bank->start);
			printk(KERN_NOTICE "Truncating RAM at %.8llx-%.8llx "
			       "to -%.8llx (vmalloc region overlap).\n",
			       (unsigned long long)bank->start,
			       (unsigned long long)bank->start + bank->size - 1,
			       (unsigned long long)bank->start + newsize - 1);
			bank->size = newsize;
		}

Dear all,


I don't known why the memory region have not decrease 1, i think it
should be decreased(like this , (__va(bank->start + bank->size
-1))because in sparse memory system,  this address bank->start +
bank->size is belong to another bank, so this method is not correctly.

Please indicate whether my understanding is correct.

Thanks.


Steve
