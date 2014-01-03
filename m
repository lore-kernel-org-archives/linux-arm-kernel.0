From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Fri, 3 Jan 2014 09:52:22 +0000
Subject: [PATCH V3 2/2] cpufreq: imx6q: correct VDDSOC/PU voltage
 scaling when cpufreq is changed
In-Reply-To: <20131218142536.GM6691@S2101-09.ap.freescale.net>
References: <1387402010-31749-1-git-send-email-b20788@freescale.com>
 <1387402010-31749-2-git-send-email-b20788@freescale.com>
 <20131218142536.GM6691@S2101-09.ap.freescale.net>
Message-ID: <67c8e04574694cf59625e95fa1a65332@BY2PR03MB315.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping...

Best Regards.
Anson huang ???
?
Freescale Semiconductor Shanghai
?????????192?A?2?
201203
Tel:021-28937058


>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Wednesday, December 18, 2013 10:26 PM
>To: Huang Yongcai-B20788
>Cc: rjw at rjwysocki.net; viresh.kumar at linaro.org; cpufreq at vger.kernel.org;
>linux-pm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>devicetree at vger.kernel.org
>Subject: Re: [PATCH V3 2/2] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
>when cpufreq is changed
>
>On Wed, Dec 18, 2013 at 04:26:50PM -0500, Anson Huang wrote:
>> on i.MX6Q, cpu freq change need to follow below flows:
>>
>> 1. each setpoint has different VDDARM, VDDSOC/PU voltage, get the setpoint
>>    table from dts;
>> 2. when cpu freq is scaling up, need to increase VDDSOC/PU voltage before
>>    VDDARM, if VDDPU is off, no need to change it; 3. when cpu freq is
>> scaling down, need to decrease VDDARM voltage before
>>    VDDSOC/PU, if VDDPU is off, no need to change it;
>>
>> normally dts will pass vddsoc/pu freq/volt info to kernel, if not,
>> will use fixed value for vddsoc/pu voltage setting.
>>
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>
>Acked-by: Shawn Guo <shawn.guo@linaro.org>
