From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 2 Apr 2012 08:47:33 +0800
Subject: [PATCH v5 04/16] pwm: Add table-based lookup for static mappings
In-Reply-To: <20120401152042.GE2395@S2101-09.ap.freescale.net>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-5-git-send-email-thierry.reding@avionic-design.de>
 <20120329220342.GK4153@opensource.wolfsonmicro.com>
 <20120330050641.GA21823@avionic-0098.mockup.avionic-design.de>
 <20120330101800.GD21950@opensource.wolfsonmicro.com>
 <20120330103840.GB961@avionic-0098.mockup.avionic-design.de>
 <20120331143021.GA18382@avionic-0098.mockup.avionic-design.de>
 <20120401152042.GE2395@S2101-09.ap.freescale.net>
Message-ID: <20120402004730.GA910@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 11:20:46PM +0800, Shawn Guo wrote:
> On Sat, Mar 31, 2012 at 04:30:21PM +0200, Thierry Reding wrote:
...
> > The "bad"
> > thing is that it'll make the "pwm-names" property mandatory if more than a
> > single PWM is requested.
> > 
> You do not have to make it mandatory, but anyone requesting any pwm
> other than the first on in "pwms" list should fail.
> 
I should have put it this way.  If a client device does not have
"pwm-names" property in its node, it should fail when requesting pwm
with a name.  And if no name is given, the first pwm device in the
"pwms" list could just be returned.

-- 
Regards,
Shawn
