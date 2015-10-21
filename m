From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Wed, 21 Oct 2015 09:19:15 -0400
Subject: [PATCH v4 1/3] xen/arm: Enable cpu_hotplug.c
In-Reply-To: <alpine.DEB.2.02.1510211358250.27957@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1510211251370.27957@kaball.uk.xensource.com>
 <1445428430-21567-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1510211358250.27957@kaball.uk.xensource.com>
Message-ID: <562790D3.2090002@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2015 09:00 AM, Stefano Stabellini wrote:
>>
>> diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
>> index d866959..8b2d4be 100644
>> --- a/arch/x86/include/asm/xen/hypervisor.h
>> +++ b/arch/x86/include/asm/xen/hypervisor.h
>> @@ -57,4 +57,9 @@ static inline bool xen_x2apic_para_available(void)
>>   }
>>   #endif
>>   
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +void xen_arch_register_cpu(int num);
>> +void xen_arch_unregister_cpu(int num);
>> +#endif

Why not inline them here, just like you did for ARM?


-boris
