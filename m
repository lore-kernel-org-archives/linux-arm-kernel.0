From: julien.grall@arm.com (Julien Grall)
Date: Wed, 6 Apr 2016 18:40:41 +0100
Subject: [PATCH v5 4/9] irqchip/gic-v2: Parse and export virtual GIC
 information
In-Reply-To: <20160406170432.GD8961@cbox>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <1459769860-6629-5-git-send-email-julien.grall@arm.com>
 <20160406170432.GD8961@cbox>
Message-ID: <57054A19.1090208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 06/04/2016 18:04, Christoffer Dall wrote:
> On Mon, Apr 04, 2016 at 12:37:35PM +0100, Julien Grall wrote:
>> diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
>> new file mode 100644
>> index 0000000..ef34f6f
>> --- /dev/null
>> +++ b/include/linux/irqchip/arm-gic-common.h
>
> just out of curiosity, why is include/linux/irqchip/arm-gic.h not
> suitable?

Because arm-gic.h contains the definitions for GICv2 only. At least one 
of them is clashing with the GICv3 ones.

For instance, the function gic_send_sgi is defined statically the in 
GICv3 code, but exported for GICv2.

Regards,

-- 
Julien Grall
