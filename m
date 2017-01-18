From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2017 22:39:48 +0000
Subject: [PATCH] ARM: smp: Remove CPU: shutdown notice
In-Reply-To: <fd4a4f48-f19e-dcac-c286-8e03db89e99a@gmail.com>
References: <20170117230714.6799-1-f.fainelli@gmail.com>
 <20170117232314.GI27312@n2100.armlinux.org.uk>
 <fd4a4f48-f19e-dcac-c286-8e03db89e99a@gmail.com>
Message-ID: <20170118223948.GR27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 03:39:45PM -0800, Florian Fainelli wrote:
> Well, for one it's inconsistent, and it also leaves room for subtle
> timing/caching issues with some platforms (OK, maybe not so much).
> Improving the speed and consistency was the primary motive.

Actually, it's not as inconsistent as you claim.

c68b0274fb3c ("ARM: reduce "Booted secondary processor" message to debug level")
dropped the corresponding pr_info() in the bringup path to debug level,
so to be consistent, this one should be dropped to debug level too.

Removing it arguably makes it more inconsistent!

So, I'd be willing to accept a patch lowering this to a pr_debug()
to make it more consistent with the bringup path, but otherwise the
consistency argument doesn't really stand.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
