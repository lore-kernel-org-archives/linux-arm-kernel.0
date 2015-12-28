From: lftan@altera.com (Ley Foon Tan)
Date: Mon, 28 Dec 2015 15:42:00 +0800
Subject: [PATCH] doc: PCI: altera: Fix the 'ranges' property in example
In-Reply-To: <201512280834.52893.marex@denx.de>
References: <1450950330-28393-1-git-send-email-marex@denx.de>
 <1451285775.2990.2.camel@ubuntu> <201512280834.52893.marex@denx.de>
Message-ID: <CAFiDJ5_Xy_O3Ux6ojcY-hEm3d4O8QXBR1e5KSUyThszZ40aWHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2015 at 3:34 PM, Marek Vasut <marex@denx.de> wrote:
> On Monday, December 28, 2015 at 07:56:15 AM, Ley Foon Tan wrote:
>> On Thu, 2015-12-24 at 10:45 +0100, Marek Vasut wrote:
>> > The example does not work on real hardware with the PCIe HIP [1].
>> > The problem is with incorrect "ranges" property in the example, so
>> > one cannot just copy-paste the example into his DT and expect this
>> > to work. This patches aligns the "ranges" in the example with the
>> > reference FPGA design.
>>
>> Hi Marek
>
> Hi Ley,
>
>> The original "ranges" is working for me. What error did you encounter?
>
> Every time a driver accessed the Txs range, the system got stuck hard.
> The Cra access always worked fine though, so the PCIe devices were always
> detected.
>
> I checked with signaltap and my impression is that the wrong address
> propagated into the request passed to the Txs port of the HardIP block,
> unless I change the range configuration.
>
> Note that I tested Intel Centrino 6235 WiFi card and Atheros AR5006 WiFi
> card. The intel in particular uses both the Txs and even MSI , so to use
> the intel, the whole PCIe block has to work properly ; with this change,
> it does and I can use the intel card just fine.
>
>> Thanks.
>>
Hi Marek

I tested two Ethernet adapters, one SSD NVMe and our custom endpoint
without the problem.
Can you please send me your dts file if possible?

Do you use the latest Altera pcie driver in v4.4?

Thanks.

Regards
Ley Foon
