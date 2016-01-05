From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jan 2016 11:21:44 +0100
Subject: [PATCH v2 3/3] ARM64: dts: mt8173: Add CPU OPP,
 clock and regulator supply properties
In-Reply-To: <20151228031340.GD3598@ubuntu>
References: <1451197318-12418-1-git-send-email-pi-cheng.chen@linaro.org>
 <1451197318-12418-4-git-send-email-pi-cheng.chen@linaro.org>
 <20151228031340.GD3598@ubuntu>
Message-ID: <3310024.mO5K6yH9vU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 December 2015 08:43:40 Viresh Kumar wrote:
> On 27-12-15, 14:21, Pi-Cheng Chen wrote:
> > Add operating-points-v2, clock, and regulator supply properties
> > required by mt8173-cpufreq driver to enable it.
> > 
> > Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> > ---
> > This patch is based on the patch[1] that adds underlying clock MUX for
> > MT8173 which is needed by mt8173-cpufreq driver but not yet picked.
> > 
> > [1] http://article.gmane.org/gmane.linux.kernel.clk/325
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
> >  2 files changed, 108 insertions(+)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

This patch is now in linux-next through Rafael's pm tree, and it breaks the
arm64 build:

        arm64-defconfig
Error: ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:132.24-25 syntax error


Please revert.

In the future, please send all dts changes through the proper maintainer
channels (-> Mattias -> arm-soc), and make sure they actually build.

	Arnd
