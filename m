From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Jun 2014 18:25:14 +0800
Subject: [PATCH 15/22] pinctrl: sunxi: Add A23 PIO controller support
In-Reply-To: <20140525190827.GV10768@lukather>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-16-git-send-email-wens@csie.org>
 <20140525190827.GV10768@lukather>
Message-ID: <CAGb2v670r+imY1PPKXOvLGjHOTzgXaaUqP6SstsvrXFhMozAzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 26, 2014 at 3:08 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, May 23, 2014 at 03:51:18PM +0800, Chen-Yu Tsai wrote:
>> The A23 uses the same pin controller as previous SoC's from Allwinner.
>> Add support for the pins controlled by the main PIO controller.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   2 +
>>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>>  drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c          | 562 +++++++++++++++++++++
>>  4 files changed, 569 insertions(+)
>>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>> index d8d0656..93ce12e 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>> @@ -13,6 +13,8 @@ Required properties:
>>    "allwinner,sun6i-a31-pinctrl"
>>    "allwinner,sun6i-a31-r-pinctrl"
>>    "allwinner,sun7i-a20-pinctrl"
>> +  "allwinner,sun8i-a23-pinctrl"
>> +  "allwinner,sun8i-a23-r-pinctrl"
>
> This last line belongs in the R_PIO patch :)
>
>>  - reg: Should contain the register physical address and length for the
>>    pin controller.
>>
>> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
>> index da1e830..17a4281 100644
>> --- a/drivers/pinctrl/sunxi/Kconfig
>> +++ b/drivers/pinctrl/sunxi/Kconfig
>> @@ -32,4 +32,8 @@ config PINCTRL_SUN7I_A20
>>       def_bool PINCTRL_SUNXI || MACH_SUN7I
>>       select PINCTRL_SUNXI_COMMON
>>
>> +config PINCTRL_SUN8I_A23
>> +       def_bool PINCTRL_SUNXI || MACH_SUN8I
>> +       select PINCTRL_SUNXI_COMMON
>
> Since it's going to be merged in 3.16, you can just depend on MACH_SUN8I.

Just want to make sure before I send v2 of the whole series, this should be

        def_bool MACH_SUN8I
        select PINCTRL_SUNXI_COMMON

correct?

Or should it be

        bool
        depends on MACH_SUN8I
        select PINCTRL_SUNXI_COMMON

and MACH_SUN8I selects PINCTRL_SUN8I_A23

I'm not sure what the transition plan was.

>>  endif

[...]

v2 will also have EINT support.


Thanks
ChenYu
