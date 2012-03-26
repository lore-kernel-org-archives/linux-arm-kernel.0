From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Mar 2012 11:14:56 +0200
Subject: [PATCH] serial: pl011: implement workaround for CTS clear event
 issue
In-Reply-To: <2B1D156D95AE9B4EAD379CB9E465FE73255E4BB903@EXDCVYMBSTM005.EQ1STM.local>
References: <1332748868-10172-1-git-send-email-linus.walleij@stericsson.com>
 <20120326081756.GI5611@n2100.arm.linux.org.uk>
 <2B1D156D95AE9B4EAD379CB9E465FE73255E4BB903@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <CACRpkdaHoDawAXnXSK4KG4L_fusbWny2-b=UOS8LcQh4pdQS2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 11:07 AM, Rajanikanth H V
<rajanikanth.hv@stericsson.com> wrote:

> As per my understanding, pass counter helps to identify/break the
> Deadlock situation and triggers bottom half handler in which
> Uart controller will be forced to reset (save and restore of UART register happens).

It was there before the fix for the deadlock situation found in ST hardwares,
which was solved by the tasklet, was ever introduced.

It has been around forever as a simple guard to stop the ISR from
going into a loop... which is nice coding practice anyway so let's
keep it.

Yours,
Linus Walleij
