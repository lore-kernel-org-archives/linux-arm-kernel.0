From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 10 Jun 2010 09:34:04 +1200
Subject: [PATCH v3] ep93xx: move physmap flash registration into core.c
In-Reply-To: <0D753D10438DA54287A00B02708426976370F422A7@AUSP01VMBX24.collaborationhost.net>
References: <AcrcNxXi/1OpCfUUTQ2+Xkz9P4CSMQ==>	<0D753D10438DA54287A00B0270842697636D62B066@AUSP01VMBX24.collaborationhost.net>	<t2h56d259a01004200333gfc5b6307vb34c20e60db28aa1@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636F3238EC@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B02708426976370F421F7@AUSP01VMBX24.collaborationhost.net>
	<4C10009B.2010607@bluewatersys.com>
	<0D753D10438DA54287A00B02708426976370F422A7@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4C1008CC.2000201@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> On Wednesday, June 09, 2010 1:59 PM, Ryan Mallon wrote:
>> H Hartley Sweeten wrote:
>>> Create a core.c __init function to handle the physmap flash
>>> registration for all the ep93xx platforms.  Also, modify all
>>> the ep93xx platforms to use this new function.
>>>
>>> This simplifies all the ep93xx platform init code and removes
>>> all the static variables that would exist in a unified kernel
>>> supporting multiple ep93xx platforms.
>> Looks fine. Not sure I understand the second part about the unified
>> kernel though. Can't we already build all ep93xx boards (at least those
>> at the same phys offset) into one kernel?
> 
> Yes, we already build a unified kernel for boards with the same phys
> offset.  But with the current code each platform has a private static
> Resource and platform device for the flash.  Since this data is not
> tagged as __initdata it just takes up space after initialization.  If
> a working runtime PHYS_OFFSET patch is ever worked out this static
> data will increase for each ep93xx platform added.

Ah, that makes sense. Just say that it reduces the size of the kernel
when including multiple ep93xx boards.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
