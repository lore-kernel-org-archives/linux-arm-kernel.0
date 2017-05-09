From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 May 2017 00:24:34 +0100
Subject: [PATCH v3 2/3] ARM: Silence first allocation with
 CONFIG_ARM_MODULE_PLTS=y
In-Reply-To: <fccefcb2-b711-0589-168a-714e55064279@gmail.com>
References: <20170427181902.28829-1-f.fainelli@gmail.com>
 <20170427181902.28829-3-f.fainelli@gmail.com>
 <fccefcb2-b711-0589-168a-714e55064279@gmail.com>
Message-ID: <20170509232433.GM22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 04:16:09PM -0700, Florian Fainelli wrote:
> On 04/27/2017 11:19 AM, Florian Fainelli wrote:
> > When CONFIG_ARM_MODULE_PLTS is enabled, the first allocation using the
> > module space fails, because the module is too big, and then the module
> > allocation is attempted from vmalloc space. Silence the first allocation
> > failure in that case by setting __GFP_NOWARN.
> 
> Russell, are you okay with this change? Do you have a preference as
> which tree should carry this patch series?

It looks sensible.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

No preference which tree it goes through...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
