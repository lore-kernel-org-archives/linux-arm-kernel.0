From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 10 Feb 2015 19:54:52 -0200
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <462270270.419156.1423603473431.JavaMail.open-xchange@oxbaltgw02.schlund.de>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5DOgdUYsRUU3TXgJY+JhjF8xC_XY8EJFcrM7NHiPmSMOQ@mail.gmail.com>
 <54DA020C.6030703@i2se.com>
 <CAOMZO5DGCP1p1vetwWHpSbe2qywA8DhWRRq22egMDFSw11uq4w@mail.gmail.com>
 <54DA0DE7.5050708@i2se.com>
 <CAOMZO5AtFOThRjcAgMVbrbkcrJbehouSxoH03VUGJrRdWXnS_Q@mail.gmail.com>
 <462270270.419156.1423603473431.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Message-ID: <CAOMZO5CYHKCUXyCGzuRaYt_o=ucSmZBwsc8mF84HqaA-+QX15g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tue, Feb 10, 2015 at 7:24 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> thanks this is very helpful. I built the linux-next for my Duckbill and add the
> SSP2 section from imx28-evk.dts into imx28-duckbill.dts.
>
> Without my patch i get the following for HW_CLKCTRL_FRAC0:
>
> ./memwatch -a 0x800401B0
>
> 0x800401b0: 0x5e5b5513
>
> With my patch i get:
>
> ./memwatch -a 0x800401B0
>
> 0x800401b0: 0x5e1b5513
>
> So it looks like a problem in my patch.

Yes, let's try to get the same value HW_CLKCTRL_FRAC0.

> I orded such a flash chip, but it will take some time until i can use it with my
> hardware.

Thanks for doing this.

Maybe if you find out a way to fix the calculation of
HW_CLKCTRL_FRAC0, then I can test it on my board.

Regards,

Fabio Estevam
