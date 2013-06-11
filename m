From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 11 Jun 2013 15:17:09 -0700
Subject: [PATCH V3 1/4] ARM: tegra30: clocks: Fix pciex clock registration
In-Reply-To: <51AE3B18.9010604@wwwdotorg.org>
References: <1370372252-4332-1-git-send-email-jagarwal@nvidia.com>
 <51AE3B18.9010604@wwwdotorg.org>
Message-ID: <20130611221709.8816.15602@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-06-04 12:08:08)
> On 06/04/2013 12:57 PM, Jay Agarwal wrote:
> > Registering pciex as peripheral clock instead of fixed clock
> > as tegra_perih_reset_assert(deassert) api of this clock api
> > gives warning and ultimately does not succeed to assert(deassert).
> > 
> > Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> > ---
> > Patch is based on remotes/gitorious_thierryreding_linux/tegra/next and should be applied on top of this.
> 
> For this change, Mike may as well apply it directly to the clock tree.
> Thierry can then pick it up when he rebases his tegra/next tree.
> 
> That said, I don't think you should need any of the
> TEGRA_CLK_DUPLICATE() entries; the PCIe driver should get its clocks
> from device tree now, and hence the driver name in the clock
> registration shouldn't be necessary. All of these TEGRA_CLK_DUPLICATE()
> entries should be removed en mass sometime soon with luck. So, can you
> simply leave the two TEGRA_CLK_DUPLICATE() entries untouched, rather
> than changing them?

Ping on this patch.  I can take it through my tree, but is there going
to be rework based on Stephen's comments?

Regards,
Mike
