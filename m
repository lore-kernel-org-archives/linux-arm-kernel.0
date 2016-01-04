From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2016 14:42:22 +0000
Subject: [RFC 6/9] clk: ti: add support for omap4 module clocks
In-Reply-To: <568A735D.2060309@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-7-git-send-email-t-kristo@ti.com>
 <20160101054815.21738.79820@quark.deferred.io>
 <568A20E5.6040005@ti.com>
 <CAMuHMdUZMUSYC1XHydVQHRibWtHw2=T-7nXe=5Pf4UCcb=mKTQ@mail.gmail.com>
 <568A735D.2060309@ti.com>
Message-ID: <20160104144221.GA5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 03:27:57PM +0200, Tero Kristo wrote:
> On 01/04/2016 12:21 PM, Geert Uytterhoeven wrote:
> >FWIW, there are small loops with just a cpu_relax() in various clock drivers
> >under drivers/clk/shmobile/.
> 
> Just did a quick profiling round, and the clk_enable/disable delay loops
> take anything from 0...1500ns, most typically consuming some 400-600ns. So,
> based on this, dropping the udelay and adding cpu_relax instead looks like a
> good change. I just verified that changing the udelay to cpu_relax works
> fine also, I just need to change the bail-out period to be something sane.

Was that profiling done with lockdep/lock debugging enabled or disabled?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
