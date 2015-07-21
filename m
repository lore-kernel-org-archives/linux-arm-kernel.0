From: danindrey@mail.ru (Andrey Danin)
Date: Tue, 21 Jul 2015 09:35:21 +0300
Subject: [PATCH v3 4/4] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <55AD73F4.2050502@wwwdotorg.org>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <1437424546-30405-5-git-send-email-danindrey@mail.ru>
 <55AD73F4.2050502@wwwdotorg.org>
Message-ID: <55ADE829.4030108@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.07.2015 1:19, Stephen Warren wrote:
> On 07/20/2015 02:35 PM, Andrey Danin wrote:
>> NVEC driver was reimplemented to use tegra i2c. Use common i2c bindings
>> for NVEC node.
>
>> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
>> b/arch/arm/boot/dts/tegra20-paz00.dts
>
>> +        nvec: nvec at 45 {
>> +            compatible = "nvidia,nvec-slave";
>> +            reg = <0x45>;
>
> I think you need to or in I2C_OWN_SLAVE_ADDRESS from
> <dt-bindings/i2c/i2c.h> here?

Sorry, I mentioned it in letter 0 only.
I will rework nvec driver and device tree according to i2c core slave 
implementation later. v3 of this patchset is for fixing tegra i2c driver 
only.
