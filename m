From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 03 May 2016 11:17:45 +0900
Subject: Fwd: [PATCH v2 0/8] PM / devfreq: Add NoCP devfreq-event and
 support busfreq on exyno5422-odroidxu3
In-Reply-To: <1894783822.297231462168123817.JavaMail.weblogic@ep2mlwas04a>
References: <1894783822.297231462168123817.JavaMail.weblogic@ep2mlwas04a>
Message-ID: <57280A49.6060609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Myungjoo,

On 2016? 05? 02? 14:48, MyungJoo Ham wrote:
> Sender : ???<cw00.choi@samsung.com> S5(??)/Change Agent/Tizen Platform Lab(S/W??)/????
> Date : 2016-04-15 15:32 (GMT+09:00)
>>
>> This patchset support the AMBA bus frequency scaling on Exynos5422-based
>> Odroid-XU3 board. But, this series only support the bus frequency scaling
>> for INT (Internal) block using VDD_INT power line.
> 
> Along with Devfreq/Passive patchset, the patchset is merged in
> devfreq for-4.7 tree.
> 
> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/log/?h=for-4.7
> 
> @Chanwoo: If there are commits to be merged by a tree other than Linux/PM,
> please let me know. I'll send out pull-request soon.

On Krzysztof Kozlowski's reply, dts patches will be merged on samsung-soc tree.
and then the clock patches about exynos5420 was already merged to samsung-clk tree
by Sylwester.

Only devfreq patches should be merged on devfreq tree.

We already discussed this topic on offline. I expect that you will again handle
this patchset according to reply of both Krzysztof and me.

Best Regards,
Chanwoo Choi

> 
> 
> Cheers,
> MyungJoo
> 
>>
>> Also, to support the bus frequency scaling for Exynos542x SoC,
>> Exynos542x SoC has the specific 'NoC (Network on Chip) Probe' device
>> to measure the transfered data traffic on NoC (Network on Chip)
>> instead of PPMU (Platform Performance Monitoring Unit). NoC Probe device
>> provide the utilization for INT block of Exynos542x SoC.
>>
>> The generic exynos-bus frequency driver uses the 'NoC Probe' devfreq-event
>> device (drivers/devfreq/event/exynos-nocp.c) without any modification.
>> Just add the phandle of 'NoC Probe' dt node to bus dt node.
>>
>> Depend on:
>> This patchset depends on patch[1] which support the generic exynos-bus
>> frequency driver.
>> [1] http://www.spinics.net/lists/arm-kernel/msg495976.html
>> - [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency driver and new passive governor
>>
>>
