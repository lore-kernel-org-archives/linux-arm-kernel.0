From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Jul 2014 12:07:53 +0200
Subject: [PATCH 03/16] ARM: mvebu: Add function to export the physical
 address of the boot register
In-Reply-To: <20140703112538.533b73e1@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-4-git-send-email-gregory.clement@free-electrons.com>	<20140630144620.0030cf94@free-electrons.com>	<53B516D8.8070003@free-electrons.com>
 <20140703112538.533b73e1@free-electrons.com>
Message-ID: <53B52B79.8080409@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 03/07/2014 11:25, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Thu, 03 Jul 2014 10:39:52 +0200, Gregory CLEMENT wrote:
> 
>>> I'm not sure that the best approach to solve this problem. Instead,
>>> maybe the system-controller.c code should set up the boot address
>>> workaround on Armada 375. Since the workaround on 375 is really related
>>> to setting the boot address which is done by the system controller,
>>> maybe the initialization of the workaround belongs in
>>> system-controller.c ?
>>
>> So moving the workaround into mvebu_system_controller_set_cpu_boot_addr()
>> should be the thing to do.
> 
> Except that mvebu_system_controller_set_cpu_boot_addr() is called
> multiple times during the system execution, while you want the
> workaround to be initialized once. And we surely don't really want a
> static variable in there to test if the workaround has already been
> initialized or not.

Actually mvebu_system_controller_set_cpu_boot_addr()? is called only in
mvebu_cortex_a9_boot_secondary() just after the call to mvebu_boot_addr_wa().

So it won't change anything. Moreover the call to mvebu_cortex_a9_boot_secondary()
is not expected to be done too often  during the system execution.

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
