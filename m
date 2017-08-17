From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Aug 2017 16:22:11 +0200
Subject: [PATCH 1/3] sound: ASoC: tegra: Remove SoC-specific Kconfig
 depends and selects
In-Reply-To: <20170731102309.GE26667@ulmo>
References: <20170730112220.15525-1-contact@paulk.fr>
 <20170731102309.GE26667@ulmo>
Message-ID: <20170817142211.GH6854@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 12:23:09PM +0200, Thierry Reding wrote:
> On Sun, Jul 30, 2017 at 01:22:18PM +0200, Paul Kocialkowski wrote:
> > This removes the SoC-specific dependencies on the platform drivers,
> > as well as SoC-specific selections of platform drivers for the
> > machine drivers. The rationale behind this change is that the
> > dependencies are not actual build dependencies but run-time ones.
> > 
> > The previously listed SoCs were also incomplete: for instance, tegra124
> > uses the tegra30 platform drivers, which could not be built without
> > ARCH_TEGRA_3x_SOC set.
> > 
> > Descriptions of the tristates are also added to allow these options
> > to be set via defconfig/menuconfig.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  sound/soc/tegra/Kconfig | 42 ++++++++++++++----------------------------
> >  1 file changed, 14 insertions(+), 28 deletions(-)
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

Hi Mark,

do you want to pick this up, or would you rather provide an Acked-by so
that I can take it through the Tegra tree along with the defconfig
changes? I can provide a branch with this patch in case we ever need it
for conflict resolution.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170817/28bf0be1/attachment.sig>
