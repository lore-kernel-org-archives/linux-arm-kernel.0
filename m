From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Jan 2018 18:00:22 -0800
Subject: [PATCH] arm64: dts: add #cooling-cells to CPU nodes
In-Reply-To: <1515631110.19513.5.camel@mhfsdcap03>
References: <20180110210706.2331225-1-arnd@arndb.de>
 <1515631110.19513.5.camel@mhfsdcap03>
Message-ID: <20180112020022.t4sw7ga7np2mntq7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 08:38:30AM +0800, Chunfeng Yun wrote:
> On Wed, 2018-01-10 at 22:06 +0100, Arnd Bergmann wrote:
> > dtc complains about the lack of #coolin-cells properties for the
> > CPU nodes that are referred to as "cooling-device":
> > 
> > arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu at 0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map at 0:cooling-device[0])
> > arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu at 100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map at 1:cooling-device[0])
> > 
> > Apparently this property must be '<2>' to match the binding.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > If this looks ok, I'd apply it directly to the fixes branch
> > for 4.15, as the warning is one that was introduced in this
> > release.

Actually, it's in next/dt (or at least this patch doesn't apply as it is to
fixes), so I've added it there.


-Olof
