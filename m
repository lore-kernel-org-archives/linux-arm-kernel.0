From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 29 Sep 2015 12:14:45 +0200
Subject: [linux-sunxi] [PATCH] i2c: mv64xxx: The n clockdiv factor is 0
 based on sunxi SoCs
In-Reply-To: <20150927165303.GI31209@lunn.ch>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
 <560813CF.4000807@schinagl.nl> <20150927165303.GI31209@lunn.ch>
Message-ID: <560A6495.1000606@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-09-15 18:53, Andrew Lunn wrote:
> On Sun, Sep 27, 2015 at 06:05:35PM +0200, Olliver Schinagl wrote:
>> Hey Hans,
>>
>> On 27-09-15 16:57, Hans de Goede wrote:
>>> According to the datasheets to n factor for dividing the tclk is
>>> 2 to the power n on Allwinner SoCs, not 2 to the power n + 1 as it is
>>> on other mv64xxx implementations.
>> Ah!
>
> Just to be sure, i checked Kirkwood, Armada XP and Armada 370
> datasheets. They all say n+1.

Thanks.

>>> +	if (of_device_is_compatible(np, "allwinner,sun4i-a10-i2c") ||
>>> +	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
>
> Rather than have to extend this list every so often, how about adding
> a helper of_device_is_compatible_vendor(), so you can just have:
>
>>> +	if (of_device_is_compatible_vendor(np, "allwinner")

I agree that if such a helper would already exist it would be a good
idea to use it, but it seems overkill to just at it for this.

Regards,

Hans
