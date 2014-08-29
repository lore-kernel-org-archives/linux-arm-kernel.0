From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Aug 2014 09:29:36 +0200
Subject: [PATCH v4 3/5] ARM: tegra: Initialize interrupt controller from DT
In-Reply-To: <53FFF335.1020402@gmail.com>
References: <1409239879-12376-1-git-send-email-thierry.reding@gmail.com>
 <1409239879-12376-3-git-send-email-thierry.reding@gmail.com>
 <53FFF335.1020402@gmail.com>
Message-ID: <20140829072935.GF13106@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 08:57:49AM +0530, Varka Bhadram wrote:
> On 08/28/2014 09:01 PM, Thierry Reding wrote:
> >From: Thierry Reding <treding@nvidia.com>
> >
> >Obtains the register ranges for the legacy interrupt controller from DT
> >and provide hard-coded values as fallback.
> >
> (...)
> 
> >+static const struct tegra_ictlr_soc tegra30_ictlr_soc = {
> >+	.num_ictlrs = 5,
> >+};
> >+
> >+static const struct of_device_id ictlr_matches[] = {
> >+	{ .compatible = "nvidia,tegra30-ictlr", .data = &tegra30_ictlr_soc },
> >+	{ .compatible = "nvidia,tegra20-ictlr", .data = &tegra20_ictlr_soc },
> >+	{ }
> >+};
> >+
> >+static const struct of_device_id gic_matches[] = {
> >+	{ .compatible = "arm,cortex-a15-gic", },
> >+	{ .compatible = "arm,cortex-a9-gic", },
> >+	{ }
> >+};
> >+
> >
> Missed MODULE_DEVICE_TABLE(of, ...)....?

The driver isn't useful as a module, so I don't think that's necessary.
I'm not even sure it could be loaded that late in the process. Without
it peripheral interrupts don't work properly, so loading this from the
filesystem doesn't work (unless it's in an initrd), but perhaps even
that won't work. I'm not aware of anyone actually ever trying to build
it as a module.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/3f12e3f7/attachment.sig>
