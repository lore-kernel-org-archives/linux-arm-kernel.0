From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 7 Jan 2016 14:58:49 +0800
Subject: [PATCH v3 59/62] xen/arm: Add a hypercall for device mmio mapping
In-Reply-To: <564B17EA02000078000B5D34@prv-mh.provo.novell.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-60-git-send-email-shannon.zhao@linaro.org>
 <564B17EA02000078000B5D34@prv-mh.provo.novell.com>
Message-ID: <568E0CA9.4090307@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On 2015/11/17 19:04, Jan Beulich wrote:
>>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
>> > --- a/xen/arch/arm/mm.c
>> > +++ b/xen/arch/arm/mm.c
>> > @@ -1138,6 +1138,10 @@ int xenmem_add_to_physmap_one(
>> >          rcu_unlock_domain(od);
>> >          break;
>> >      }
>> > +    case XENMAPSPACE_dev_mmio:
>> > +        rc = map_dev_mmio_region(d, gpfn, 1, idx);
>> > +        return rc;
>> > +        break;
> Blindly for any kind of domain? The XSM check in the
> XENMEM_add_to_physmap_batch handler (in common code) doesn't
> even know which map space is to be used...

Sorry, I know little about XSM. Could you suggest me how to add the
check for this new type here?

Thanks,
-- 
Shannon
