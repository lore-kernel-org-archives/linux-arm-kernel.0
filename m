From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 22 Apr 2016 00:32:54 +0200
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for rk3399 SoCs
In-Reply-To: <20160421214826.GA69116@google.com>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
 <20160421214826.GA69116@google.com>
Message-ID: <1828302.c0tldb2naZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 21. April 2016, 14:48:26 schrieb Brian Norris:
> Hi,
> 
> On Wed, Apr 20, 2016 at 11:15:50AM +0800, Jianqun Xu wrote:
> > This patch adds core dtsi file for rk3399 found on Rockchip
> > rk3399 SoCs, tested on rk3399 evb.
> > 
> > Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> > ---
> > 
> >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1744
> >  ++++++++++++++++++++++++++++++ 1 file changed, 1744 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3399.dtsi new file mode 100644
> > index 0000000..fa6fc2c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > @@ -0,0 +1,1744 @@
> 
> [...]
> 
> > +	emmc_phy: phy {
> > +		compatible = "rockchip,rk3399-emmc-phy";
> > +		reg-offset = <0xf780>;
> 
> This property is not documented. The current doc says we "require" reg,
> but you're kinda misusing it, I believe. At any rate, the current phy
> driver won't probe without 'reg'.

thanks for spotting this.

Please also note the changed binding [0] that I'm still hoping
will make it into 4.6.



[0] https://git.kernel.org/cgit/linux/kernel/git/kishon/linux-phy.git/log/?h=fixes


> > +		#phy-cells = <0>;
> > +		rockchip,grf = <&grf>;
> > +		status = "disabled";
> > +	};
> 
> [...]
> 
> Brian
