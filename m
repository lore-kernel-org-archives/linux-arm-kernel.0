From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 20 Nov 2014 23:57:03 +0100 (CET)
Subject: [PATCH RFC 3/3] ARM: dts: enable power subsystem for i.MX28
In-Reply-To: <CAOMZO5AWOs8ODsru+ySsLb=R4ezDL19nK_z0zAXdbrDfPT8KhA@mail.gmail.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-4-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5AWOs8ODsru+ySsLb=R4ezDL19nK_z0zAXdbrDfPT8KhA@mail.gmail.com>
Message-ID: <1167895673.64469.1416524223868.JavaMail.open-xchange@oxbaltgw04.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 20. November 2014 um 22:32
> geschrieben:
>
>
> Hi Stefan,
>
> On Thu, Nov 20, 2014 at 6:14 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > This patch enables the power subsystem for all i.MX28 boards.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> > arch/arm/boot/dts/imx28.dtsi | 6 +++++-
> > 1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index 47f68ac..5c163a5 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -1022,8 +1022,12 @@
> > };
> >
> > power: power at 80044000 {
> > + compatible = "fsl,imx28-power";
>
> Should we have 'fsl,imx23-power' and 'fsl,imx28-power' as compatible strings?

yes, of course.

>
> Or ''fsl,mxs-power' could be used for both?

I think that would be a bad idea. I can't believe that all PMU register of
i.MX23 and i.MX28 are identical. So in the future we will have to distinguish
between them. It's better to do it now like most of the mxs driver does.

Stefan
