From: bsdimp@gmail.com (Warner Losh)
Date: Fri, 28 Feb 2014 09:28:22 -0700
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <20140228162327.GT21483@n2100.arm.linux.org.uk>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
 <20140228155937.GQ21483@n2100.arm.linux.org.uk> <5310B567.7040605@ti.com>
 <20140228162327.GT21483@n2100.arm.linux.org.uk>
Message-ID: <E2528116-7208-48EB-ADCF-D91B2C6DA0DB@bsdimp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 28, 2014, at 9:23 AM, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Feb 28, 2014 at 06:12:23PM +0200, Tomi Valkeinen wrote:
>> On 28/02/14 17:59, Russell King - ARM Linux wrote:
>> 
>>>> +dvi0: connector at 0 {
>>>> +	compatible = "dvi-connector";
>>>> +	label = "dvi";
>>>> +
>>>> +	i2c-bus = <&i2c3>;
>>>> +
>>>> +	dvi_connector_in: endpoint {
>>>> +		remote-endpoint = <&tfp410_out>;
>>>> +	};
>>>> +};
>>> 
>>> This looks far too simplistic.  There are different classes of DVI
>>> connector - there is:
>>> 
>>> DVI A - analogue only
>>> DVI D - digital only (single and dual link)
>>> DVI I - both (single and dual digital link)
>>> 
>>> DRM at least makes a distinction between these three classes, and this
>>> disctinction is part of the user API.  How would a display system know
>>> which kind of DVI connector is wired up on the board from this DT
>>> description?
>> 
>> Yes, I think that's a valid change. But do we also need to specify
>> single/dual link, in addition to the three types?
> 
> I would argue that as it's a difference in physical hardware, then it
> should be described in DT, even if we don't use it.  The reasoning is
> that although we may not use it today, we may need to use it in the
> future, and as we're describing what the hardware actually is - and
> even in this case what pins may be present or missing on the connector,
> it's unlikely to be problematical (the only problem is when someone
> omits it...)

And the ?we? that uses the DT files is larger than just the Linux, and one of
those systems may use it.

Warner
