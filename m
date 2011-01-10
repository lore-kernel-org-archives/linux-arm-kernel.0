From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 10 Jan 2011 16:38:54 -0600
Subject: suspicious code in linux/arch/arm/common/sa1111.c
In-Reply-To: <20110109071459.GA1488@ucw.cz>
References: <20101116090705.GA29337@pma.sysgo.com>
	<AANLkTin6QAr7=7-59aKzunh6nQGhCKPJ11OspBtC4NHB@mail.gmail.com>
	<20110109071459.GA1488@ucw.cz>
Message-ID: <AANLkTi=5gC3ton6tzYqM=NA9j8k37NO=y1QSYb5Oxvik@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 9, 2011 at 1:14 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2010-11-16 17:09:59, Eric Miao wrote:
>> On Tue, Nov 16, 2010 at 5:07 PM, Pavel Machek <pma@sysgo.com> wrote:
>> > Hi!
>> >
>> > Is this good idea?
>> >
>> > Signed-off-by: Pavel Machek <pma@sysgo.com>
>>
>> Yep, obviously was a typo.
>
> Can you apply the patch? Or should I re--generate one with better changelog?

Applied with subject line as below, which I guess is more specific?

Subject: ARM: sa1111: fix typo in sa1111_retrigger_lowirq()


>
>> > diff -ur linux.ofic//arch/arm/common/sa1111.c linux/arch/arm/common/sa1111.c
>> > --- linux.ofic//arch/arm/common/sa1111.c ? ? ? ?2010-10-17 20:31:13.000000000 +0200
>> > +++ linux/arch/arm/common/sa1111.c ? ? ?2010-11-05 10:44:17.000000000 +0100
>> > @@ -282,7 +312,7 @@
>> > ? ? ? ?for (i = 0; i < 8; i++) {
>> > ? ? ? ? ? ? ? ?sa1111_writel(ip0 ^ mask, mapbase + SA1111_INTPOL0);
>> > ? ? ? ? ? ? ? ?sa1111_writel(ip0, mapbase + SA1111_INTPOL0);
>> > - ? ? ? ? ? ? ? if (sa1111_readl(mapbase + SA1111_INTSTATCLR1) & mask)
>> > + ? ? ? ? ? ? ? if (sa1111_readl(mapbase + SA1111_INTSTATCLR0) & mask)
>> > ? ? ? ? ? ? ? ? ? ? ? ?break;
>> > ? ? ? ?}
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at ?http://www.tux.org/lkml/
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
