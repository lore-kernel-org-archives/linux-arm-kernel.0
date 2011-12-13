From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 13 Dec 2011 23:01:09 +0800
Subject: [PATCH V2 7/7] arm/imx6q: add cpufreq support
In-Reply-To: <20111213142033.GW27267@pengutronix.de>
References: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
 <1323757530-19402-8-git-send-email-richard.zhao@linaro.org>
 <20111213121940.GC10022@S2101-09.ap.freescale.net>
 <20111213142033.GW27267@pengutronix.de>
Message-ID: <20111213150107.GA1752@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 03:20:33PM +0100, Sascha Hauer wrote:
> On Tue, Dec 13, 2011 at 08:19:42PM +0800, Shawn Guo wrote:
> > On Tue, Dec 13, 2011 at 02:25:30PM +0800, Richard Zhao wrote:
> > > use cpu0 node property clock-frequency to check max frequency.
> > > 
> > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > ---
> > >  arch/arm/mach-imx/Kconfig        |    1 +
> > >  arch/arm/mach-imx/Makefile       |    2 +-
> > >  arch/arm/mach-imx/cpu_op-imx6q.c |   69 ++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 71 insertions(+), 1 deletions(-)
> > >  create mode 100644 arch/arm/mach-imx/cpu_op-imx6q.c
> > > 
> > NAK.
> > 
> > We really need to push people to help with cleanup and consolidation
> > effort rather than accepting patches on top of something that needs
> > to be cleaned up and consolidated, which will make the effort later
> > more difficult.
> 
> +1
ok, let's make it clear.
- move arch/arm/plat-mxc/cpufreq.c to drivers/cpufreq/
- consider whether opp help imx, at least for imx cpufreq drive to pass
operating table.
- fall back ways, maybe define in dts /soc like:
cpufreq {
	compatible = "fsl,imx-cpufreq";
	frequency = <100000000 800000000 500000000 200000000>;
	volatage = <1500000 1400000 1300000 1200000>;
};

Thanks
Richard
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
