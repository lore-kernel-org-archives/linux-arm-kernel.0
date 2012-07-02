From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 2 Jul 2012 09:52:09 +0800
Subject: [PATCH RESEND 3/5] can: flexcan: adopt pinctrl support
In-Reply-To: <4FF0D401.4050101@pengutronix.de>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
 <1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
 <4FF0D401.4050101@pengutronix.de>
Message-ID: <20120702015206.GA21003@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 12:49:37AM +0200, Marc Kleine-Budde wrote:
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > +	if (IS_ERR(pinctrl))
> > +		return PTR_ERR(pinctrl);
> > +
> >  	if (pdev->dev.of_node) {
> >  		const u32 *clock_freq_p;
> 
> I'm on mx28 and trying to load the flexcan driver via DT, but
> devm_pinctrl_get_select_default fails with -19.
> 
You need to have pinctrl state setup in dts, some like:

http://article.gmane.org/gmane.linux.ports.arm.kernel/174148

> What am I doing wrong? Will this fail with the same error on non DT
> platforms?
> 
No, it will not, because a dummy pinctrl state is provided by
calling pinctrl_provide_dummies() in mx28_soc_init().

-- 
Regards,
Shawn
