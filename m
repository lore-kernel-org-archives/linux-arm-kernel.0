From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 9 Dec 2010 14:15:27 +0800
Subject: [PATCH v2 08/15] ARM: mxs: Add iomux support
In-Reply-To: <19711.27840.946740.905255@ipc1.ka-ro>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-7-git-send-email-shawn.guo@freescale.com>
	<19711.13023.154958.539289@ipc1.ka-ro>
	<AANLkTikb4Ytx==R=n7RDOXv+tKtVvgcTUX7R-QDQfVoc@mail.gmail.com>
	<20101208105643.GO18244@pengutronix.de>
	<AANLkTimHyYUkDqLQ79o9fP_9NgOK1Lec=psoFCpb1+jA@mail.gmail.com>
	<19711.27840.946740.905255@ipc1.ka-ro>
Message-ID: <AANLkTimsFBsDu6dKLWPafG5zuAq4BYB1uMGcgEFOYY80@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 8, 2010 at 7:32 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Shawn Guo writes:
>> 2010/12/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> > Hello,
>> >
>> > On Wed, Dec 08, 2010 at 06:52:36PM +0800, Shawn Guo wrote:
>> >> Hi Lothar,
>> >>
>> >> Thanks for the review.
>> >>
>> >> On Wed, Dec 8, 2010 at 3:25 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
>> >> > Hi,
>> >> >
>> >> > Shawn Guo writes:
>> >> >> MXS-based SoCs implements iomux functions in block PINCTRL.
>> >> >>
>> >> >> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
>> >> >> ---
>> >> >> Changes for v2:
>> >> >> ?- Define iomux_cfg_t as u64
>> >> > ? ? ^^^^^^^^^^^^^^^^^^^^^^^^^
>> >> > Really?
>> >> >
>> >> >> +typedef struct pad_desc {
>> >> >> + ? ? unsigned bank:12;
>> >> >> + ? ? unsigned pin:20;
>> >> >> + ? ? unsigned muxsel:8;
>> >> >> + ? ? unsigned ma:12;
>> >> >> + ? ? unsigned vol:8;
>> >> >> + ? ? unsigned pull:4;
>> >> >> +} iomux_cfg_t;
>> >> > ^^^^^^^^^^^^^^^^^
>> >> >
>> >> I did not pick the correct word. ?What I meant is 64 bits. ?Since this
>> >> error is in change log, I would fix it if there is v3 of the patch.
>> > the idea was to really use an u64 to have the pin definitions modifyable.
>> >
>> Ah, I misunderstood the comments. ?But I did not see mxc switches to
>> u64. ?Do you have example to show what you want exactly?
>>
> See:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/032202.html
>
Thanks, Lothar.

Hi Uwe,

Looking at the page Lothar gave, the patch is to facilitate adding
platform specific pad_ctrl settings to an
existing pad definition.  In this case, it might be reasonable to keep
EXPORT_SYMBOL(mxs_iomux_setup_pad), which you asked me to remove.
What do you think?

-- 
Regards,
Shawn
