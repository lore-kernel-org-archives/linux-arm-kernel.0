From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 6 Jan 2015 16:14:28 +0100
Subject: [PATCH v5 3/3] ARM: tegra: Add thermal reset (thermtrip) support
 to PMC
In-Reply-To: <1420541578-27968-4-git-send-email-mikko.perttunen@kapsi.fi>
References: <1420541578-27968-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1420541578-27968-4-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <20150106151427.GQ31830@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 12:52:58PM +0200, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> This adds a device tree controlled option to enable PMC-based
> thermal reset in overheating situations. Thermtrip is supported on
> Tegra30, Tegra114 and Tegra124. The thermal reset only works when
> the thermal sensors are calibrated, so a soctherm driver is also
> required.
> 
> The thermtrip event is triggered by the soctherm block, and all
> soctherm sensors default to showing a temperature of zero Celsius
> before they are initialized. Because of this, it is safe to initialize
> thermtrip and soctherm in any order.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)

This looks good to me. I'm not sure if I asked before, but can this be
tested? Can we somehow trick thermtrip into reporting a temperature that
would trigger this?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/e4994fee/attachment.sig>
