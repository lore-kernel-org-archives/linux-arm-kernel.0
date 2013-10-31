From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 31 Oct 2013 10:17:43 +0100
Subject: [PATCH 1/2] ARM: kirkwood: add support for OpenBlocks A7 platform
In-Reply-To: <20131031093735.68aa7df1@skate>
References: <1383152110-19577-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1383152110-19577-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20131030195724.GI26784@titan.lakedaemon.net> <20131031093735.68aa7df1@skate>
Message-ID: <52722037.8050808@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/10/2013 09:37, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Wed, 30 Oct 2013 15:57:25 -0400, Jason Cooper wrote:
> 
>>> +			partition at 0 {
>>> +				label = "uboot";
>>> +				reg = <0x0 0x1c0000>;
>>> +			};
>>> +
>>> +			partition at 90000 {
>>> +				label = "env";
>>> +				reg = <0x1c0000 0x2c0000>;
>>> +			};
>>
>> Hmm, something doesn't look right here.  Cut-n-paste problem?  Did you
>> run 'make dtbs' against this?  I get address size errors when I do.
> 
> Strange. 'make dtbs' was working here. What was wrong exactly? Just
> that the unit address (@90000) didn't match the starting address
> 0x1c0000 ?

The unit address has no special meaning for the device tree it's just a
way to give a unique name to a node right?

So in this case it is not really a problem, but it's just nicer for the
coherency of the information in the dt to have the unit address which match
the starting address.

I also do a make dtbs ans I didn't get any errors:
$ make dtbs
 [...]
  DTC     arch/arm/boot/dts/kirkwood-openblocks_a6.dtb
  DTC     arch/arm/boot/dts/kirkwood-openblocks_a7.dtb

Regards,
> 
>> let me know if it's ok with you and I'll push it tomorrow.
> 
> This all looks good to me!
> 
> Thanks a lot,
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
