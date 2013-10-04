From: horms@verge.net.au (Simon Horman)
Date: Fri, 4 Oct 2013 17:25:42 +0900
Subject: [PATCH 00/05] ARM: shmobile: KZM9D Multiplatform update
In-Reply-To: <19181221.pjTBb56TDE@avalon>
References: <20131001103255.813.65710.sendpatchset@w520>
 <19181221.pjTBb56TDE@avalon>
Message-ID: <20131004082541.GA9988@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 09:47:34AM +0200, Laurent Pinchart wrote:
> Hi Magnus,
> 
> Thank you for the patches.
> 
> On Tuesday 01 October 2013 19:32:55 Magnus Damm wrote:
> > ARM: shmobile: KZM9D Multiplatform update
> > 
> > [PATCH 01/05] ARM: shmobile: Sync KZM9D DTS with KZM9D reference DTS
> > [PATCH 02/05] ARM: shmobile: Use KZM9D without reference for multiplatform
> > [PATCH 03/05] ARM: shmobile: Remove non-multiplatform KZM9D reference
> > support
> > [PATCH 04/05] ARM: shmobile: Let KZM9D multiplatform boot with KZM9D DTB
> > [PATCH 05/05] ARM: shmobile: Remove KDM9D reference DTS
> 
> I've reviewed the patches and they look fine to me.
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Does this call for the following patch on top of 05/05 ?
> 
> >From b167bcd3182f0310b91e502672547e58addf17ef Mon Sep 17 00:00:00 2001
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date: Fri, 4 Oct 2013 09:44:34 +0200
> Subject: [PATCH] ARM: shmobile: kzm9d-reference: Drop -reference compatible
>  string
> 
> The only system compatible string used for the KZM9D board is
> "renesas,kzm9d". Drop support for the old "renesas,kzm9d-reference"
> compatible string.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/board-kzm9d-reference.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
> index 054d8d5..d2c6466 100644
> --- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
> @@ -34,7 +34,6 @@ static void __init kzm9d_add_standard_devices(void)
>  
>  static const char *kzm9d_boards_compat_dt[] __initdata = {
>  	"renesas,kzm9d",
> -	"renesas,kzm9d-reference",
>  	NULL,
>  };

In theory no because someone might be using a DTS with
renesas,kzm9d-reference in the wild. In practice I don't think
that is the case so I feel ok about this patch. Magnus, what
do you think?
