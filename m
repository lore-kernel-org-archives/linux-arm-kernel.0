From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 14 Aug 2013 13:43:02 -0700
Subject: [PATCH] KVM: ARM: ignore guest L2 cache control SMCs on Highbank
 and OMAP
In-Reply-To: <520BE673.9010801@calxeda.com>
References: <1376472125-23350-1-git-send-email-andre.przywara@calxeda.com>
 <CAL_Jsq+vGd7+pw6YX0YNHO5rVSoiHCHbtXXdZ-3grnEcAOc38Q@mail.gmail.com>
 <520BE673.9010801@calxeda.com>
Message-ID: <20130814204302.GA8837@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 10:20:03PM +0200, Andre Przywara wrote:
> On 08/14/2013 08:54 PM, Rob Herring wrote:
> >On Wed, Aug 14, 2013 at 4:22 AM, Andre Przywara
> ><andre.przywara@calxeda.com> wrote:
> >>Guest kernels with CONFIG_L2X0 set (for instance Highbank or OMAP4)
> >>will trigger SMCs to handle the L2 cache controller (PL310).
> >>This will currently inject #UNDEFs and eventually stop the guest.
> >>
> >>We don't need explicit L2 cache controller handling on A15s anymore,
> >>so it is safe to simply ignore these calls and proceed with the next
> >>instruction.
> >>
> >>Signed-off-by: Andre Przywara <andre.przywara@calxeda.com>
> >>---
> >>  arch/arm/kvm/handle_exit.c | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >
> >At least for highbank, we can fix this in the kernel:
> 
> Yes, and we should do. But that won't fix older guest kernels, say
> Ubuntu 12.10 or the like. And I think this is a use case for
> virtualization, so we need both, guest and host fix.
> 
Agreed, but we need a more generic solution for the secure call
handling.  I've created a backlog item in Linaro's JIRA (CARD-801) for
this work, let's see how quickly we can get it approved and put on the
roadmap.

-Christoffer
