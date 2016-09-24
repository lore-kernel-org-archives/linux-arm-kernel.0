From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 24 Sep 2016 16:35:05 +0800
Subject: [PATCH v3 0/4] regulator: axp20x: support AXP803/AXP813 variants
In-Reply-To: <cover.1474621107.git.moinejf@free.fr>
References: <cover.1474621107.git.moinejf@free.fr>
Message-ID: <CAGb2v65LjjB_vM46yurKOcw6mMaxW3pXTHwbxQO6L1BTOnTUmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 4:58 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> This patch series adds support for the X-Powers AXP803 and AXP813 PMICs.
> It is based on the previous patch series
>         regulator: axp20x: Simplify various code
>
> v3:
> - put the code of the new devices in new files instead of in the common
>   axp20x file.
> - fix errors about the regulators and interrupts
> v2:
> - fix lack of support of dcdc frequency
> - notice that the AXP803 is also handled
> - send the patch to the DT maintainers
>
> Jean-Francois Moine (4):
>   regulator: axp20x: move device independant parts to new files
>   regulator: axp20x: duplicate the MFD axp20x-rsb code
>   regulator: axp20x: add the AXP803
>   regulator: axp20x: add the AXP813

NAK. Please follow the axp20x mfd and sub-device driver design we
already have.

ChenYu

>  Documentation/devicetree/bindings/mfd/axp20x.txt |  29 ++-
>  drivers/mfd/axp20x.c                             |  15 +
>  drivers/regulator/Makefile                       |   3 +-
>  drivers/regulator/axp-regulator.c                | 347 +++++++++++++++++++
>  drivers/regulator/axp-regulator.h                | 133 ++++++++
>  drivers/regulator/axp20x-regulator.c             | 415 ++---------------------
>  drivers/regulator/axp803.c                       | 225 ++++++++++++
>  drivers/regulator/axp813.c                       | 229 +++++++++++++
>  include/linux/mfd/axp20x.h                       |   2 +
>  9 files changed, 1012 insertions(+), 388 deletions(-)
>  create mode 100644 drivers/regulator/axp-regulator.c
>  create mode 100644 drivers/regulator/axp-regulator.h
>  create mode 100644 drivers/regulator/axp803.c
>  create mode 100644 drivers/regulator/axp813.c
>
> --
> 2.10.0
>
