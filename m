From: robherring2@gmail.com (Rob Herring)
Date: Mon, 11 Jul 2011 10:31:58 -0500
Subject: [PATCH v2 0/6] ARM: make mach/hardware.h optional
In-Reply-To: <201107021124.46953.arnd@arndb.de>
References: <1309366019-24379-1-git-send-email-robherring2@gmail.com>
	<201107021124.46953.arnd@arndb.de>
Message-ID: <4E1B176E.3030503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 07/02/2011 04:24 AM, Arnd Bergmann wrote:
> On Wednesday 29 June 2011 18:46:53 Rob Herring wrote:
>>
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Currently, all ARM platforms must have a mach/hardware.h include. This is
>> because it is ultimately included by linux/pci.h which is included in many
>> places even for !CONFIG_PCI.
>>
>> This could be fixed simply with an ifdef around the include of mach/hardware.h
>> in asm/pci.h. However, in the interest of fixing this for single kernel
>> binary builds, this series removes the include of mach/hardware.h outside of
>> mach-* and plat-*. What's used from hardware.h is a couple of PCI defines. 
>> Converting them to variables allows each platform to set the values as needed.
>>
>> This does not address the inclusion of mach/hardware.h under drivers/*. This
>> appears to be mostly older platforms. There could also be some indirect
>> inclusions from other mach/* headers.
>>
> 
> Hi Rob,
> 
> This is very good work, I really like it. I've mentioned one idea for
> an improvement in patch 5, which you can still integrate, but otherwise
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> for the whole series.
> 

I have an updated version ready to send out. Will you take this in your
tree including the 1st patch for pci flags functions? Also, what about
the powerpc conversion to generic pci flags?

Rob
