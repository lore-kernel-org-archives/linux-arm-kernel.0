From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Thu, 2 Aug 2018 18:14:32 +0200
Subject: [Eas-dev] Computing the dynamic-power-coefficient on Exynos5422
In-Reply-To: <6eebf48cdf26496a9c53892549a99ed8@MSX-L106.msx.ad.zih.tu-dresden.de>
References: <6eebf48cdf26496a9c53892549a99ed8@MSX-L106.msx.ad.zih.tu-dresden.de>
Message-ID: <341c6cbd-179a-a86f-b532-a839730ed753@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2018 10:04 AM, Oliver Effland wrote:
> Hi,
> 
> First of all: thanks for all the valuable input! @(Russell, Dietmar & Steven)
> 
> On 07/23/2018 08:51 AM, Steven Miao wrote:

[...]

> A7:
> freq(MHz) voltage(mV) Power(mW)	A7_Power(mW)  Stat_Power(mW) DPC
> 200	  918.750     34.768	12.203	      10.362	     72.283955
> 400	  920.000     60.805	21.25	      18.305	     62.765831
> 600	  968.750     98.046	35.084	      27.878	     62.306652
> 800	  1042.500    148.095	52.285	      43.525	     60.136063
> 1000	  1116.250    212.214	76.112	      59.99	     61.084382
> 1200	  1190.000    288.958	99.993	      88.972	     58.842948
> 1400	  1288.750    411.936	144.807	      122.322	     62.276495
> 						
> 							mean: 62	
> 
> A15:
> freq(MHz) voltage(mV) Power(mW) A15_Power(mW) Stat_Power(mW) DPC
> 200       916250      122.584   31.139        60.306         185.458477
> 500       916250      225.101   68.774        87.553         163.842401
> 800       942500      349.158   112.432       124.294        158.211202
> 1100      1016250     540.78    169.556       201.668        149.251725
> 1400      1078750     779.19    258.214       262.762        158.493016
> 1700      1180000     1179.344  392.107       395.13         165.650083
> 2000      1320000     1969.764  648.768       672.228        186.170798
> 						
> 							mean: 164
> 
> The ratio between A15 and A7 is now 164/62 = 2.645
> 
> I hope the dynamic-power-coefficient's are more accurate now?
> 
>> dynamic-power-coefficient ~= 400 - 500 is reasonable for big core
>> dynamic-power-coefficient  ~= 100 is reasonable for LITTLE core.
>> For IPA it can work effectively with a poor power model(not so
>> accurate), for EAS it just need power model of LITTLE core and big
>> core is proportional.
> 
> I'm guessing my values differ from your suggested values, because it's 32bit ARM?

We're running TC2 (32 bit Arm A15/A7 _test_ chip) with a ratio between 
A15 and A7 of 990/113 = 7.44.

For EAS, i.e. for task wake-up placement decisions based on task 
utilization and cpu capacity, on big.LITTLE this ratio is important.

How do you want to evaluate EAS v4 (or v5) on your ODROID-XU3 board? 
What kind of workloads and/or benchmarks will you run on it?

-- Dietmar

[...]
