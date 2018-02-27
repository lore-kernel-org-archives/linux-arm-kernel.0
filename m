From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 27 Feb 2018 20:23:20 +0100
Subject: [PATCH 3/3] ARM: mach-stm32: Add Extended TrustZone Protection
 driver
In-Reply-To: <20180227171419.3nlz23qzptvew2as@lakrids.cambridge.arm.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227140926.22996-4-benjamin.gaignard@st.com>
 <20180227171419.3nlz23qzptvew2as@lakrids.cambridge.arm.com>
Message-ID: <CA+M3ks5xreBsZOoVFrDcP8DxgfNe6d4kduB-Fz=RgHSdT045QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-27 18:14 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> On Tue, Feb 27, 2018 at 03:09:26PM +0100, Benjamin Gaignard wrote:
>  +
>> +static const u32 stm32mp1_ip_addr[] = {
>> +     0x5c008000,     /* 00 stgenc */
>> +     0x54000000,     /* 01 bkpsram */
>> +     0x5c003000,     /* 02 iwdg1 */
>> +     0x5c000000,     /* 03 usart1 */
>> +     0x5c001000,     /* 04 spi6 */
>> +     0x5c002000,     /* 05 i2c4 */
>
> ...
>
> This duplicates information that is in the DT, which is unfortunate.

Yes I would have prefer to be able to get this information from etzpc
hardware itself
but that isn't the case so I need this table to found the status bits
of each device.

>
> Why can these not be marked disabled inthe DT instead?
>
> If it's dynamic form boot-to-boot, then the FW can probe this prior to
> entering Linux, and patch the DT appropriately.

I know that is one software way to do, but let discusted about that in
cover letter thread.

Thanks,
Benjamin

>
> Thanks,
> Mark.
