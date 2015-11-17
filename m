From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 17 Nov 2015 13:57:41 +0000
Subject: [PATCH v3 01/62] Revert "xen/arm: vgic-v2: Drop cbase from
 arch_domain"
In-Reply-To: <564B1E62.8080208@huawei.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-2-git-send-email-shannon.zhao@linaro.org>
 <564B0F1E.9040804@citrix.com> <564B1E62.8080208@huawei.com>
Message-ID: <564B3255.6040108@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/15 12:32, Shannon Zhao wrote:
> Hi Julien,
> 
> On 2015/11/17 19:27, Julien Grall wrote:
>> Hi Shannon,
>>
>> Why do you want to revert this patch?
>>
> Because d->arch.vgic.cbase will be used by creating Dom0 MADT table
> later. See [PATCH v3 43/62].
> +            gicc.base_address = d->arch.vgic.cbase;
> 
> My previous way is get this from ACPI table but someone suggest get it
> from struct domain and I think this way is better too since it uses the
> value after being parsed.

It's pointless to store the value in arch_domain for something that it's
only use during building...

We have struct kernel_info which store any information related to the
DOM0 during the building.

> And sorry that I didn't notice this patch before when you send it out to
> list.

In any case you have to explain in the commit message why you want to
revert the patch.

Regards,

-- 
Julien Grall
