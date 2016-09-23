From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 23 Sep 2016 14:42:07 +0100
Subject: [PATCH 1/2] armv8: aarch32: Execute 32-bit Linux for LayerScape
 platforms
In-Reply-To: <c6697a9c-013b-9880-e52f-8de2f0a5b7ae@arm.com>
References: <1474597146-33312-1-git-send-email-b18965@freescale.com>
 <f4195baa-907d-2c00-eb62-d4452ed749c8@arm.com>
 <VI1PR0401MB2638049F479731B3CC903B248DC80@VI1PR0401MB2638.eurprd04.prod.outlook.com>
 <c6697a9c-013b-9880-e52f-8de2f0a5b7ae@arm.com>
Message-ID: <a2a4e3ce-8a69-58a5-7c56-ff5af9d47f95@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/09/16 14:18, Robin Murphy wrote:
> On 23/09/16 14:13, Stuart Yoder wrote:
>>
>>

[...]

>>
>> Which arch/arm/mach-* platform are you using for Juno?
>
> I don't even know! :) I just start with a multi_v7_defconfig plus a few
> extra bits (LPAE, KVM, sil24, sky2, etc.) and it works. I guess it's the
> combination of mach-vexpress and mach-virt.
>

It should be matching "arm,vexpress" and just using mach-vexpress/v2m.c
as it's present as compatible in Juno DT but nothing else there.

mach-virt was deleted and we just have "Generic DT based system" in
arch/arm/kernel/devtree.c which IIUC doesn't require any compatible in
the DT. So dropping "arm,vexpress" will make it use "Generic DT based
system" I believe.

-- 
Regards,
Sudeep
