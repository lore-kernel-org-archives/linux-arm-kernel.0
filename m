From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Oct 2014 14:28:39 +0200
Subject: [PATCH 2/4] ARM: mvebu: Move SCU power up in a function
In-Reply-To: <20141024141958.319af5d3@free-electrons.com>
References: <1414088070-12510-1-git-send-email-gregory.clement@free-electrons.com>
 <1414088070-12510-3-git-send-email-gregory.clement@free-electrons.com>
 <20141024140551.0890f204@free-electrons.com>
 <544A41E5.2090802@free-electrons.com>
 <20141024141958.319af5d3@free-electrons.com>
Message-ID: <544A45F7.5070300@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 24/10/2014 14:19, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Fri, 24 Oct 2014 14:11:17 +0200, Gregory CLEMENT wrote:
> 
>>> Since this function is not static, I think it might be a good idea to
>>> use a prefix that makes it more specific to the platform in order to
>>> not pollute the global namespace. Maybe something like
>>> 'armada_38x_scu_power_up', or something like that.
>>
>> Yes given the fact that this function is declared in the mach-mveu folder
>> it is sensible to use a more specific name. However the function itself
>> is not specific at all to an SoC. This function could be used for any Cortex A9
>> using the SCU.
> 
> Indeed, but as you say, it's right now defined in the mvebu specific
> code, so we shouldn't pollute the global namespace.
> 
> Note that there is already a scu_power_mode() that does the same thing,

I know this function: I used it for the idle support.

> but implemented in C, so I'm not sure you can call it at search an early
> point.

you meant "such" instead of "search" I guess, and yes unfortunately we can't use
a C function at this step.

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
