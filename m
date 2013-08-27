From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 27 Aug 2013 10:17:21 -0600
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
In-Reply-To: <20130827182935.ff4005b60cc1ce80d32d5e46@canb.auug.org.au>
References: <20130827182935.ff4005b60cc1ce80d32d5e46@canb.auug.org.au>
Message-ID: <521CD111.9030905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2013 02:29 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in 
> arch/arm/boot/dts/tegra20-trimslice.dts between commit
> 30ca2226bea6 ("ARM: tegra: always enable USB VBUS regulators") from
> Linus' tree and commit 23f95ef2d951 ("ARM: tegra: use TEGRA_GPIO()
> in a couple more places") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no
> action is required).

> diff --cc arch/arm/boot/dts/tegra20-trimslice.dts

> usb at c5000000 { status = "okay"; -		nvidia,vbus-gpio = <&gpio
> TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>; };

That chunk isn't part of either of the two commits above.

It is however part of commit 103566e "arm: tegra: Remove obsolete
nvidia,vbus-gpio properties" from the USB tree, so it's fine that the
change is part of linux-next.

I'm just not sure if it's expected for that chunk to show up in this
merge resolution email? If it's normal, then there's no problem; the
issue would be with me not having too much git merge conflict
resolution experience:-)
