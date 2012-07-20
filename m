From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 20 Jul 2012 17:24:56 -0500
Subject: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain
 transitioning to OFF when in-use
In-Reply-To: <20120713140021.GS18079@mudshark.cambridge.arm.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-9-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
 <500028B3.1040309@ti.com> <20120713140021.GS18079@mudshark.cambridge.arm.com>
Message-ID: <5009DAB8.7090001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 07/13/2012 09:00 AM, Will Deacon wrote:
> Jon,
> 
> [cutting out realms of context!]
> 
> On Fri, Jul 13, 2012 at 02:54:59PM +0100, Jon Hunter wrote:
>> Another proposal I also thought of is re-working the flags to describe
>> the HW mode to be used when turning on the CLKDM, when the CLKDM is
>> active and when the CLKDM is shut down. So instead of saying what modes
>> the CLKDM supports, specify what modes should be used for pre-ON (i.e.
>> turn ON), ON and OFF. Right now software is trying to decide for us by
>> what is available (which is ideal) but makes working around such nuances
>> a little more painful.
>>
>> By the way, I did do some testing on OMAP3, but I don't recall now
>> whether I was having such problems with OMAP3. I need to go back and
>> test perf again on OMAP3 to see if such a flag is needed.
> 
> If you do test on OMAP3, please kill the OMAP3_EMU option as I think this
> has the effect of keeping the EMU power domain up via the etm code (look at
> etb_probe).

You are right. Removing that options breaks PMU on OMAP3. I need to add
hwmod support for the debugss on OMAP3.

Cheers
Jon
