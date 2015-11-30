From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 30 Nov 2015 15:41:24 +0000
Subject: [Xen-devel] [PATCH v3 55/62] arm/acpi: Route all Xen unused SPIs
 to Dom0
In-Reply-To: <alpine.DEB.2.02.1511271456560.8984@kaball.uk.xensource.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-56-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511271456560.8984@kaball.uk.xensource.com>
Message-ID: <565C6E24.7020003@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/15 15:04, Stefano Stabellini wrote:
>> +        vgic_reserve_virq(d, i);
>> +        irq_set_type(i, ACPI_IRQ_TYPE_NONE);
> 
> I don't know if there is any point in setting the type to NONE. It's the
> default, isn't it?

No, the default is *_IRQ_TYPE_INVALID.

Regards,

-- 
Julien Grall
