From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 22 May 2011 16:32:06 +0400
Subject: PXA: Handling of UDC with no VBUS pins
In-Reply-To: <4DD6AF07.9060306@free.fr>
References: <20110518120633.GA9860@doriath.ww600.siemens.net>
	<4DD6AF07.9060306@free.fr>
Message-ID: <4DD90246.9070803@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 20-05-2011 22:12, Robert Jarzmik wrote:

>> There are several PXA platforms which on the UDC tranceiver part have
>> a pullup pin to support connect/disconnect but no VBUS pin to detect
>> host presense. Currently such platforms are supported through udc driver
>> itself. I'd like to clean that part of pxa25x_udc/pxa27x_udc drivers and
>> to move gpio pullup handling to tranceiver.

> So, you want to concentrate USB pullup handling, right ?

>> My question is what would be better: to extend gpio-vbus to work w/o
>> VBUS pin or to write new transceiver driver only handling gpio-pullup?

> My personnal feeling is neither, let them be. The generic pullup would have to
> ask itself :
> - should the pullup be applied on D+ (on USB 2.0 and 3.0 devices) ?
> - should the pullup be applied on D- (on USB 1.1 devices) ?

    Pullup on D- is only used on low speed devices, not all USB 1.1 devices. 
That's how they get detected.

WBR, Sergei
