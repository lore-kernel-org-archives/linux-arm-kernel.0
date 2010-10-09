From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 9 Oct 2010 19:18:56 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101009143709.GB25564@n2100.arm.linux.org.uk>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimtdV8THgnQL1RxaqLzCUwO27AZSMPi=UtgpML7@mail.gmail.com>
	<201010091311.26335.arnd@arndb.de>
	<AANLkTikdxSQD+9UY70PtCPMgnrovx-dWjrrPJ0AZyG4X@mail.gmail.com>
	<AANLkTi=37SCuwwze4KS_yOdmi8bvJP_OexHaYLw-AXfJ@mail.gmail.com>
	<20101009143709.GB25564@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin-OpKVK+a=WPQFoPwCO7aJ4yTjqjw3EmGeBRBs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 9, 2010 at 5:37 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Oct 09, 2010 at 03:10:57PM +0300, Felipe Contreras wrote:
>> On Sat, Oct 9, 2010 at 2:43 PM, Dave Airlie <airlied@gmail.com> wrote:
>> >> The few drivers that may be hit by this are typically in drivers/staging
>> >> exactly because issues like this have not been fixed yet.
>> >>
>> >> We should probably just fix the non-staging drivers that are hit by
>> >> this now and declare the issue done.
>> >>
>> >> When you say that "many drivers broken", can you list the ones you know
>> >> about? It would probably help resolve this the right way.
>> >
>> > I'm guessing some closed source graphics drivers for ARM do all kinds
>> > of wrong crap, and Nokia use them a lot, and nobody wants to tell the
>> > closed vendors to change their drivers because it costs money.
>>
>> You are over simplifying things.
>>
>> ?1) The code is open[1]
>> ?2) the decision comes from TI, Nokia can only do so much before shipping
>
> Well -
>
> 1. TI had been complaining last December about vmalloc() creating mappings
> ? with different shared-ness attributes causing problems with OMAP.
>
> 2. May 10, TI on the three-weekly conference call were warned about this
> ? change to ioremap with system RAM - and this was noted in the minutes
> ? and circulated. ?It was brought up again on June 21st, and yet again
> ? on August 2nd.
>
> So, the major players in the OMAP community were repeatedly made plainly
> aware of this change and some were aware of the problems caused by
> violating these kinds of restrictions.

My point was that Nokia was not the main entity to blame.

But anyway, I'm not too fond of secret meetings, the issues should be
discussed publicly.

> You tell me - if I've raised the issue on the mailing list to which OMAP
> people are aware of (and note that there was a reply from OMAP folk in
> the inital thread), if I've raised it several times with TI in conference
> calls which include the major players, and still OMAP drivers are doing
> things wrongly.
>
> You can lead the horse to water but you can not make it drink. ?At some
> point it either drinks or dies. ?In this case, it seems death is the
> favoured option as the warnings have been repeatedly ignored.

TI is not the owner of their drivers; the community is. I don't see
any mail from you on the linux-omap mailing list warning about
ioremap() changing behavior, nor do I think that would have been
enough warning, for OMAP, SH, or anybody else that might be affected.

All you are being asked is to make *one* release where the warning is
enabled but the behavior is not changed.

-- 
Felipe Contreras
