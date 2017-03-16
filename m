From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 16 Mar 2017 13:06:27 +0100
Subject: [PATCH v4 0/2] mmc: host: s3cmci: add device tree support
In-Reply-To: <1488417536-15110-1-git-send-email-sergio.prado@e-labworks.com>
References: <1488417536-15110-1-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <CAPDyKFqf=8aRO+=DS_adX+f5ZL3ea_nxp33+8UMvPRz0AqW_Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 March 2017 at 02:18, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> This series adds support for configuring Samsung's S3C24XX MMC/SD/SDIO
> controller via device tree.
>
> Tested on FriendlyARM mini2440, based on s3c2440 SoC.
>
> Changes since v3 (as suggested by Rob Herring)
> - describing properties that wasn't documented and removing unnecessary
>   comment in the device tree binding
>
> Changes since v2:
> - struct "s3cmci_drv_data" and flag "is2440" renamed
> - copying the whole driver data struct instead of only its member so
>   it will be easier to extend the information in the future
> - using mmc_of_parse() to read "cd-gpios" and "wp-gpios" properties
>   from device tree
>
> Changes since v1:
> - pinctrl description removed from DT binding
> - unit and label on DT binding renamed to mmc
>
> Sergio Prado (2):
>   dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO controller
>   mmc: host: s3cmci: allow probing from device tree
>
>  .../devicetree/bindings/mmc/samsung,s3cmci.txt     |  42 +++
>  drivers/mmc/host/s3cmci.c                          | 298 +++++++++++----------
>  drivers/mmc/host/s3cmci.h                          |   3 +-
>  3 files changed, 200 insertions(+), 143 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
>
> --
> 1.9.1
>

Sergio, can you please re-spin and address the comments from Jaehoon,
then I am happy to apply this!

Kind regards
Uffe
