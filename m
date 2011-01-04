From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 4 Jan 2011 12:00:51 +0800
Subject: [PATCH 2/2] arm/pxa: buildfix for pam27x without fb
In-Reply-To: <201101032308.00036.marek.vasut@gmail.com>
References: <1293654828-24661-1-git-send-email-bigeasy@linutronix.de>
	<1293654828-24661-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTi=mtu3VibUR5SC+GmsmJCwo-nN9=eoTmzUE9jS8@mail.gmail.com>
	<201101032308.00036.marek.vasut@gmail.com>
Message-ID: <AANLkTikfjwMEaUVCsLMHrtCyBo+GzoyPdLkFMoJY-_bi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 4, 2011 at 6:07 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On Monday 03 January 2011 16:57:27 Eric Miao wrote:
>> On Thu, Dec 30, 2010 at 4:33 AM, Sebastian Andrzej Siewior
>>
>> <bigeasy@linutronix.de> wrote:
>> > |arch/arm/mach-pxa/palmld.c: In function ?palmld_init?:
>> > |arch/arm/mach-pxa/palmld.c:330: error: ?palm_320x480_lcd_mode?
>> > |undeclared (first use in this function) arch/arm/mach-pxa/palmld.c:330:
>> > |error: (Each undeclared identifier is reported only once
>> > |arch/arm/mach-pxa/palmld.c:330: error: for each function it appears
>> > |in.)
>> >
>> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> Marek,
>>
>> I need your ack please.
>
> I don't like it being done with preprocessor macro. Maybe we should rather pull
> palm_320x320_new_lcd_mode and others outside the #if defined() ?
>

Yeah, that will be at least a bit more consistent.

>>
>> > ---
>> > ?arch/arm/mach-pxa/include/mach/palm27x.h | ? ?2 +-
>> > ?1 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-pxa/include/mach/palm27x.h
>> > b/arch/arm/mach-pxa/include/mach/palm27x.h index 0a5e5ea..7b7927c 100644
>> > --- a/arch/arm/mach-pxa/include/mach/palm27x.h
>> > +++ b/arch/arm/mach-pxa/include/mach/palm27x.h
>> > @@ -34,7 +34,7 @@ extern struct pxafb_mode_info
>> > palm_320x320_new_lcd_mode; extern void __init palm27x_lcd_init(int
>> > power,
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct pxafb_mode_info *mode);
>> > ?#else
>> > -static inline void palm27x_lcd_init(int power, struct pxafb_mode_info
>> > *mode) {} +#define palm27x_lcd_init(power, mode) ?do { } while (0)
>> > ?#endif
>> >
>> > ?#if ? ?defined(CONFIG_USB_GADGET_PXA27X) || \
>> > --
>> > 1.7.3.2
>
