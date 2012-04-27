From: shijie8@gmail.com (Huang Shijie)
Date: Fri, 27 Apr 2012 11:27:16 -0400
Subject: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <20378.47000.131486.237752@ipc1.ka-ro>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
 <20378.25703.527491.719116@ipc1.ka-ro>
 <20120427132538.GU28063@b20223-02.ap.freescale.net>
 <20378.47000.131486.237752@ipc1.ka-ro>
Message-ID: <CAMiH66HVddWNBNpnSgDviOsYY0pg64wE+iyp2bzwrozJyGyY5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 11:13 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Hi,
>
> Richard Zhao writes:
>> On Fri, Apr 27, 2012 at 11:18:31AM +0200, Lothar Wa?mann wrote:
>> > Hi,
>> >
>> > Richard Zhao writes:
>> > > device_prep_dma_cyclic may be call in audio trigger function which is
>> > > atomic context, so we make it atomic too.
>> > >
>> > > ?- change channel0 lock to spinlock.
>> > > ?- Use polling to wait for channel0 finish running.
>> > >
>> > > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
>> > >
>> > Actually I didn't sign off the patch that I posted, because I wanted
>> > to wait for more comments first.
>> I send it out with slight modifications because the series highly
>> depend on it. Will you take it over or let me put it in next version?
>> Both are ok to me.
>>
> I think you should keep it as part of your sound patches and I will
> test your final version on our hardware.
>
I hope we can get a conclusion that the prep_slave_sg() can be called
in atomic context or not.
My patch "add DMA support to UART" heavily depends on it.

Huang Shijie

>
> Lothar Wa?mann
> --
> ___________________________________________________________
>
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
