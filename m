From: olof@lixom.net (Olof Johansson)
Date: Wed, 22 Jul 2015 16:42:01 -0700
Subject: [PATCH] ARM: dts: Add STM32429i-EVAL board support
In-Reply-To: <1436693957-30855-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1436693957-30855-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CAOesGMjLBwQgfm=nP+qTD9J8mfdoDb1PYCJ5cv2rT10+QY539Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 12, 2015 at 2:39 AM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> +/ {
> +       model = "STMicroelectronics STM32429i-EVAL board";
> +       compatible = "st,stm32429i-eval", "st,stm32f429";
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200 root=/dev/ram rdinit=/linuxrc";
> +               linux,stdout-path = &usart1;

You should use stdout-path here instead, and with that you'll no
longer need the console arg in the bootargs.

See: https://www.kernel.org/doc/Documentation/devicetree/bindings/chosen.txt


-Olof
