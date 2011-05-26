From: khilman@ti.com (Kevin Hilman)
Date: Thu, 26 May 2011 10:15:10 -0700
Subject: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
In-Reply-To: <BANLkTik2=da94cZh23gwx1hzZQK6H_hy2Q@mail.gmail.com> (Charulatha
	Varadarajan's message of "Thu, 26 May 2011 15:08:06 +0530")
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-3-git-send-email-tarun.kanti@ti.com>
	<87sjs2sbvy.fsf@ti.com>
	<BANLkTik2=da94cZh23gwx1hzZQK6H_hy2Q@mail.gmail.com>
Message-ID: <8762oxgz8h.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> On Thu, May 26, 2011 at 03:04, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> From: Charulatha V <charu@ti.com>
>>>
>>> Non-wakeup GPIOs are available only in OMAP2420 and OMAP3430. But
>>> the GPIO driver initializes the non-wakeup GPIO bits for OMAP24xx
>>> (bothe OMAP 2420 and 2430) & not for OMAP3 which is incorrect.
>>
>> Can you cite the documentation you're using for the OMAP3 non-wakeup
>> GPIOs?
>
> I am referring to Table 25-5. GPIO Channel Description at page no 3354
> OMAP3430 public TRM Version P.
>

Based on how I understand that, those non-wakeup GPIOs are non-wakeup
because they're not actually mapped anywhere, and not available on
external pins.  Therefore, they should not need any special case
handling for this triggering workaround.

Kevin
