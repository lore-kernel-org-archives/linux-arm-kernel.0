From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 6 Mar 2015 11:31:06 -0600
Subject: [PATCH 0/2] pinctrl: dt-bindings: Fix amx3 SLEWCTRL_FAST binding
In-Reply-To: <20150306171351.GU13520@atomide.com>
References: <1425085827-4514-1-git-send-email-d-gerlach@ti.com>
 <20150306171351.GU13520@atomide.com>
Message-ID: <54F9E45A.2020903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2015 11:13 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [150227 17:14]:
>> Currently both am33xx and am43xx have the macro for SLEWCTRL_FAST
>> in pinctrl dt-bindings reversed so that selecting the macro actually
>> sets SLEWCTRL_SLOW in the pad control registers. These patches
>> correct the bindings but leave the pinctrl states that use the binding
>> *UNMODIFIED*. Previously i2c and mdio on am33xx and i2c, mdio, and
>> uart on am43xx had been using this macro and selecting SLEWCTRL_FAST
>> while actually programming SLEWCTRL_SLOW in the pad config registers.
>>
>> Because the intended selection was SLEWCTRL_FAST the macros are
>> unchanged. I tested on am335x-gp-evm and am437x-gp-evm with no
>> difference in functionality seen.
> 
> Applying both into omap-for-v4.0/fixes thanks.

Thanks!

Regards,
Dave

> 
> Tony
> 
