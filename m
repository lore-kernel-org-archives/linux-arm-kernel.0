From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 2 May 2014 16:06:00 +0300
Subject: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
In-Reply-To: <20140430175651.GB12362@atomide.com>
References: <535A6C40.10609@ti.com> <20140425153150.GA20807@atomide.com>
 <535DFAAE.1010606@ti.com> <20140428164528.GM20807@atomide.com>
 <535F37E9.8090609@ti.com> <20140429150529.GA27571@atomide.com>
 <535FD10B.4020108@ti.com> <535FD43B.3030102@ti.com>
 <20140429173838.GB27571@atomide.com> <5360948A.5020607@ti.com>
 <20140430175651.GB12362@atomide.com>
Message-ID: <53639838.3070907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/04/14 20:56, Tony Lindgren wrote:

> Have you checked out pinctrl-single,bits binding? That should allow
> you to map random bits in a single register to a pinctrl driver
> instance.

If I recall right, the problem there was that we have one register,
which has bits for two separate devices, and the bits are mixed up. i.e.
not 16 upper bits for one, 16 lower for the other, but 5 bits for one
device, the next 5 bits for the other, then again few bits for the
first, etc.

pinctrl-single,bits didn't like it that.

>>>> Oh, also, if I do that, I need to know both the SoC version and the DSS
>>>> version in the driver.
>>>
>>> Don't you get all you need in the compatible string? Something like
>>> compatible ti,dss-phy-omap5?
>>
>> We do use different compatible strings for different major versions of
>> the DSS blocks, like ti,omap5-dsi. But that exactly same DSS block could
>> be used on some other SoC, with different control stuff.
>>
>> We could use separate compatible string for each SoC that uses DSS, but
>> then we're really encoding the SoC version into the compatible string,
>> not DSS version.
>>
>> Of course, if there will be a separate driver managing the
>> CONTROL_DSIPHY register, then that one should use compatible string
>> specific to the SoC, as it's not a DSS driver at all.
> 
> Yeah probably using pinctrl-single,bits, or a separate driver with syscon
> makes most sense here.

Yep, I'll have to come up with something.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140502/7a4db19a/attachment.sig>
