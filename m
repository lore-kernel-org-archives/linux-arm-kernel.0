From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 18 Sep 2018 09:38:22 +0200
Subject: [PATCH 0/4] Add i.MX6ULZ SoC support
In-Reply-To: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
References: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <e82e2894-2a0d-0084-913c-b7c6d966fc13@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

Am 18.09.2018 um 08:19 schrieb Anson Huang:
> This patch set adds i.MX6ULZ SoC support, i.MX6ULZ is a new SoC of
> i.MX6 family, compared to i.MX6ULL, it removes below modules:
>
>     - UART5/UART6/UART7/UART8;
>     - PWM5/PWM6/PWM7/PWM8;
>     - eCSPI3/eCSPI4;
>     - CAN1/CAN2;
>     - FEC1/FEC2;
>     - I2C3/I2C4;
>     - EPIT2;
>     - LCDIF;
>     - GPT2;
>     - TSC;
>
> And i.MX6ULZ has same soc_id as i.MX6ULL, but SRC_SBMR2 bit[6] is
> to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and
> 1'b0 means i.MX6ULL. i.MX6ULZ reuse most of i.MX6UL/i.MX6ULL code,
> just add the new CPU type and remove those non-exist modules from dtb.
>
> Anson Huang (4):
>   ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support
>   ARM: imx: add i.mx6ulz msl support
>   clk: imx6ul: add i.mx6ulz support
>   dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
>
>  

i recommend the following patch order:
ARM: imx: add i.mx6ulz msl support
clk: imx6ul: add i.mx6ulz support
dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support

Stefan
