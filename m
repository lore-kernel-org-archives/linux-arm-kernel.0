From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 30 Jul 2013 16:00:29 +0800
Subject: [PATCH 1/2] pinctrl: imx: Add exception hook for select input
In-Reply-To: <20130730075018.GD12382@S2101-09.ap.freescale.net>
References: <1375152857-32177-1-git-send-email-peter.chen@freescale.com>
 <20130730075018.GD12382@S2101-09.ap.freescale.net>
Message-ID: <20130730080028.GA8540@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 03:50:21PM +0800, Shawn Guo wrote:
> On Tue, Jul 30, 2013 at 10:54:16AM +0800, Peter Chen wrote:
> > At some i.mx platforms the select input pin configuration may
> > not be at common select input register region due to IC found
> > the pin select pin configuration missing very late (Eg, ECO stage),
> > so this pin's select input register is at other register space at
> > pinctrl module. One typical example is USB OTG ID pin at i.mx6q is
> > at IOMUXC_IOMUXC_GPR1.
> 
> Do you know any other case except this USB OTG ID pin on imx6q?  If this
> is the only case, I'm wondering if we could work it around in machine
> code mach-imx6q.c to avoid the churn of pinctrl driver?
> 

I searched the RM, this is the only one. If you don't think we need
to consider if it will occur in the future, I am OK to move it at machine
code, but every mx6q board need it if it does not use default select input
value.

-- 

Best Regards,
Peter Chen
