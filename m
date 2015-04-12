From: wangbintian@gmail.com (Brent Wang)
Date: Sun, 12 Apr 2015 14:40:46 +0800
Subject: [PATCH 3/3] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <CAAS=xmgsuY=c8-n_pDiZjLe2u+SPX7msRje7h0sNkRtT3HLfQA@mail.gmail.com>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
 <1423128277-10297-4-git-send-email-bintian.wang@huawei.com>
 <20150205193017.GF20735@leverpostej>
 <CAAS=xmgsuY=c8-n_pDiZjLe2u+SPX7msRje7h0sNkRtT3HLfQA@mail.gmail.com>
Message-ID: <CAAS=xmgySDmwNpx5xpHd15M-1eJLvPBhudhGu+cRqw3g_X_SZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

2015-02-06 16:42 GMT+08:00 Brent Wang <wangbintian@gmail.com>:
[...]
>>
>>> +     gic: interrupt-controller at f6800000 {
>>> +             compatible = "arm,gic-400", "arm,cortex-a15-gic";
>>
>> Surely there's no need for the "arm,cortex-a15-gic" fallback entry? What
>> am I missing?
> Remove it in next version.
After remove "arm,cortex-a15-gic", I get the following error during
kernel booting:
-----
kvm [1]: Using HYP init bounce page @396d9000
kvm [1]: error: no compatible GIC node found
kvm [1]: error initializing Hyp mode: -19
-----

Check code "virt/kvm/arm/vgic.c", gicv2 only "cortex-a15-gic" and
gicv3 support kvm now,
so I think we should keep it, how about your idea?

Thanks,

Bintian

>>
>>> +             reg = <0x0 0xf6801000 0x0 0x1000>, /* GICD */
>>
>> This doesn't match the unit-address.
> Do you mean change to "<0x0 0xf6801000 0 0x1000>" ?
>
>>
>>> +                   <0x0 0xf6802000 0x0 0x2000>, /* GICC */
>>> +                   <0x0 0xf6804000 0x0 0x2000>, /* GICH */
>>> +                   <0x0 0xf6806000 0x0 0x2000>; /* GICV */
>>
>> I guess no-one's bothered to consider 64k pages?
>>
>> Given GICH and GICV, I hope that this platform is booted at EL2?
> Transfer from EL3 to EL1 directly, keep these two just for future use.
>
>>
>>> +             #interrupt-cells = <3>;
>>> +             #address-cells = <0>;
>>> +             interrupt-controller;
>>> +     };
>>> +
>>> +
[...]
