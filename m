From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Apr 2014 00:09:24 +0100
Subject: [PATCH 73/75] ARM: l2c: move L2 cache register saving to a
 more sensible location
In-Reply-To: <533B0D6D.1080803@wwwdotorg.org>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaF-0007Hv-Nv@rmk-PC.arm.linux.org.uk> <533B0BC1.6080608@wwwdotorg.org>
 <533B0D6D.1080803@wwwdotorg.org>
Message-ID: <20140401230924.GE7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 01:03:09PM -0600, Stephen Warren wrote:
> On 04/01/2014 12:56 PM, Stephen Warren wrote:
> > On 03/28/2014 09:20 AM, Russell King wrote:
> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > EXCEPT this one patch, the series,
> > Tested-by: Stephen Warren <swarren@nvidia.com>
> > (on Tegra20/Toshiba AC100 and Tegra30/Beaver)
> > 
> > And any part which touches Tegra code,
> > Acked-by: Stephen Warren <swarren@nvidia.com>
> > 
> > However, this one patch causes boot failures on the Toshiba AC100,
> > Springbank/Seaboard, and I would assume any Tegra20 system. I haven't
> > investigated what the problem is; do you need me to and/or have any clues?
> 
> Ah, disabling CONFIG_CPU_IDLE "fixes" this.

Still brings up the question of what's going on here.  Another thing
could be that enabling BRESP is causing you problems.  You could
try disabling that code too, though why that would happen only with
CPU IDLE I'm not sure.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
