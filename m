From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 23 Mar 2018 11:26:02 +0100
Subject: [PATCH] reset: uniphier: add ethernet reset control support for
 PXs3
In-Reply-To: <CAK7LNARk3-_DdMcOd4=Tjr0hLO8h=FieQLqye27w8BAbZW-qJA@mail.gmail.com>
References: <1521781954-20526-1-git-send-email-hayashi.kunihiko@socionext.com>
 <CAK7LNARk3-_DdMcOd4=Tjr0hLO8h=FieQLqye27w8BAbZW-qJA@mail.gmail.com>
Message-ID: <1521800762.3406.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-03-23 at 19:16 +0900, Masahiro Yamada wrote:
> 2018-03-23 14:12 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> > Add reset lines for ethernet controller on PXs3 SoC.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  drivers/reset/reset-uniphier.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> > index e8bb023..fd3afbd 100644
> > --- a/drivers/reset/reset-uniphier.c
> > +++ b/drivers/reset/reset-uniphier.c
> > @@ -121,6 +121,8 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
> >  static const struct uniphier_reset_data uniphier_pxs3_sys_reset_data[] = {
> >         UNIPHIER_RESETX(2, 0x200c, 0),          /* NAND */
> >         UNIPHIER_RESETX(4, 0x200c, 2),          /* eMMC */
> > +       UNIPHIER_RESETX(6, 0x200c, 9),          /* Ether0 */
> > +       UNIPHIER_RESETX(7, 0x200c, 10),         /* Ether1 */
> >         UNIPHIER_RESETX(8, 0x200c, 12),         /* STDMAC */
> >         UNIPHIER_RESETX(12, 0x200c, 4),         /* USB30 link (GIO0) */
> >         UNIPHIER_RESETX(13, 0x200c, 5),         /* USB31 link (GIO1) */
> > --
> > 2.7.4
> > 
> 
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thank you, applied to reset/next.

regards
Philipp
