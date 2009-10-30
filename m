From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Oct 2009 10:31:04 +0000
Subject: what's zero_pages for in paging_int
In-Reply-To: <tencent_6A57DBDE2957BDF72E459404@qq.com>
References: <tencent_6A57DBDE2957BDF72E459404@qq.com>
Message-ID: <20091030103104.GA32622@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
