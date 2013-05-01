From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 May 2013 09:22:38 +0100
Subject: [Question] flush_dcache_page() need to flush icache?
In-Reply-To: <CACVXFVNUu9HKY+Vo7VLWGC3rQoj7TUwC3kfpEsf5kCEibMcThg@mail.gmail.com>
References: <CACVXFVMz3jLEPDYFM-_S_t5TiqikVSRiKf9cBNocH3QhVexwZg@mail.gmail.com>
 <20130430090502.GC29766@arm.com>
 <CACVXFVPz-rMiPyW2EE==v58LF6uTD1M1fKTNcF5a5+Z6-5u+Gg@mail.gmail.com>
 <20130430152635.GH29766@arm.com>
 <CACVXFVNUu9HKY+Vo7VLWGC3rQoj7TUwC3kfpEsf5kCEibMcThg@mail.gmail.com>
Message-ID: <20130501082238.GA10984@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 09:11:47AM +0100, Ming Lei wrote:
> On Tue, Apr 30, 2013 at 11:26 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > It's not self-modifying code, this would be code running in user space
> > which modifies some other code and it would invoke the ARM-specific
> > syscall for flushing.
> >
> > Here it is about kernel modifying a page which is already mapped in user
> > space, hence the check for mapping && mapping_mapped.
> 
> I understand that flushing icache is only needed when the page is mapped
> as executable in virtual address, right?  If yes, the flush_dcache_page might
> be inside read/write on one mapped page(executable in virtual space), then
> still looks like self-modifying code case?

It depends on the definition of 'self'. If by that you mean the user
application, it hasn't modified itself and it can't trigger
flush_dcache_page().

-- 
Catalin
