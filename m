From: khilman@ti.com (Kevin Hilman)
Date: Wed, 26 Jan 2011 12:48:44 -0800
Subject: [PATCH] OMAP3: PM: fix save secure RAM to restore MPU power state
In-Reply-To: <854C6400F5AA6644BA6FE7953F3E769B0376F954@008-AM1MPN1-012.mgdnok.nokia.com>
	(Tero Kristo's message of "Wed, 26 Jan 2011 09:27:03 +0000")
References: <1296003011-26427-1-git-send-email-khilman@ti.com>
	<854C6400F5AA6644BA6FE7953F3E769B0376F954@008-AM1MPN1-012.mgdnok.nokia.com>
Message-ID: <87bp33xufn.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

<Tero.Kristo@nokia.com> writes:

>>Currently, on HS/EMU devices, MPU power state forced to on during PM
>>init by the save secure RAM code.  Rather than forcing the state of
>>MPU powerdomain to on, simply read the current value and restore it
>>after the ROM code has run.
>>
>>This only affects the !CPUidle case since when CPUidle is enabled, the
>>MPU power state is dynamically changed by CPUidle.  In the !CPUidle
>>case, MPU power state is initialized once at init and never touched.
>>
>>Cc: Tero Kristo <tero.kristo@nokia.com>
>>Signed-off-by: Kevin Hilman <khilman@ti.com>
>>---
>>If no objectsions, will be queued in my pm-fixes branch for 2.6.38-rc.
>
> Looks good to me. Ack, if you need one.
>  

Thanks, I was looking for your ack.

Kevin
