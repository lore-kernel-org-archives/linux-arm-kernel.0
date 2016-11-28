From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 28 Nov 2016 12:09:33 +0100
Subject: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
In-Reply-To: <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
 <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com>
 <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
 <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com>
Message-ID: <CAPDyKFp9rbGz=1PbAndKxvpv49H9DF5SWa=FfAcrMiYRceXOQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>
>     Could you please tell me the requirement of "op_code" parameter in
>     mmc_send_tuning()?
>     According to mmc_send_tuning(),it seems that tuning command(CMD19/CMD21)
>     is required. Thus device will not response mmc_send_tuning() if current
>     speed mode doesn't support tuning command.
>     Please correct me if I am wrong.
>

When the mmc core decides it's time to execute tuning, it invokes the
->execute_tuning() host ops, which has the "opcode" as a parameter.
You should be able to use it when calling mmc_send_tuning().

[...]

Kind regards
Uffe
