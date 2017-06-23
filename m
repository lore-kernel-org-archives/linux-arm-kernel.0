From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Jun 2017 13:52:45 -0500
Subject: [PATCH 12/16] mmc: host: omap_hsmmc: Add support to set IODELAY
 values
In-Reply-To: <20170616124544.15046-13-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
 <20170616124544.15046-13-kishon@ti.com>
Message-ID: <20170623185245.e4frut72cf6jhzb4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 06:15:40PM +0530, Kishon Vijay Abraham I wrote:
> The data manual of J6/J6 Eco recommends to set different IODELAY values
> depending on the mode in which the MMC/SD is enumerated in order to
> ensure IO timings are met.
> 
> Add support to set the IODELAY values depending on the various MMC
> modes using the pinctrl APIs.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   5 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mmc/host/omap_hsmmc.c                      | 152 ++++++++++++++++++++-
>  2 files changed, 154 insertions(+), 3 deletions(-)
