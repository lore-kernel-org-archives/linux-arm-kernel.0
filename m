From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 27 Mar 2014 16:58:28 +0100
Subject: [PATCH 1/6] ARM: mvebu: introduce CPU reset code
In-Reply-To: <20140327151945.365db704@skate>
References: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>	<1395927485-11842-2-git-send-email-thomas.petazzoni@free-electrons.com>	<53342EF1.3020508@free-electrons.com>
 <20140327151945.365db704@skate>
Message-ID: <53344AA4.4040805@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/2014 15:19, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Thu, 27 Mar 2014 15:00:17 +0100, Gregory CLEMENT wrote:
> 
>>> +static struct of_device_id of_cpu_reset_table[] = {
>>> +	{.compatible = "marvell,armada-370-cpu-reset", .data = (void*) ARMADA_370_MAX_CPUS },
>> What about removing the previous line. As explained in patch 5, the CPU
>> reset driver is not really needed as Armada 370 is single core and the
>> only use of the CPU reset driver is to boot secondary processors. So by
>> removing this line we can keep the marvell,armada-370-cpu-reset node in
>> the device tree without doing useless initialization.
> 
> I found it weird to have a compatible string marked as supported in the
> DT binding document, but not actually supported by the kernel. I know
> it's possible, but I found it odd, especially considering the fact that
> mapping these registers, even if unused, isn't costing much.
> 
> I don't have a strong opinion on this, so if others voice in this way,
> I'll change it.

Me neither I don't have a strong opinion on ths, so with our without this line,
you can add my:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

and also:

Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

by the way



> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
