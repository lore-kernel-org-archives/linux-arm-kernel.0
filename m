From: liwei213@huawei.com (liwei (CM))
Date: Thu, 29 Mar 2018 01:00:01 +0000
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0ggdjggMi81?=
 =?utf-8?B?XSBkdC1iaW5kaW5nczogc2NzaTogdWZzOiBhZGQgZG9jdW1lbnQgZm9yIGhp?=
 =?utf-8?Q?si-ufs?=
In-Reply-To: <CAK8P3a2BRXWbNzEcd9+Fi1zEkSA8aGB5ObxYrbVnaA7MKzU--w@mail.gmail.com>
References: <20180213101412.5717-1-liwei213@huawei.com>
 <20180213101412.5717-3-liwei213@huawei.com>
 <CAK8P3a2b3rLHyM+vMppCkAR3VYbhw-b0LpuWfLCqjs7z9n+hyw@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA584ED@DGGEMM506-MBS.china.huawei.com>
 <CAK8P3a3NdHLDf2vOMyZ1qcWNW1Jg5T47qR0qWhWEeDn+90S4ug@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA58798@DGGEMM506-MBS.china.huawei.com>
 <CAK8P3a29sDaEj=iTkru-3mc9NpjNvZos3Z+h5UsT1cAeULoGHw@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA588AD@DGGEMM506-MBS.china.huawei.com>
 <CAK8P3a2BRXWbNzEcd9+Fi1zEkSA8aGB5ObxYrbVnaA7MKzU--w@mail.gmail.com>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA58BA1@DGGEMM506-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd

Thanks for your patiences.

-----????-----
???: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] ?? Arnd Bergmann
????: 2018?3?28? 20:50
???: liwei (CM)
??: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; zangleigang; Gengjianfeng; Guodong Xu; Zhangfei Gao; Fengbaopeng (kevin, Kirin Solution Dept); Yaniv Gardi
??: Re: ??: ??: ??: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

On Tue, Mar 27, 2018 at 8:15 AM, liwei (CM) <liwei213@huawei.com> wrote:
> Hi, Arnd
>
> At present our ufs module mainly has four clocks from the outside:
> hclk_ufs:     main clock of ufs controller ,freq is 207.5MHz
> cfg_phy_clk:  configuration clock of MPHY, freq is 51.875MHz
> ref_phy_clk:  reference clock of MPHY from PMU, freq is 19.2MHz
> ref_io_clk:    reference clock for the external interface to the device, freq is 19.2MHz
>
> We control two clocks "ref_io_clk" and "cfg_phy_clk" in the driver 
> because the other two are controlled by main clock module and pmu.

I'm not completely sure what you mean with "control" here. Do you mean setting the rate and disabling them during runtime power management? What does it mean for the clock to be controlled by teh "main clock module and pmu"?

In the driver we only disable/enable "ref_io_clk" and "cfg_phy_clk" during runtime power management.

> for this patch, cfg_phy_clk corresponds to "phy_clk", ref_io_clk corresponds to "ref_clk".

I'm not sure I understand the difference between ref_phy_clk and ref_io_clk, but it sounds like we should give both of those names in the ufs-platform binding.

Your hclk_ufs would appear to correspond to what qualcomm calls core_clk, so maybe use that name as well.

cfg_phy_clk seems to be something that qcom would not have, but it's also generic enough to list it in the common binding.

Ok, let's add a describe for phy_clk in the common binding.

> So the clks in the patch you give appear to be unsuitable for describing this .And the following clks of qcom are internal clock?
> We didn't describe or pay attention to the clock inside the ufs module.
>
> PHY to controller symbol synchronization clocks:
>         "rx_lane0_sync_clk" - RX Lane 0
>         "rx_lane1_sync_clk" - RX Lane 1
>         "tx_lane0_sync_clk" - TX Lane 0
>         "tx_lane1_sync_clk" - TX Lane 1

Right, let's leave those for the qcom private binding.

      Arnd
