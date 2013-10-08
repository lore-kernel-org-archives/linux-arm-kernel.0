From: horms@verge.net.au (Simon Horman)
Date: Tue, 8 Oct 2013 10:25:51 +0900
Subject: [PATCH 00/05] ARM: shmobile: KZM9D Multiplatform update
In-Reply-To: <CANqRtoTr44CXaeMaScp_33Z9Tm7mCwt2EPtfaMu5oPWE8Vkb0Q@mail.gmail.com>
References: <20131001103255.813.65710.sendpatchset@w520>
 <19181221.pjTBb56TDE@avalon> <20131004082541.GA9988@verge.net.au>
 <CANqRtoTr44CXaeMaScp_33Z9Tm7mCwt2EPtfaMu5oPWE8Vkb0Q@mail.gmail.com>
Message-ID: <20131008012549.GB11179@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 05:55:47PM +0900, Magnus Damm wrote:
> On Fri, Oct 4, 2013 at 5:25 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Oct 04, 2013 at 09:47:34AM +0200, Laurent Pinchart wrote:
> >> Hi Magnus,
> >>
> >> Thank you for the patches.
> >>
> >> On Tuesday 01 October 2013 19:32:55 Magnus Damm wrote:
> >> > ARM: shmobile: KZM9D Multiplatform update
> >> >
> >> > [PATCH 01/05] ARM: shmobile: Sync KZM9D DTS with KZM9D reference DTS
> >> > [PATCH 02/05] ARM: shmobile: Use KZM9D without reference for multiplatform
> >> > [PATCH 03/05] ARM: shmobile: Remove non-multiplatform KZM9D reference
> >> > support
> >> > [PATCH 04/05] ARM: shmobile: Let KZM9D multiplatform boot with KZM9D DTB
> >> > [PATCH 05/05] ARM: shmobile: Remove KDM9D reference DTS
> >>
> >> I've reviewed the patches and they look fine to me.
> >>
> >> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>
> >> Does this call for the following patch on top of 05/05 ?
> >>
> >> >From b167bcd3182f0310b91e502672547e58addf17ef Mon Sep 17 00:00:00 2001
> >> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >> Date: Fri, 4 Oct 2013 09:44:34 +0200
> >> Subject: [PATCH] ARM: shmobile: kzm9d-reference: Drop -reference compatible
> >>  string
> >>
> >> The only system compatible string used for the KZM9D board is
> >> "renesas,kzm9d". Drop support for the old "renesas,kzm9d-reference"
> >> compatible string.
> >>
> >> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >> ---
> >>  arch/arm/mach-shmobile/board-kzm9d-reference.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
> >> index 054d8d5..d2c6466 100644
> >> --- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
> >> +++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
> >> @@ -34,7 +34,6 @@ static void __init kzm9d_add_standard_devices(void)
> >>
> >>  static const char *kzm9d_boards_compat_dt[] __initdata = {
> >>       "renesas,kzm9d",
> >> -     "renesas,kzm9d-reference",
> >>       NULL,
> >>  };
> >
> > In theory no because someone might be using a DTS with
> > renesas,kzm9d-reference in the wild. In practice I don't think
> > that is the case so I feel ok about this patch. Magnus, what
> > do you think?
> 
> Hi Simon and Laurent,
> 
> Thanks for the patch and the comments. I agree with Laurent that this
> patch series isn't complete without that patch, but at the same time I
> agree with Simon about current state. =) So I propose that this patch
> should be merged later on - in say half a year or so.

Sure. I will leave it hanging around in patchwork to try
and remind us (me) to do something with it later.

> Perhaps we should aim that the kernel used for the LTSI after
> LTSI-3.10 should include this fix?

Sounds reasonable.

> Another activity we need to deal with in the future is to depreciate
> the non-multiplatform board support. It's probably good to hear from
> the ARM SoC guys what kind of schedule they have in mind for the
> common ARM architecture bits.

Perhaps a discussion for another thread?
