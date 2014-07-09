From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Wed, 9 Jul 2014 11:55:52 +0200
Subject: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and CPSW
In-Reply-To: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20140709095552.GA25154@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-07-08 18:46:39 [+0530], Mugunthan V N wrote:
> Adding hwmod data for CPSW and MDIO which is present in DRA7xx SoC

I reverted my patch, applied this one and after boot I got:

|platform 48485000.mdio: Cannot lookup hwmod 'davinci_mdio'
|cpsw 48484000.ethernet: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
|davinci_mdio 48485000.mdio: failed to get device clock
|davinci_mdio: probe of 48485000.mdio failed with error -2
|cpsw 48484000.ethernet: Random MACID = 46:c6:34:6f:8d:c6
| (null): fck is not found

with no eth0. Is there something with my setup? I still have the device
tree pieces I posted (in case there is something wrong with them).

Sebastian
