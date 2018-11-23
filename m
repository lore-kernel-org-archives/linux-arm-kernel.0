From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 23 Nov 2018 14:05:23 +0200
Subject: [PATCH 4/5] drm: rcar-du: Add R8A7744 support
In-Reply-To: <TY1PR01MB17707049DE6A8FD71E032157C0DB0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1537553311-8831-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <5135719.5JoeYGyzrK@avalon>
 <TY1PR01MB17707049DE6A8FD71E032157C0DB0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <2739044.1unFEStFin@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

On Thursday, 22 November 2018 17:59:32 EET Fabrizio Castro wrote:
> On 15 October 2018 23:25 Laurent Pinchart wrote:
> > On Friday, 21 September 2018 21:08:30 EEST Fabrizio Castro wrote:
> >> From: Biju Das <biju.das@bp.renesas.com>
> >> 
> >> Add support for the R8A7744 DU (which is very similar to the R8A7743
> >> DU);
> >> it has 1 DPAD (RGB) output and 1 LVDS output.
> >> 
> >> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> >> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >> ---
> >> 
> >>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index c07d3f1..2c3d0e5 100644
> >> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> @@ -321,6 +321,7 @@ static const struct rcar_du_device_info
> >> rcar_du_r8a77970_info = {
> >>  static const struct of_device_id rcar_du_of_table[] = {
> >>  { .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
> >> +{ .compatible = "renesas,du-r8a7744", .data = &rzg1_du_r8a7743_info },
> >>  { .compatible = "renesas,du-r8a7745", .data = &rzg1_du_r8a7745_info },
> >>  { .compatible = "renesas,du-r8a77470", .data = &rzg1_du_r8a77470_info
> >>  },
> >>  { .compatible = "renesas,du-r8a7779", .data = &rcar_du_r8a7779_info },
> > 
> > This looks good to me. I would also apply this change:
> > 
> > @@ -41,7 +41,7 @@ static const struct rcar_du_device_info
> > rzg1_du_r8a7743_info = {
> >         .channels_mask = BIT(1) | BIT(0),
> >         .routes = {
> >                 /*
> > -                * R8A7743 has one RGB output and one LVDS output
> > +                * R8A774[34] has one RGB output and one LVDS output
> >                  */
> >                 [RCAR_DU_OUTPUT_DPAD0] = {
> >                         .possible_crtcs = BIT(1) | BIT(0),
> > 
> > With this,
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > There's no need to resubmit, I've applied the patch to my tree with the
> > above change.
> 
> I was expecting to see this patch at least on linux-next by now but it looks
> like it's not in there, could you please double check what happened to it?

I've sent the R-Car DU v4.21 pull request today, it should end up in linux-
next in the near future.

-- 
Regards,

Laurent Pinchart
