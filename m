From: lho@apm.com (Loc Ho)
Date: Tue, 26 Nov 2013 14:04:18 -0800
Subject: [PATCH v5 2/4] Documentation: Add documentation for APM X-Gene
 SoC SATA host controller DTS binding
In-Reply-To: <20131126145515.GD5402@e106331-lin.cambridge.arm.com>
References: <1385449285-30764-1-git-send-email-lho@apm.com>
 <1385449285-30764-2-git-send-email-lho@apm.com>
 <1385449285-30764-3-git-send-email-lho@apm.com>
 <20131126145515.GD5402@e106331-lin.cambridge.arm.com>
Message-ID: <CAPw-ZTm1wS0j2DphK9+Rmmu2UPJniobMUv6MTfMCG5wwKNvJCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> +- interrupt-parent   : Interrupt controller.
>
> I don't think that's strictly required.

Okay, got rip of it.

>> +Optional properties:
>> +- status             : Shall be "ok" if enabled or "na" if disabled.
>> +                       Default is "ok".
>
> Why not use the more standard "disabled" string, as I asked you to
> previously?

Missed this one. Fixed.

>> +             sata2: sata at 1a400000 {
>> +                     compatible = "apm,xgene-ahci-sgmii";
>> +                     reg = <0x0 0x1a400000 0x0 0x1000>,
>> +                           <0x0 0x1f220000 0x0 0x10000>;
>> +                     interrupt-parent = <&gic>;
>> +                     interrupts = <0x0 0x87 0x4>;
>> +                     status = "ok";
>> +                     clocks = <&sata23clk 0>;
>> +                     phys = <&phy2 0>;
>> +                     phy-names = "sata-6g";
>> +             };
>> +
>> +             sata3: sata at 1a800000 {
>> +                     compatible = "apm,xgene-ahci-pcie";
>> +                     reg = <0x0 0x1a800000 0x0 0x1000>,
>> +                           <0x0 0x1f230000 0x0 0x10000>;
>> +                     interrupt-parent = <&gic>;
>> +                     interrupts = <0x0 0x88 0x4>;
>> +                     status = "ok";
>> +                     clocks = <&sata45clk 0>;
>> +                     phys = <&phy3 0>;
>> +                     phy-names = "sata-6g";
>> +             };
>
> The example is pointlessly huge. You could trim it down two these last
> two nodes (with a phy node and some fixed clocks).

I will use dummy fixed clock and added two PHY nodes.

-Loc
