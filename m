From: robh@kernel.org (Rob Herring)
Date: Sat, 21 Jan 2017 14:28:52 -0600
Subject: [PATCH 02/11] [media] s5p-mfc: Adding initial support for MFC
 v10.10
In-Reply-To: <1484733729-25371-3-git-send-email-smitha.t@samsung.com>
References: <1484733729-25371-1-git-send-email-smitha.t@samsung.com>
 <CGME20170118100723epcas5p132e0ebfad38261bed95cffc47334f9dc@epcas5p1.samsung.com>
 <1484733729-25371-3-git-send-email-smitha.t@samsung.com>
Message-ID: <20170121202852.pxxfxpqwjxewjoj5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 03:32:00PM +0530, Smitha T Murthy wrote:
> Adding the support for MFC v10.10, with new register file and
> necessary hw control, decoder, encoder and structural changes.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: devicetree at vger.kernel.org 
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  .../devicetree/bindings/media/s5p-mfc.txt          |    1 +
>  drivers/media/platform/s5p-mfc/regs-mfc-v10.h      |   36 ++++++++++++++++
>  drivers/media/platform/s5p-mfc/s5p_mfc.c           |   30 +++++++++++++
>  drivers/media/platform/s5p-mfc/s5p_mfc_common.h    |    4 +-
>  drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c      |    4 ++
>  drivers/media/platform/s5p-mfc/s5p_mfc_dec.c       |   44 +++++++++++---------
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c       |   21 +++++----
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c    |    9 +++-
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h    |    2 +
>  9 files changed, 118 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/media/platform/s5p-mfc/regs-mfc-v10.h
> 
> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> index 2c90128..b70c613 100644
> --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> @@ -13,6 +13,7 @@ Required properties:
>  	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
>  	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
>  	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
> +	(f) "samsung,mfc-v10" for MFC v10 present in a variant of Exynos7 SoC

You are up to v10 in how many SoCs? Please stop with versions and use 
SoC numbers. It's one thing to use versions when you have many SoCs per 
version, but that doesn't seem to be happening here.

Rob
