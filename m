From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 31 Jul 2014 23:09:58 +0200
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DAA8E6.3010400@suse.de>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <53DA936E.9060004@gmail.com> <53DAA8E6.3010400@suse.de>
Message-ID: <53DAB0A6.9030700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 31.07.2014 22:36, Andreas F?rber wrote:
> Am 31.07.2014 21:05, schrieb Tomasz Figa:
>>> +	};
>>> +
>>> +	fixed-rate-clocks {
>>> +		xxti {
>>> +			compatible = "samsung,clock-xxti";
>>> +			clock-frequency = <24000000>;
>>> +		};
>>> +	};
>>
>> This is also referencing a node from higher level, so it should be done
>> using a reference.
> 
> Actually this one isn't! Neither fixed-rate-clocks nor xxti exists in
> the .dtsi.

You've got me here. :)

In new dts I actually suggest to specify those on SoC level, since they
are generic SoC inputs and just override their frequencies on board
level, but apparently Exynos5250 doesn't follow this fashion. So this is
fine as is, sorry for noise.

Best regards,
Tomasz
