From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 29 Mar 2016 00:19:29 +0800
Subject: [RFC PATCH] drivers: pinctrl: add driver for Allwinner A64 SoC
In-Reply-To: <CABHD4K-nD9EvbgOPA2WH0q66csqVv18tmeTOBe87ACr4nuQM0A@mail.gmail.com>
References: <1451582246-32373-1-git-send-email-andre.przywara@arm.com>
 <CABHD4K-nD9EvbgOPA2WH0q66csqVv18tmeTOBe87ACr4nuQM0A@mail.gmail.com>
Message-ID: <CAGb2v64sv7CuuTC8fZV0spmiC=MYM3iqABr-EOC9oheXQ10C3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 12:15 AM, Amit Tomer <amittomer25@gmail.com> wrote:
> Hello ,
>
>> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 11),
>> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
>> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
>> +                 SUNXI_FUNCTION(0x2, "mic"),           /* DATA */
>> +                 SUNXI_FUNCTION_IRQ(0x6, 11)),         /* EINT11 */
>> +};
>> +
>
> Sorry to intervene here but is there any specific reason for not
> covering Bank from PL0 - PL12(as it is mentioned in Datasheet) ?


The PL bank is a separate controller (R_PIO), and would be covered by
a separate driver.
See the other sunxi drivers.

ChenYu
