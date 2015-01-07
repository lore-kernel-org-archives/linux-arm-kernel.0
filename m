From: mchitale@apm.com (Mayuresh Chitale)
Date: Wed, 7 Jan 2015 16:15:54 +0530
Subject: [PATCH 3/4] arm64: dts: Add APM X-Gene PCIe DMA device tree nodes
In-Reply-To: <6884775.IcL8KCPQhi@wuerfel>
References: <1420608537-12296-1-git-send-email-mchitale@apm.com>
 <1420608537-12296-4-git-send-email-mchitale@apm.com>
 <6884775.IcL8KCPQhi@wuerfel>
Message-ID: <CAL-zptPDU2qoot-aZMDwRmPQ_4QoCsqtQZ=kc-fN-Ts68qrVDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Actually the addresses are different. For e.g port 0 base address is
1F2B0000 and port 1 base address is 1F2C0000 and so on.

Thanks,
Mayuresh.

On Wed, Jan 7, 2015 at 2:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 07 January 2015 10:58:56 Mayuresh Chitale wrote:
>>
>> +               xpdma0: dma0 at 1f2b0154 {
>> +                       status = "disabled";
>> +                       compatible = "apm,xgene-pciedma";
>> +                       reg = < 0x0 0x1f2b0154 0x0 0xc
>> +                               0x0 0x1f2b0058 0x0 0x8>;
>> +                       interrupts = <0x0 0xc6 0x4>;
>> +               };
>> +
>> +               xpdma1: dma1 at 1f2c0154 {
>> +                       status = "disabled";
>> +                       compatible = "apm,xgene-pciedma";
>> +                       reg = < 0x0 0x1f2c0154 0x0 0xc
>> +                               0x0 0x1f2c0058 0x0 0x8>;
>> +                       interrupts = <0x0 0xcc 0x4>;
>> +               };
>> +
>>
>
> Something's wrong here: you have the same addresses for
> all the nodes but use different names. Please change the names
> to all say 'dma' and set the correct addresses.
>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
