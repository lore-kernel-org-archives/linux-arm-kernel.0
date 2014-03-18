From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 18 Mar 2014 09:06:16 +0200
Subject: [PATCH 5/9] Doc/DT: Add DT binding documentation for MIPI DPI
 Panel
In-Reply-To: <5327EAB3.8080405@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-6-git-send-email-tomi.valkeinen@ti.com>
 <3721050.m43feCICLQ@avalon> <5327EAB3.8080405@ti.com>
Message-ID: <5327F068.7010100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/14 08:41, Tomi Valkeinen wrote:
> On 17/03/14 16:19, Laurent Pinchart wrote:
> 
>>> +Generic MIPI DPI Panel
>>> +======================
>>> +
>>> +Required properties:
>>> +- compatible: "panel-dpi"
>>> +
>>> +Optional properties:
>>> +- label: a symbolic name for the panel
>>> +- gpios: panel enable gpio and backlight enable gpio
>>
>> While integrated in the panel module, the backlight is a separate piece of 
>> hardware, which could be controlled through other means (I2C for instance). 
>> Wouldn't it be better to add an explicit DT node for the backlight device and 
>> reference that node from the panel node ?
> 
> Yes, I agree, but do we have the infrastructure or bindings for that?
> 
> Ah, I see we now do have a gpio-backlight driver, but it doesn't have DT
> bindings.

Seems there's a patch from Denis Carikli for this, which will probably
be merged for 3.15.

I realized I don't actually use panel-dpi at the moment in my OMAP DSS
DT series, as I dropped the board changes that used panel-dpi. So I'll
drop panel-dpi bindings from my series, and the backlight for panel-dpi
can then be fixed for 3.16.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/ed0d92a9/attachment-0001.sig>
