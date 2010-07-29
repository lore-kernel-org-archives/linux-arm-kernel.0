From: koen.velle@gmail.com (koen velle)
Date: Thu, 29 Jul 2010 10:27:53 +0200
Subject: arm1176 running out of memory with kernel version 2.6.29.5 when
	d-cache >16k
Message-ID: <AANLkTimzt4fss_FEQqCUPVve8fEkz2YpprHwq0fSE1V8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi,

I've got a (simulated) system where I can select my cache sizes.  Boot
goes fine with 4, 8, and 16k cache, but goes boink with 32k cache.
While debugging, I'm able to find out that in __do_page_fault, I end
up at the label out_of_memory, as handle_mm_fault returns
VM_FAULT_OOM.

This does not happen with caches <32k.  Otherwise, both my system and
my linux config are identical, only the cache size is different.

Is there anything that can explain this ? Do I need to modify the
kernel configuration somehow if I want to use 32k caches ? Does the
kernel consume more memory when using 32k caches due to dealing with
cache coloring ?

In short, any easy answers ?

Thanks,
