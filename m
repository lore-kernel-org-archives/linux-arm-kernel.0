From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 23 Aug 2013 15:13:55 +0800
Subject: [PATCH 0/3] of: add update device node status via cmdline feature
In-Reply-To: <CAL_JsqLa1RkL0MaOCbjYbuQW7+8EKqX8RMfypN=i5UTKaF47=A@mail.gmail.com>
References: <1376564133-11286-1-git-send-email-b29396@freescale.com>
 <520CCB70.8090908@gmail.com>
 <20130821124722.GB17748@b29396-Latitude-E6410>
 <CAL_JsqLa1RkL0MaOCbjYbuQW7+8EKqX8RMfypN=i5UTKaF47=A@mail.gmail.com>
Message-ID: <20130823071354.GB2460@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Aug 21, 2013 at 08:23:05AM -0500, Rob Herring wrote:
....
> > How does uboot handle this according to our needs?
> > Also dynamically update the device node status with uboot command?
> > Can you help point out an example for me to check?
> >
> 
> Here's an example adding a status property with u-boot commands:
> 
> Highbank #fdt print /soc/ethernet
> ethernet at fff50000 {
>         compatible = "calxeda,hb-xgmac";
>         reg = <0xfff50000 0x00001000>;
>         interrupts = <0x00000000 0x0000004d 0x00000004 0x00000000
> 0x0000004e 0x00000004 0x00000000 0x0000004f 0x00000004>;
>         dma-coherent;
> };
> Highbank #fdt set /soc/ethernet status okay
> Highbank #fdt print /soc/ethernet
> ethernet at fff50000 {
>         status = "okay";
>         compatible = "calxeda,hb-xgmac";
>         reg = <0xfff50000 0x00001000>;
>         interrupts = <0x00000000 0x0000004d 0x00000004 0x00000000
> 0x0000004e 0x00000004 0x00000000 0x0000004f 0x00000004>;
>         dma-coherent;
> };
> 

Thanks for the information. I tried and it works.
However it seems using uboot fdt commands is much complicated than kernel
command line way as i did in this patch.
We probably may would rather using add more board dts way if can not accept this patch series.
I already replied that concern in last mail, can you help check it and provide suggestions?

Regards
Dong Aisheng
