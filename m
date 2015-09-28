From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 28 Sep 2015 14:59:18 +0100
Subject: [Xen-devel] [PATCH] xen/pci: Don't build Xen pci code for ARM
 and ARM64
In-Reply-To: <56094600.7050508@citrix.com>
References: <1443447044-24985-1-git-send-email-julien.grall@citrix.com>
 <56094600.7050508@citrix.com>
Message-ID: <560947B6.1030101@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 28/09/15 14:52, David Vrabel wrote:
> On 28/09/15 14:30, Julien Grall wrote:
>> The PCI support for Xen doesn't compile on ARM/ARM64 when
>> CONFIG_PCI_MMCONFIG=y:
>>
>> drivers/xen/pci.c:31:25: fatal error: asm/pci_x86.h: No such file or
>> directory
>>  #include <asm/pci_x86.h>
>>
>> Although, Xen is not currently involved in PCI management for ARM/ARM64.
>> There is plan to support it, but it would require some changes in Linux
>> side.
>>
>> For now, introduce a new config options XEN_PCI which will be turned off
>> for ARM platform.
> 
> Since PCI_MMCONFIG isn't x86 specific and its use in drivers/xen/pci.c
> is, can you fix this by changing to #ifdef CONFIG_X86?

Well, it may be possible that we need this code for ARM/ARM64.

>From the origin thread [1], it wasn't clear what is the correct
solution. So I think that disabling the Xen PCI code for now is the
right solution.

Note, that it's still possible to use PCI in DOM0 on ARM64 platform
without this code.

Regards,

[1] https://lkml.org/lkml/2015/8/6/510

-- 
Julien Grall
