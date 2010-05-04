From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 May 2010 18:45:07 +0100
Subject: Suspicious compilation warning
In-Reply-To: <n2gcecb6d8f1005041035w51dac3c8ke829a4ae8bf7f408@mail.gmail.com>
References: <k2ncecb6d8f1004191627w3cd36450xf797f746460abb09@mail.gmail.com>
	<20100420155122.6f2c26eb.akpm@linux-foundation.org>
	<20100420230719.GB1432@n2100.arm.linux.org.uk>
	<n2gcecb6d8f1005041035w51dac3c8ke829a4ae8bf7f408@mail.gmail.com>
Message-ID: <20100504174507.GI30601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 02:35:50PM -0300, Marcelo Jimenez wrote:
> Hi,
> 
> On Tue, Apr 20, 2010 at 20:07, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > Well, it'll be about this number on everything using sparsemem extreme:
> >
> > #define SECTIONS_PER_ROOT ? ? ? (PAGE_SIZE / sizeof (struct mem_section))
> >
> > and with only 32 sections, this is going to give a NR_SECTION_ROOTS value
> > of zero. ?I think the calculation of NR_SECTIONS_ROOTS is wrong.
> >
> > #define NR_SECTION_ROOTS ? ? ? ?(NR_MEM_SECTIONS / SECTIONS_PER_ROOT)
> >
> > Clearly if we have 1 mem section, we want to have one section root, so
> > I think this division should round up any fractional part, thusly:
> >
> > #define NR_SECTION_ROOTS ? ? ? ?((NR_MEM_SECTIONS + SECTIONS_PER_ROOT - 1) / SECTIONS_PER_ROOT)
> 
> Seems correct to me, Is there any idea when this gets committed?

What should be asked is whether it has been tested - if not, can we find
someone who can test and validate the change?
