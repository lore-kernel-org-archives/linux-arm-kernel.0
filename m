From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 12 Jun 2018 16:33:05 +0200
Subject: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-4-o.rempel@pengutronix.de>
 <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
Message-ID: <2307533.g32PyNi9fl@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 12, 2018 2:42:12 PM CEST Oleksij Rempel wrote:
>  This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
> --Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924
> Content-Type: multipart/mixed; boundary="d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg";
>  protected-headers="v1"
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
>  "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: kernel at pengutronix.de, devicetree at vger.kernel.org,
>  linux-arm-kernel at lists.infradead.org, linux-clk at vger.kernel.org,
>  linux-kernel at vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
>  Liam Girdwood <lgirdwood@gmail.com>,
>  Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
>  Mark Rutland <mark.rutland@arm.com>,
>  Michael Turquette <mturquette@baylibre.com>,
>  Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
>  Russell King <linux@armlinux.org.uk>
> Message-ID: <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
> Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
> References: <20180517055014.6607-1-o.rempel@pengutronix.de>
>  <20180517055014.6607-4-o.rempel@pengutronix.de>
> In-Reply-To: <20180517055014.6607-4-o.rempel@pengutronix.de>
> 
> --d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg
> Content-Type: text/plain; charset=utf-8
> Content-Language: en-US
> Content-Transfer-Encoding: quoted-printable
> 
> Hi Rafael,
> 
> Last version of this patch was send at 17.05.2018. No other comment was
> provided and this patch is a blocker for other patches in this serie.
> Can you please give some feedback on it.

I would have done that had I not missed the patch.

Which probably wouldn't have happened had you CCed it to linux-pm.

Anyway, I have no particular problems with exporting pm_power_off_prepare via
EXPORT_SYMBOL_GPL().

> 
> On 17.05.2018 07:50, Oleksij Rempel wrote:
> > Export pm_power_off_prepare. It is needed to implement power off on
> > Freescale/NXP iMX6 based boards with external power management
> > integrated circuit (PMIC).
> >=20
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  kernel/reboot.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index e4ced883d8de..83810d726f3e 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -49,6 +49,7 @@ int reboot_force;
> >   */
> > =20
> >  void (*pm_power_off_prepare)(void);
> > +EXPORT_SYMBOL_GPL(pm_power_off_prepare);
> > =20
> >  /**
> >   *	emergency_restart - reboot the system
> >=20
> 
> 
> --d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg--
> 
> --Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924
> Content-Type: application/pgp-signature; name="signature.asc"
> Content-Description: OpenPGP digital signature
> Content-Disposition: attachment; filename="signature.asc"
> 
> 
> --Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924--
> 
