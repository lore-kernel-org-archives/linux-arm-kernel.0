From: darkstar6262@gmail.com (Cory Maccarrone)
Date: Sun, 8 Aug 2010 10:28:53 -0700
Subject: [PATCH 4/5] [omap1] Bluetooth device code common to HTC
	smartphones
In-Reply-To: <20100804101507.GG9881@atomide.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
	<1280762976-17284-5-git-send-email-darkstar6262@gmail.com>
	<20100804101507.GG9881@atomide.com>
Message-ID: <AANLkTikGA9-TCM7v+_yivBYtxiX3ByJ7_ub1FOP0LgBO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 4, 2010 at 3:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
>> This change adds in a bluetooth controld driver/rfkill
>> interface to the serial bluetooth controller found on many
>> HTC smartphones such as the HTC Herald and HTC Wizard.
>
> To me it looks like most of this should be in drivers/bluetooth/omap7xx.c
> or something like that. Then you can just pass it the gpio numbers in
> the platform_data.
>

Not sure I agree that it fits there.  The driver isn't really a
bluetooth driver -- it's really just an RFKILL interface, and some
code to toggle UART clocks on and off, plus GPIO work on a
board-specific level.  In principle, the gpios could be set and the
clocks enabled in the board files, and this driver wouldn't be
necessary to get working bluetooth (as we'd use hciattach on
/dev/ttyS*).  But then, we can't toggle it off for power saving.
Maybe a better place would be plat-omap/?  But it really is more
specific to these HTC boards, not the architecture itself.

So really, the only point of this driver is to be able to power on and
off the external bluetooth chip, which is why I submitted it as helper
code to the board files.

- Cory
