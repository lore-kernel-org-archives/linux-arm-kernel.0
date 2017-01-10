From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 10 Jan 2017 10:24:18 -0800
Subject: [PATCH 1/2] ARM: dts: imx6: Specify 'anatop-enable-bit' where
 appropriate
In-Reply-To: <CAOMZO5CnwrPcney0qzQgex_aFXCrksmEocZ28nf54Kvcm2dq-w@mail.gmail.com>
References: <20170110163015.22444-1-andrew.smirnov@gmail.com>
 <CAOMZO5CnwrPcney0qzQgex_aFXCrksmEocZ28nf54Kvcm2dq-w@mail.gmail.com>
Message-ID: <CAHQ1cqHhiCO8nMmYd_6r0Zx-oycVGf_0wo7x17rxbuJujxftww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 9:28 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Jan 10, 2017 at 2:30 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>> ENABLE_LINREG bit is implemented by 3P0, 1P1 and 2P5 regulators on
>> i.MX6. This property is present in similar code in Fresscale BSP and
>> made its way upstream in imx6ul.dtsi, so this patch adds this property
>> to the rest of i.MX6 family for completness.
>
> Please see:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/patch/arch/arm/boot/dts/imx6ul.dtsi?id=27958ccdf29e9971732e02494b48be54b0691269

Fabio:

I submitted a patch implementing this property to LKML as well, see
https://www.spinics.net/lists/kernel/msg2418471.html

All of these patches are a part of a broader attempt to add PCIe
support for i.MX7, and on that platform this is a part of a 1P0D
regulator which supplies PCIe PHY.

I can rebase this patch set to take your commit into account, or else
let's discuss the best way to allow setting ENABLE_LINREG.

Thanks,
Andrey Smirnov
