From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 11 Jan 2012 09:40:07 +0800
Subject: [PATCH 4/6] arm/dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <CAOMZO5Ax_+sWM_0gULkvu+rzy3f-FDzVOKMxhY=dgk8hBMvXEA@mail.gmail.com>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-5-git-send-email-richard.zhao@linaro.org>
 <CAOMZO5Ax_+sWM_0gULkvu+rzy3f-FDzVOKMxhY=dgk8hBMvXEA@mail.gmail.com>
Message-ID: <20120111014006.GD2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 11:33:10PM -0200, Fabio Estevam wrote:
> Hi Richard,
> 
> On Fri, Jan 6, 2012 at 1:25 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> > ?arch/arm/boot/dts/imx6q-sabrelite.dts | ? 12 ++++++++++++
> > ?1 files changed, 12 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > index 3f4b45e..567b664 100644
> > --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> > +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > @@ -44,6 +44,18 @@
> > ? ? ? ? ? ? ? ? ? ? ? ?uart2: uart at 021e8000 {
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?status = "okay";
> > ? ? ? ? ? ? ? ? ? ? ? ?};
> > +
> > + ? ? ? ? ? ? ? ? ? ? ? i2c at 021a0000 { /* I2C1 */
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? status = "okay";
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clock-frequency = <100000>;
> > +
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? codec: sgtl5000 at 0a {
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? compatible = "fsl,sgtl5000";
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? reg = <0x0a>;
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? VDDA-supply = <&reg_2P5V>;
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? VDDIO-supply = <&reg_3P3V>;
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? };
> > + ? ? ? ? ? ? ? ? ? ? ? };
> > ? ? ? ? ? ? ? ?};
> > ? ? ? ?};
> >
> 
> I don't see a  sound/soc/imx/imx-sgtl5000.c file yet, so I am
> wondering how did you test this?
> 
> Maybe I missed a patch. Could you please clarify?
I test it using linaro freescale landing team kernel. Actually
I'm upstreaming the audio work I did for linaro. Because audio
involves too much subsystem, I split it into several set of patch.
Finally, you'll see imx-sgtl5000.c.

Thanks
Richard
> 
> Regards,
> 
> Fabio Estevam
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
