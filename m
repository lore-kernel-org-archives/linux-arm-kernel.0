From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Oct 2013 13:47:19 +0000
Subject: ARM/kirkwood: v3.12-rc6: kernel BUG at mm/util.c:390!
In-Reply-To: <20131027134257.GB30783@mtj.dyndns.org>
References: <20131024200730.GB17447@blackmetal.musicnaut.iki.fi>
 <20131026143617.GA14034@mudshark.cambridge.arm.com>
 <20131027195115.208f40f3@tom-ThinkPad-T410>
 <20131027125036.GJ17447@blackmetal.musicnaut.iki.fi>
 <CACVXFVP2B3=82m_+DfA_oAEW86c=oxQ52G+yj5ncTU1DzP26Bw@mail.gmail.com>
 <20131027134257.GB30783@mtj.dyndns.org>
Message-ID: <20131027134718.GC16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 27, 2013 at 09:42:57AM -0400, Tejun Heo wrote:
> On Sun, Oct 27, 2013 at 09:16:53PM +0800, Ming Lei wrote:
> > On Sun, Oct 27, 2013 at 8:50 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > >
> > > On ARM v3.9 or older kernels do not trigger this BUG, at seems it only
> > > started to appear with the following commit (bisected):
> > >
> > > commit 1bc39742aab09248169ef9d3727c9def3528b3f3
> > > Author: Simon Baatz <gmbnomis@gmail.com>
> > > Date:   Mon Jun 10 21:10:12 2013 +0100
> > >
> > >     ARM: 7755/1: handle user space mapped pages in flush_kernel_dcache_page
> > 
> > The above commit only starts to implement the helper on ARM,
> > but according to Documentation/cachetlb.txt, looks caller of
> > flush_kernel_dcache_page() should make sure the passed
> > 'page' is a user space page.
> 
> I don't think PageSlab() is the right test tho.  Wouldn't testing
> against user_addr_max() make more sense?

How does that help for a function passed a struct page pointer?
