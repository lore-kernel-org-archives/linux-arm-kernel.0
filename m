From: bintian.wang@huawei.com (Bintian)
Date: Tue, 14 Apr 2015 11:35:26 +0800
Subject: [PATCH v2 3/6] clk: hi6220: Document devicetree bindings for
 hi6220 clock
In-Reply-To: <7304398.GVjUsTVoce@wuerfel>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
 <1428916660-25910-4-git-send-email-bintian.wang@huawei.com>
 <7304398.GVjUsTVoce@wuerfel>
Message-ID: <552C8AFE.9040907@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 2015/4/13 23:32, Arnd Bergmann wrote:
> On Monday 13 April 2015 17:17:37 Bintian Wang wrote:
>> +- compatible: the compatible should be one of the following strings to
>> +       indicate the clock controller functionality.
>> +
>> +       - "hisilicon,aoctrl"
>> +       - "hisilicon,sysctrl"
>> +       - "hisilicon,mediactrl"
>> +       - "hisilicon,pmctrl"
>> +
>>
>
> These ones already have bindings, you can't reuse the strings.
> Please work with someone in hisilicon to set up a registry of
> device names so you can avoid conflicts in the future.
All the clock registers are under above four system controllers, 
discussed with Mark and Haojian two months ago, I think using above
same four binding strings is enough for clk module.
On second thoughts, there really some problems for future hisilicon
code upstream, how about change back to the first version of this
patch set, just like following:
+		sys_ctrl: sys_ctrl {
+			compatible = "hisilicon,sysctrl", "syscon";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0xf7030000 0x0 0x2000>;
+			ranges = <0 0x0 0xf7030000 0x2000>;
+
+			clock_sys: clock1 at 0 {
+				compatible = "hisilicon,hi6220-clock-sys";
+				reg = <0 0x1000>;
+				#clock-cells = <1>;
+			};
+		};

Thanks,

Bintian
>
> 	Arnd
>
> .
>
