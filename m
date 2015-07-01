From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 1 Jul 2015 06:45:28 +0200
Subject: [PATCH] bcma: populate bus DT subnodes as platform_device-s
In-Reply-To: <55930E01.6070909@hauke-m.de>
References: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
 <55930E01.6070909@hauke-m.de>
Message-ID: <CACna6rz4zoDbhK48cRcRUrPpV+DXrGA0Lq-cRGOeB=A=ZnCbvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2015 at 23:45, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 06/28/2015 05:17 PM, Rafa? Mi?ecki wrote:
>> Our bus should allow defining children nodes as we may want to specify
>> devices attached to the bus. This is required e.g. to specify NAND or
>> ChipCommon cores and use bus's address and IRQ mappings.
>>
>> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
>> ---
>>  drivers/bcma/main.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>
> Rafa? have you solved the IRQ problem? Is it possible to assign all the
> sub devices the same IRQ number as the chipcommon core?

Not yet. The only working solution I have so far is:
serial0: serial at 0300 {
        compatible = "ns16550";
        reg = <0x0300 0x100>;
        interrupt-parent = <&gic>;
        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
        clock-frequency = <100000000>;
};
(plus adding compatible = "simple-bus" to the chipcommon).

-- 
Rafa?
