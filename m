From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Mar 2015 15:15:55 +0000
Subject: [PATCH 6/9] ARM: dt: dove: add Dove PMU DT entry to dove.dtsi
In-Reply-To: <5508439F.4000507@gmail.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7tB-0003mM-1L@rmk-PC.arm.linux.org.uk>
 <55072092.9040207@free-electrons.com>
 <20150317134335.GV8656@n2100.arm.linux.org.uk>
 <5508439F.4000507@gmail.com>
Message-ID: <20150317151555.GX8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 04:09:19PM +0100, Sebastian Hesselbarth wrote:
> If we do this, we should have a look at syscon and potentially also
> simple-mfd which will allow us to share the registers and register
> platform_devices for the sub-nodes.
> 
> The current pmu power/reset/irq can still use the extra locking
> and directly access MMIO registers - but for the others we should
> really look into using regmaps.
> 
> The only thing here is that power domain descriptions are also encoded
> as direct sub-nodes of the pmu node, right?

Yes, I've been debating about putting those under a domains { } sub-node,
like we do with the ports { } sub-node for of-graph stuff.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
