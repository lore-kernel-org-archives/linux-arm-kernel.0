From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 17 Nov 2015 20:32:34 +0800
Subject: [PATCH v3 01/62] Revert "xen/arm: vgic-v2: Drop cbase from
 arch_domain"
In-Reply-To: <564B0F1E.9040804@citrix.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-2-git-send-email-shannon.zhao@linaro.org>
 <564B0F1E.9040804@citrix.com>
Message-ID: <564B1E62.8080208@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 2015/11/17 19:27, Julien Grall wrote:
> Hi Shannon,
> 
> Why do you want to revert this patch?
> 
Because d->arch.vgic.cbase will be used by creating Dom0 MADT table
later. See [PATCH v3 43/62].
+            gicc.base_address = d->arch.vgic.cbase;

My previous way is get this from ACPI table but someone suggest get it
from struct domain and I think this way is better too since it uses the
value after being parsed.

And sorry that I didn't notice this patch before when you send it out to
list.

-- 
Shannon
