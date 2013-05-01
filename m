From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 1 May 2013 16:11:47 +0800
Subject: [Question] flush_dcache_page() need to flush icache?
In-Reply-To: <20130430152635.GH29766@arm.com>
References: <CACVXFVMz3jLEPDYFM-_S_t5TiqikVSRiKf9cBNocH3QhVexwZg@mail.gmail.com>
 <20130430090502.GC29766@arm.com>
 <CACVXFVPz-rMiPyW2EE==v58LF6uTD1M1fKTNcF5a5+Z6-5u+Gg@mail.gmail.com>
 <20130430152635.GH29766@arm.com>
Message-ID: <CACVXFVNUu9HKY+Vo7VLWGC3rQoj7TUwC3kfpEsf5kCEibMcThg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 11:26 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> It's not self-modifying code, this would be code running in user space
> which modifies some other code and it would invoke the ARM-specific
> syscall for flushing.
>
> Here it is about kernel modifying a page which is already mapped in user
> space, hence the check for mapping && mapping_mapped.

I understand that flushing icache is only needed when the page is mapped
as executable in virtual address, right?  If yes, the flush_dcache_page might
be inside read/write on one mapped page(executable in virtual space), then
still looks like self-modifying code case?

Thanks,
-- 
Ming Lei
