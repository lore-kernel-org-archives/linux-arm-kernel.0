From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Jul 2014 14:51:44 +0200
Subject: [PATCH 11/16] ARM: mvebu: dts: Add CA9 MPcore SoC Controller node
In-Reply-To: <20140630173755.32793586@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-12-git-send-email-gregory.clement@free-electrons.com>
 <20140630173755.32793586@free-electrons.com>
Message-ID: <53B551E0.6040103@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,


> On Fri, 27 Jun 2014 15:22:52 +0200, Gregory CLEMENT wrote:
>> The CA9 MPcore SoC Control block allows to do some configuration that
>> the SoC could use for a specific use case. In most cases the defaults
>> case is enough. However there is few exception: for cpuidle we need to
>> use the CA9 MPcore Reset Control register.
> 
> I'd reword this to something like:
> 
> """
> The CA9 MPcore SoC Control block is a set of registers that allows to
> configure certain internal aspects of the core blocks of the SoC
> (Cortex-A9, L2 cache controller, etc.). In most cases, the default
> values are fine so they aren't many reasons to touch those registers,
> but there is one exception: to support cpuidle on Armada 38x, we need
> to modify the value of the CA9 MPcore Reset Control register.
> 
> Therefore, this commit adds a new Device Tree binding for this hardware
> block, and uses this new binding for the Armada 38x Device Tree file.
> 
> """

[...]

>> +- reg: should be register base and length as documented in the
> 
> should be *the* register base and length
> 
			reg = <0x21010 0x1c>;
> 
> With those fixed:
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


I will apply your change.

Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
