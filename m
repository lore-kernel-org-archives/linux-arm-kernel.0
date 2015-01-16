From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:15:54 +0900
Subject: [PATCH v2 2/2] ARM: shmobile: r8a7790: Correct mask for GIC PPI
 interrupts
In-Reply-To: <CANqRtoQOs_VFku4+PKvyY1Gu0M56nfGXwratrP5qqVYxMCAMpA@mail.gmail.com>
References: <1421329844-19707-1-git-send-email-geert+renesas@glider.be>
 <1421329844-19707-3-git-send-email-geert+renesas@glider.be>
 <CANqRtoQOs_VFku4+PKvyY1Gu0M56nfGXwratrP5qqVYxMCAMpA@mail.gmail.com>
Message-ID: <20150116021551.GA19790@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 10:49:33AM +0900, Magnus Damm wrote:
> Hi Geert,
> 
> On Thu, Jan 15, 2015 at 10:50 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > R-Car H2 (r8a7790) contains four Cortex-A15 and four Cortex-A7 cores,
> > hence the second interrupt specifier cell for Private Peripheral
> > Interrupts should use "GIC_CPU_MASK_SIMPLE(8)", to make sure interrupts
> > can be delivered to all 8 processor cores.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Untested
> >
> > v2:
> >   - Drop RFC status after receiving confirmation from Liviu Dudau.
> 
> Thanks for your work on this.
> 
> I see the "untested" word above which makes me think we should test
> both Big and Little boot modes on r8a7790. The default "Big" mode
> where CA15 is used usually gets a lot of attention, but little mode
> with CA7 boot should also work with the same kernel image.

For now I have marked these as deferred pending testing.
