From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 21 Jun 2014 17:43:17 +0800
Subject: [PATCH] ARM: imx: add cpuidle support for i.mx6sx
In-Reply-To: <20140621093325.GE18165@dragon>
References: <1403243045-8521-1-git-send-email-b20788@freescale.com>
 <20140621093325.GE18165@dragon>
Message-ID: <20140621094316.GC16239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 05:33:26PM +0800, Shawn Guo wrote:
> > @@ -66,7 +67,8 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
> >  int __init imx6q_cpuidle_init(void)
> >  {
> >  	/* Need to enable SCU standby for entering WAIT modes */
> > -	imx_scu_standby_enable();
> > +	if (!cpu_is_imx6sx())
> > +		imx_scu_standby_enable();
> 
> Hmm, why is SoloX special in this regarding?  Does SoloLite work well
> without this change?

Sorry.  I missed that SoloLite is handled by imx6sl_cpuidle_init()
separately.

Patch applied, thanks.

Shawn
