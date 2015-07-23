From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 23 Jul 2015 07:16:22 +0200
Subject: [PATCH] ARM: dts: Add STM32429i-EVAL board support
In-Reply-To: <CAOesGMjLBwQgfm=nP+qTD9J8mfdoDb1PYCJ5cv2rT10+QY539Q@mail.gmail.com>
References: <1436693957-30855-1-git-send-email-mcoquelin.stm32@gmail.com>
 <CAOesGMjLBwQgfm=nP+qTD9J8mfdoDb1PYCJ5cv2rT10+QY539Q@mail.gmail.com>
Message-ID: <CALszF6ALmeVv+T_TkL9AKu_XqDe2=5REpyOriKsq_rgA1ww51g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

2015-07-23 1:42 GMT+02:00 Olof Johansson <olof@lixom.net>:
> Hi,
>
> On Sun, Jul 12, 2015 at 2:39 AM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>
>> +/ {
>> +       model = "STMicroelectronics STM32429i-EVAL board";
>> +       compatible = "st,stm32429i-eval", "st,stm32f429";
>> +
>> +       chosen {
>> +               bootargs = "console=ttyS0,115200 root=/dev/ram rdinit=/linuxrc";
>> +               linux,stdout-path = &usart1;
>
> You should use stdout-path here instead, and with that you'll no
> longer need the console arg in the bootargs.
>
> See: https://www.kernel.org/doc/Documentation/devicetree/bindings/chosen.txt

Thanks for the hint! I was not aware of that.

I will send the new pull request fixing this, and also fixing
STM32F429 Discovery board shortly.

Thanks,
Maxime
