From: eric@anholt.net (Eric Anholt)
Date: Tue, 06 Oct 2015 18:24:44 -0700
Subject: [PATCH v4] clk: bcm2835: Add support for programming the audio
 domain clocks.
In-Reply-To: <56143AC9.60506@lategoodbye.de>
References: <1443815696-11528-1-git-send-email-eric@anholt.net>
 <56143AC9.60506@lategoodbye.de>
Message-ID: <87bncbo4gz.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <info@lategoodbye.de> writes:

> Hi Eric,
>
> Am 02.10.2015 um 21:54 schrieb Eric Anholt:
>> This adds support for enabling, disabling, and setting the rate of the
>> audio domain clocks.  It will be necessary for setting the pixel clock
>> for HDMI in the VC4 driver and let us write a cpufreq driver.  It will
>> also improve compatibility with user changes to the firmware's
>> config.txt, since our previous fixed clocks are unaware of it.
>>
>> The firmware also has support for configuring the clocks through the
>> mailbox channel, but the pixel clock setup by the firmware doesn't
>> work, and it's Raspberry Pi specific anyway.  The only conflicts we
>> should have with the firmware would be if we made firmware calls that
>> result in clock management (like opening firmware V3D or ISP access,
>> which we don't support in upstream), or on hardware over-thermal or
>> under-voltage (when the firmware would rewrite PLLB to take the ARM
>> out of overclock).  If that happens, our cached .recalc_rate() results
>> would be incorrect, but that's no worse than our current state where
>> we used fixed clocks.
>>
>> The existing fixed clocks in the code are left in place to provide
>> backwards compatibility with old device tree files.
>
> only a few nits.

I think I've done all of these now, sending out v5.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/a55bae8b/attachment.sig>
