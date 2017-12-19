From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Dec 2017 07:24:39 -0500
Subject: [PATCH V4 02/26] powerpc/PCI: deprecate pci_get_bus_and_slot()
In-Reply-To: <87fu879fki.fsf@concordia.ellerman.id.au>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-3-git-send-email-okaya@codeaurora.org>
 <87fu879fki.fsf@concordia.ellerman.id.au>
Message-ID: <4ef64790-5ad1-c5e5-af80-7bf4ef3abdee@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2017 5:29 AM, Michael Ellerman wrote:
> Sinan Kaya <okaya@codeaurora.org> writes:
> 
>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>> where a PCI device is present. This restricts the device drivers to be
>> reused for other domain numbers.
>>
>> Getting ready to remove pci_get_bus_and_slot() function in favor of
>> pci_get_domain_bus_and_slot().
>>
>> Use pci_get_domain_bus_and_slot() with a domain number of 0 as the code
>> is not ready to consume multiple domains and existing code used domain
>> number 0.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  arch/powerpc/kernel/pci_32.c              | 3 ++-
>>  arch/powerpc/platforms/powermac/feature.c | 2 +-
>>  arch/powerpc/sysdev/mv64x60_pci.c         | 4 ++--
>>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> Looks to do what it says. I don't know if any of these call sites could
> be improved to provide the domain, but that's not really your problem.
> 

I tried to fix the places where I can at the rest of the series. I even took
a stab at fixing powerpc. There were places where the domain information was
not available and I couldn't locate where to extract it. I decided to leave it
as it is and hope that someone someday may expand the powerpc PCI adaptation. 

> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 
> cheers
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
