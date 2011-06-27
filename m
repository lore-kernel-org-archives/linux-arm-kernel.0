From: jaswinder.singh@linaro.org (Jaswinder Singh)
Date: Mon, 27 Jun 2011 13:38:54 +0530
Subject: [PATCH] OMAP4: PANDA, SDP: Fix EHCI regulator supply
In-Reply-To: <20110627080036.GB2508@legolas.emea.dhcp.ti.com>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
	<BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
	<20110627080036.GB2508@legolas.emea.dhcp.ti.com>
Message-ID: <BANLkTinVdWjoS-qdGnSxGnmrPKHSDNV7hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On 27 June 2011 13:30, Felipe Balbi <balbi@ti.com> wrote:

>> >
>> > +static struct regulator_consumer_supply sdp4430_vusb_supply =
>> > + ? ? ? REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
>
> this should be an array.
Ok, I can make it an array of _one_ element.
Though I am not sure why is that a good thing, or are we to use another
possible VUSB supply on Panda/SDP boards ?  Please suggest so that
I can add that too.

>> > ?static struct regulator_init_data sdp4430_vusb = {
>> > ? ? ? ?.constraints = {
>> > ? ? ? ? ? ? ? ?.min_uV ? ? ? ? ? ? ? ? = 3300000,
>> > ? ? ? ? ? ? ? ?.max_uV ? ? ? ? ? ? ? ? = 3300000,
>> > - ? ? ? ? ? ? ? .apply_uV ? ? ? ? ? ? ? = true,
>> > ? ? ? ? ? ? ? ?.valid_modes_mask ? ? ? = REGULATOR_MODE_NORMAL
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| REGULATOR_MODE_STANDBY,
>> > ? ? ? ? ? ? ? ?.valid_ops_mask ?= ? ? ?REGULATOR_CHANGE_MODE
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| REGULATOR_CHANGE_STATUS,
>> > ? ? ? ?},
>> > + ? ? ? .num_consumer_supplies ?= 1,
>
> ARRAY_SIZE()
Yes, of course if we are to switch to single-element array.

Thanks,
Jassi
