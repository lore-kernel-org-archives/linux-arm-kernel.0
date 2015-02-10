From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 10 Feb 2015 22:24:33 +0100 (CET)
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <CAOMZO5AtFOThRjcAgMVbrbkcrJbehouSxoH03VUGJrRdWXnS_Q@mail.gmail.com>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5DOgdUYsRUU3TXgJY+JhjF8xC_XY8EJFcrM7NHiPmSMOQ@mail.gmail.com>
 <54DA020C.6030703@i2se.com>
 <CAOMZO5DGCP1p1vetwWHpSbe2qywA8DhWRRq22egMDFSw11uq4w@mail.gmail.com>
 <54DA0DE7.5050708@i2se.com>
 <CAOMZO5AtFOThRjcAgMVbrbkcrJbehouSxoH03VUGJrRdWXnS_Q@mail.gmail.com>
Message-ID: <462270270.419156.1423603473431.JavaMail.open-xchange@oxbaltgw02.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 10. Februar 2015 um 16:06
> geschrieben:
>
>
> Hi Stefan,
>
> On Tue, Feb 10, 2015 at 11:55 AM, Stefan Wahren <stefan.wahren@i2se.com>
> wrote:
>
> > Could you apply only the clk-imx28.c part of my patch and see what happens?
>
> If I apply only the clk-imx28.c part of your patch I can successfully
> probe the SPI NOR.

thanks this is very helpful. I built the linux-next for my Duckbill and add the
SSP2 section from imx28-evk.dts into imx28-duckbill.dts.

Without my patch i get the following for HW_CLKCTRL_FRAC0:

./memwatch -a 0x800401B0

0x800401b0: 0x5e5b5513

With my patch i get:

./memwatch -a 0x800401B0

0x800401b0: 0x5e1b5513

So it looks like a problem in my patch.

I orded such a flash chip, but it will take some time until i can use it with my
hardware.

Stefan

>
> Thanks
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
