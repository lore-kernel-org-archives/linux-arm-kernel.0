From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 12 Sep 2014 15:45:12 +0800
Subject: [PATCH] watchdog: imx2_wdt: add restart handler support
In-Reply-To: <299ae9bd88c049ea833e964e4b5f54a0@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1410421661-15298-1-git-send-email-jingchang.lu@freescale.com>
 <20140911155522.GB13052@roeck-us.net>
 <299ae9bd88c049ea833e964e4b5f54a0@BL2PR03MB467.namprd03.prod.outlook.com>
Message-ID: <20140912074510.GJ18566@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 10:42:10AM +0800, Lu Jingchang-B35083 wrote:
> >> @@ -77,6 +81,31 @@ static const struct watchdog_info imx2_wdt_info = {
> >>  	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> >>  };
> >>
> >> +static int imx2_restart_handler(struct notifier_block *this, unsigned
> >long mode,
> >> +				void *cmd)
> >> +{
> >> +	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
> >
> >In the original code this value is conditional depending on cpu_is_mx1().
> >Are there any implications for this reset mechanism ? Does mx1 have a
> >different watchdog driver ?
> >
> Hi, Shawn, is this driver also used by the mx1 SoC? 
> The imx2_wdt.c says it is for IMX2 and later processors, so when moving the
> restart function, I removed the cpu_is_mx1() condition determination, Thanks.

I think the driver only works for i.MX2 and later ones.

Shawn
