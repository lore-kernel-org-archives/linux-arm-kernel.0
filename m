From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 12 Apr 2015 11:57:35 +0100
Subject: [PATCH 3/3] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <CAAS=xmgySDmwNpx5xpHd15M-1eJLvPBhudhGu+cRqw3g_X_SZA@mail.gmail.com>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
 <1423128277-10297-4-git-send-email-bintian.wang@huawei.com>
 <20150205193017.GF20735@leverpostej>
 <CAAS=xmgsuY=c8-n_pDiZjLe2u+SPX7msRje7h0sNkRtT3HLfQA@mail.gmail.com>
 <CAAS=xmgySDmwNpx5xpHd15M-1eJLvPBhudhGu+cRqw3g_X_SZA@mail.gmail.com>
Message-ID: <7a9107efdfe64b0d9e9d93421595badb@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-12 07:40, Brent Wang wrote:
> Hello Mark,
>
> 2015-02-06 16:42 GMT+08:00 Brent Wang <wangbintian@gmail.com>:
> [...]
>>>
>>>> +     gic: interrupt-controller at f6800000 {
>>>> +             compatible = "arm,gic-400", "arm,cortex-a15-gic";
>>>
>>> Surely there's no need for the "arm,cortex-a15-gic" fallback entry? 
>>> What
>>> am I missing?
>> Remove it in next version.
> After remove "arm,cortex-a15-gic", I get the following error during
> kernel booting:
> -----
> kvm [1]: Using HYP init bounce page @396d9000
> kvm [1]: error: no compatible GIC node found
> kvm [1]: error initializing Hyp mode: -19
> -----
>
> Check code "virt/kvm/arm/vgic.c", gicv2 only "cortex-a15-gic" and
> gicv3 support kvm now,
> so I think we should keep it, how about your idea?

Please look at commit 0f37247574b3 that is queued for merge in 4.1.
It adds the required compatibility strings to KVM, so Mark is perfectly
right to ask you to drop this "cortex-a15-gic" from your DT.

This DT won't be merged before 4.1 anyway, so there is no point trying
to make it work with older kernels.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
