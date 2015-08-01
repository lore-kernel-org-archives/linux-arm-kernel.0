From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Sat, 01 Aug 2015 15:35:30 -0300
Subject: [PATCH v4 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
In-Reply-To: <20150729151737.GA13628@roeck-us.net>
References: <20150729151737.GA13628@roeck-us.net>
Message-ID: <55BD1172.5010309@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

El 29/07/15 a las 12:17, Guenter Roeck escibi?:
> On Mon, Jul 27, 2015 at 02:04:52AM -0300, Ariel D'Alessandro wrote:
>> This commit adds support for the watchdog timer found in NXP LPC SoCs
>> family, which includes LPC18xx/LPC43xx. Other SoCs in that family may
>> share the same watchdog hardware.
>>
>> Watchdog driver registers a restart handler that will restart the system
>> by performing an incorrect feed after ensuring the watchdog is enabled in
>> reset mode.
>>
>> As watchdog cannot be disabled in hardware, driver's stop routine will
>> regularly send a keepalive ping using a timer.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
> 
> Hi Ariel,
> 
> Please run the patch through checkpatch --strict.
> 
> Specifically, loook out for
> 
> WARNING: quoted string split across lines
> CHECK: No space is necessary after a cast
> CHECK: Please don't use multiple blank lines
> 
> Also see additional nitpick below.
> 

OK, I'm sending patchset v5 with these modifications.
