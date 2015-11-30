From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 30 Nov 2015 15:30:54 +0000
Subject: [PATCH v3 58/62] xen/acpi: Fix event-channel interrupt when
 booting with ACPI
In-Reply-To: <alpine.DEB.2.02.1511271510350.8984@kaball.uk.xensource.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-59-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511271510350.8984@kaball.uk.xensource.com>
Message-ID: <565C6BAE.5000600@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/15 15:12, Stefano Stabellini wrote:
>> +    }
>> +    else
>> +    {
>> +        int type = 3;
>> +        int flag = 2; /* Active-low level-sensitive  */
>> +        d->arch.hvm_domain.params[HVM_PARAM_CALLBACK_IRQ] = (u64)type << 56
>> +                                                            | flag << 8
>> +                                                            | d->arch.evtchn_irq;
>> +    }
>>  }
> 
> Actually there is no point in setting HVM_PARAM_CALLBACK_IRQ only on
> ACPI: I would just set it on all cases.

+1

Regards,

-- 
Julien Grall
