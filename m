From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 9 Aug 2011 23:08:09 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <20110809205723.GE11568@ponder.secretlab.ca>
References: <4E40FC88.5090403@ti.com>
	<20110809162907.GA630@manju-WNB7PBC4801-0006>
	<4E4166F0.9050401@ti.com>
	<CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
	<4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com>
	<20110809205723.GE11568@ponder.secretlab.ca>
Message-ID: <4E41A1B9.1060400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/9/2011 10:57 PM, Grant Likely wrote:
> On Tue, Aug 09, 2011 at 01:26:29PM -0500, Scott Wood wrote:
>> On 08/09/2011 12:47 PM, Cousson, Benoit wrote:
>>> On 8/9/2011 7:23 PM, Grant Likely wrote:
>>>> There is no analogous mechanism for _byname in the device tree.  The
>>>> DT binding for a device must explicitly state what order the register
>>>> ranges are in.  The driver will need to be adapted.
>>>
>>> That seems to be a small regression for my point of view. Relying on the
>>> order is not super safe. This is not very readable either. That's for
>>> that exact reason that we changed our drivers to use
>>> platform_get_resource_byname. That's probably the reason why that API is
>>> there as well.
>>> For the same IP, the number of entries can vary depending of the SoC
>>> revision.
>>> By using the _byname, we can check if the resource is there or not
>>> without having to care about the position.
>>
>> You could have a named u32 property that contains the reg index, e.g.:
>>
>> dev {
>> 	reg =<0x20000 0x200 0x24000 0x200>;
>> 	foo-reg =<0>;
>> 	bar-reg =<1>;
>> };
>
> That's a little nasty.  A reg-names = "foo", "bar"; would probably be
> better.

Yep, I agree.

And what about something like that?
   reg = <0x20000 0x200>, "foo",
	<0x20000 0x200>, "bar" ;

It is doable?

Regards,
Benoit
