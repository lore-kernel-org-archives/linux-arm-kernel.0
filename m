From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jun 2014 13:07:04 +0200
Subject: [RFC 04/10] memory: Add Tegra124 memory controller support
In-Reply-To: <1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
Message-ID: <9283417.yKmnrljUYI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 June 2014 22:49:44 Thierry Reding wrote:
> +static const struct tegra_mc_client tegra124_mc_clients[] = {
> +       {
> +               .id = 0x01,
> +               .name = "display0a",
> +               .swgroup = TEGRA_SWGROUP_DC,
> +               .smmu = {
> +                       .reg = 0x228,
> +                       .bit = 1,
> +               },
> +               .latency = {
> +                       .reg = 0x2e8,
> +                       .shift = 0,
> +                       .mask = 0xff,
> +                       .def = 0xc2,
> +               },
> +       }, {

This is a rather long table that I assume would need to get duplicated
and modified for each specific SoC. Have you considered to put the information
into DT instead, as auxiliary data in the iommu specifier as provided by
the device?

	Arnd
