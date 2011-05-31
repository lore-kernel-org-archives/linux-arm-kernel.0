From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 31 May 2011 15:02:36 -0500
Subject: [PATCH v3] ARM: ep93xx: use more reliable CPLD watchdog for
	reset on ts72xx
In-Reply-To: <20110531195513.GL16318@ibawizard.net>
References: <ADE657CA350FB648AAC2C43247A983F001F381FC4955@AUSP01VMBX24.collaborationhost.net>
	<1306868578-3883-1-git-send-email-ynezz@true.cz>
	<ADE657CA350FB648AAC2C43247A983F001F381FC498E@AUSP01VMBX24.collaborationhost.net>
	<20110531195513.GL16318@ibawizard.net>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F381FC49CC@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 31, 2011 12:55 PM, Petr ?tetiar wrote:
> H Hartley Sweeten <hartleys@visionengravers.com> [2011-05-31 14:24:04]:
>
>> I pulled out the ts-7200 manual to verify the watchdog reset.  Your feeding
>> the watchdog then changing the timeout period to 250ms.  Without the "else"
>> the syscon would have tried to reset the board when the SWRST bit is toggled.
>
> Yep, that missing "else" was a good catch, thanks.
>
> This feed first then set behaviour is "logic", but it's correct (250ms is the
> smallest possible value), from that manual:
>
>    In order to load the WDT Control register, the WDT must first be ?fed?, and
>    then within 30 uS, the WDT control register must be written. Writes to this
>    register without first doing a ?WDT feed?, have no affect.
>
> (Please don't laugh at that 30us constraint).

;-)

>> I have no way of testing this patch (no ts boards) but as long as Ryan has no
>> objections you have my:
>
> I'm using it[1] since 2.6.19-rc6-git10 (maybe earlier). Funny, that I didn't
> forget to add that "else" in this old patch.
>
> And as I see it, you and few other guys really deserve some free TS boards for
> sure (at least the damn board as a thank you), but Lennert could probably tell
> you more about their "we only leech the work from the comunity, but don't give
> anything back" attitude...

Yah, the ep93xx port has some bad history.  It's old history, lets move on...

If they want to give me one I'll be happy to take it.  I can even go pick it up,
they are only 44 miles away from my on the other side of the valley....

Regards,
Hartley
