From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 31 Jan 2013 22:31:14 +0100 (CET)
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <CAKGA1bmpL-PyyMENmwgH9WNmdQ=+1oXrtDo+0OLffdvTChpLFQ@mail.gmail.com>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de> <50FDAC5F.4040605@linaro.org>
 <CAKGA1b=D5CNikijoOAk5xP6TC-nB_gEGtS05ncrPR68sQTMrxw@mail.gmail.com>
 <50FDC2DD.7090406@linaro.org>
 <CAKGA1bmtTH1N8nx79MGiMighdQROpNtpvAZXhHKT+mT3kcazBQ@mail.gmail.com>
 <50FDE2AE.8030608@linaro.org>
 <CAKGA1bkXx2qn+c6sKqXsty-aFe1r-W79uyem0O8p6JNeeq6zxQ@mail.gmail.com>
 <50FDEBF8.3090902@linaro.org>
 <CAKGA1bmpL-PyyMENmwgH9WNmdQ=+1oXrtDo+0OLffdvTChpLFQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1301312221400.11905@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jan 2013, Matt Sealey wrote:
> And if I wanted to I could register 8 more timers. That seems rather
> excessive, but the ability to use those extra 8 as clock outputs from
> the SoC or otherwise directly use comparators is useful to some
> people, does Linux in general really give a damn about having 8 timers
> of the same quality being available when most systems barely have two
> clocksources anyway (on x86, tsc and hpet - on ARM I guess twd and
> some SoC-specific timer). I dunno how many people might actually want

If you want to use that timers just for delivering arbitrary timer
events, then no. There is no point to have a gazillion of timer
interrupts happening w/o being coordinated. We have a pretty well
structured timer event infrastructure for precise and more timeout
oriented events, which are pretty happy to be served by a single per
cpu event device.

If you want to use the extra timers for other purposes (PWM, timer
triggered DMA transfers, etc...) then they are not in any way related
to the timers/timekeeping core.

Thanks,

	tglx
