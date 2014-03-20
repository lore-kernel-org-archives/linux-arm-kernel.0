From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Mar 2014 15:19:34 +0000
Subject: [PATCH] ASoC: tda998x: Fix lack of required reg in DT
 documentation
In-Reply-To: <20140320155935.7a474173@armhf>
References: <20140320092639.48F68A6279@smtp3-g21.free.fr>
 <532ADFD8.80301@gmail.com> <20140320140156.5d768b1f@armhf>
 <532AEDE2.3080306@gmail.com> <20140320145221.09252bf6@armhf>
 <20140320143110.GU7528@n2100.arm.linux.org.uk>
 <20140320155935.7a474173@armhf>
Message-ID: <20140320151934.GV7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 03:59:35PM +0100, Jean-Francois Moine wrote:
> On Thu, 20 Mar 2014 14:31:10 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > 1. change the DT compatible strings the driver has to accept both
> >    nxp,tda19988 and nxp,tda19989, and set the appropriate device
> >    in the DT file (tda19988).  I'm a bit nervous about using
> >    "nxp,tda1998x" in case we're clashing with devices with different
> >    characteristics.
> 
> The Cubox is sold with either the TDA19988 or the TDA19989 (I don't
> know about the AMX33XX boards). Then, setting the exact type in the DT
> would ask for 2 differents DTs or for having two tda998x definitions in
> a same DT...

I'm not saying that it has to match the physical device fitted - I'm
merely suggesting not using nxp,tda1998x which could (and as Sebastian
has found, does) conflict with other devices with different properties.

We still auto-detect the exact device type by reading the ID register
because that's the most reliable way to detect exactly what kind of
device is fitted to the board.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
