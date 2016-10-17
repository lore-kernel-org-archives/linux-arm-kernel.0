From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 17 Oct 2016 21:59:48 +0900
Subject: [PATCH] usb: ehci-platform: increase EHCI_MAX_RSTS to 4
In-Reply-To: <20161017123043.GA15142@kroah.com>
References: <1476702719-10337-1-git-send-email-yamada.masahiro@socionext.com>
 <20161017123043.GA15142@kroah.com>
Message-ID: <CAK7LNARfi29fzERqwr46z7rVW1S7k85q349WR_3RFxWE6tVTWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,


2016-10-17 21:30 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Mon, Oct 17, 2016 at 08:11:59PM +0900, Masahiro Yamada wrote:
>> Socionext LD11 SoC (arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi)
>> needs to handle 4 reset lines for EHCI.
>
> Why?  What makes it different from other EHCI implementations?
>
> thanks,
>
> greg k-h


This is a generic EHCI driver, but the number of clocks/resets
are SoC-specific.



The following patch you picked up will remind you something?



commit 73577d61799e8d8bb7d69a9acdc54923e5998138
Author: Icenowy Zheng <icenowy@aosc.xyz>
Date:   Fri Aug 12 11:06:22 2016 +0800

    ehci-platform: add the max clock number to 4

    Allwinner A64 EHCI requires 4 clocks to be enabled.

    Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
    Acked-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>






-- 
Best Regards
Masahiro Yamada
