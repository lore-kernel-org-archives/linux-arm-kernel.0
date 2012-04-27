From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 16:11:22 +0800
Subject: [PATCH v3 2/4] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <20120427071104.GS9142@game.jcrosoft.org>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <1335451227-27709-2-git-send-email-b29396@freescale.com>
 <20120426144446.GN9142@game.jcrosoft.org>
 <20120426151536.GO9142@game.jcrosoft.org>
 <20120427054842.GJ2234@S2101-09.ap.freescale.net>
 <20120427062816.GQ9142@game.jcrosoft.org>
 <20120427072503.GP2234@S2101-09.ap.freescale.net>
 <20120427071104.GS9142@game.jcrosoft.org>
Message-ID: <20120427081120.GT2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 09:11:04AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> except duplicate bindings instead having common one make no sense either
> 
> so imx, at91 and ST (STB SoC and other does have the same type of pin IP
> 
> to not come with a common bindig means we are doint the same crap as before
> 
> with switch to DT
> 
It can be every different in hardware details from one pin based
controller to another.  mxs pinctrl is another pin based IP, and Dong
tried to approach a binding working good for both imx and mxs, but in
the end we agree imx binding does not work so good for mxs, and vice
versa.  And that's why pinctrl core binding design leaves out the
platform specific binding.

-- 
Regards,
Shawn
