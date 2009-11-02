From: 914059751@qq.com (=?gbk?B?uvrR7sr3?=)
Date: Mon, 2 Nov 2009 12:36:43 +0800
Subject: =?gbk?B?u9i4tKO6IHdoYXQncyB6ZXJvX3BhZ2VzIGZvciBp?=
	=?gbk?B?biBwYWdpbmdfaW50?=
Message-ID: <tencent_3DF57BA34D628A42186140F7@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Rusel:)

      I'm a newbie in this mailing list as well as on my kernel adventure,thanks for your kind advice and crystal explanation about zero-pages.

Best regards
--rocky



>>Please don't post extracts of code which are part of mainline kernels.
>>Just provide a reference to where they are.  Most people who will reply
>>to you already have a copy of the kernel source.
 

 
------------------ ???? ------------------
???: "Russell King - ARM Linux"<linux@arm.linux.org.uk>;
????: 2009?10?30?(???) ??6:31
???: "???"<914059751@qq.com>; 
??: "linux-arm-kernel"<linux-arm-kernel@lists.infradead.org>; 
??: Re: what's zero_pages for in paging_int

 
On Fri, Oct 30, 2009 at 11:18:13AM +0800, ??? wrote:
>      In paging_int, after setting up bootmem allocator, why zero page
> is needed? i cannot see any things usefull resides on that page,
> something i missing obviously?

Please don't post extracts of code which are part of mainline kernels.
Just provide a reference to where they are.  Most people who will reply
to you already have a copy of the kernel source.

The zero page is a page full of zeros, and is used to provide userspace
with a write-protected initial BSS segment.  When userspace first writes
to the BSS segments, a page fault happens, and a replacement writable
zero page will be given to the program.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
