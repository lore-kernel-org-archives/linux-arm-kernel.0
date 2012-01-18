From: jochen@scram.de (Jochen Friedrich)
Date: Wed, 18 Jan 2012 12:30:13 +0100
Subject: [PATCH 2/2] ARM: sa1100: Refactor mcp-sa11x0 to use platform
 resources.
In-Reply-To: <20120117201256.GV1068@n2100.arm.linux.org.uk>
References: <1322427655-914-1-git-send-email-jochen@scram.de>
 <1322427655-914-2-git-send-email-jochen@scram.de>
 <20120114092129.GO1068@n2100.arm.linux.org.uk> <4F154255.2020605@scram.de>
 <20120117201256.GV1068@n2100.arm.linux.org.uk>
Message-ID: <4F16AD45.6030906@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

>> Accessing some random SoC registers and in the assabet case even board
>> specific registers from device drivers is even worse IMHO. We don't get
>> a clean solution until we have a pinmux/pinctrl device driver owning
>> these peripheral control registers. At least having the setup in the
>> board files avoids a potential race condition accessing PPDR and PPSR
>> registers from multiple drivers.
>
> Yes, but do we really need the exact same code repeated time and time
> again in each different board file?  Could we not have a function which
> sets the pins up for MCP?

Yes, this would be a good idea. One should do the same for the sa1100 
serial driver. Here we even have the bug that the driver unconditionally 
sets up pins for UART1 and 3 no matter what platform devices are present.

> I'm not complaining about this one - the MCCR1 shares its 64K space with
> the peripheral pin controller, and I suspect we won't get to the point
> where that's controlled by a driver.

Why not? gpio-generic should be able to handle the PPC registers out of 
the box.

Thanks,
Jochen
