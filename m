From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 9 Aug 2018 16:07:53 +0200
Subject: [GIT PULL 5/5] arm64: tegra: Device tree changes for v4.19-rc1
In-Reply-To: <51a19ec3-8b34-56f5-d9c7-69397d3d11ff@kapsi.fi>
References: <20180712154128.22705-1-thierry.reding@gmail.com>
 <20180712154128.22705-6-thierry.reding@gmail.com>
 <20180714212210.at4b2gcpopsznyxx@localhost>
 <20180803104318.GA28546@ulmo>
 <CAHMsQjU=nmpTnPK6Ryhui67YVANHExd=yRB4hp+upd7O-Tjn+Q@mail.gmail.com>
 <20180809102104.GB21639@ulmo>
 <51a19ec3-8b34-56f5-d9c7-69397d3d11ff@kapsi.fi>
Message-ID: <20180809140753.GH21639@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2018 at 01:34:37PM +0300, Mikko Perttunen wrote:
> On 09.08.2018 13:21, Thierry Reding wrote:
> > On Fri, Aug 03, 2018 at 07:26:04AM -0400, Anthony Eden wrote:
> > > Mesa support aside- if I start a computationally intensive job on the
> > > Jetson TX2 like building the Linux kernel on all cores, it will lock
> > > up. My only work around has been to disable the Denver CPU's. I don't
> > > think the tegra186 has upstream support to control the fan on the
> > > Jetson TX2, could this be a thermal problem?
> > 
> > Yes, I suppose this could be a thermal problem. Or it could be something
> > else entirely. We do support CPU frequency scaling on Tegra X2, so what
> > you could do is keep the Denver CPUs enabled, but set the powersave CPU
> > frequency governor. That way it should use all the CPUs but at a lower
> > clock rate, which should also be able to avoid any thermal issues. This
> > could help determine whether or not the problem is thermal or something
> > else.
> > 
> > Also adding Mikko on Cc who wrote the Tegra186 driver, maybe he's aware
> > of any issues.
> 
> I haven't seen any issues myself, though I haven't stressed the CPU too
> heavily. We also have a thermal driver for Tegra186, so we could set up
> thermal throttling with a device tree change.

Do you have an example of how that would work? The DT bindings are a
little sparse on the specifics. It seems like something similar to what
we did on Tegra124 could be done on Tegra186.

Anthony: do you think you could come up with something suitable based on
what arch/arm/boot/dts/tegra124{.dtsi,-jetson-tk1.dts} and the device
tree bindings for Tegra186 contain in

	Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt

as well as

	include/dt-bindings/thermal/tegra186-bpmp-thermal.h

? That's provided that reducing the CPU frequency does indeed prevent
the lock up that you were seeing.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180809/f71f237b/attachment.sig>
