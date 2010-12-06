From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 06 Dec 2010 11:55:09 +0100
Subject: [PATCH] support PMIC mc13892
In-Reply-To: <1291616735-29645-1-git-send-email-yong.shen@freescale.com> (yong
	shen's message of "Mon, 6 Dec 2010 14:25:35 +0800")
References: <1291616735-29645-1-git-send-email-yong.shen@freescale.com>
Message-ID: <87tyirnpbm.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<yong.shen@freescale.com> writes:

Hi,

> From: Yong Shen <yong.shen@linaro.org>
>
> add support for mc13892, tested on mx51 babbage board

Will review/test it asap on my efikamx. thanks for working on this :)

>
> Signed-off-by: Yong Shen <yong.shen@linaro.org>
> ---
>  drivers/mfd/Kconfig                   |    4 +
>  drivers/regulator/Kconfig             |    8 +
>  drivers/regulator/Makefile            |    1 +
>  drivers/regulator/mc13892-regulator.c |  647 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/mc13892.h           |   38 ++
>  5 files changed, 698 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/regulator/mc13892-regulator.c
>  create mode 100644 include/linux/mfd/mc13892.h

[...]

> +
> +static const int mc13892_vvideo[] = {
> +	2500000, 2600000, 270000, 2775000,
> +};

Should be :
static const int mc13892_vvideo[] = {
        270000, 2775000, 2500000, 2600000,
};

I've spotted this in my code some time ago. VVIDEO voltages are not
ascending order.


Arnaud
