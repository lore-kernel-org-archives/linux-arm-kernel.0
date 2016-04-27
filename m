From: Linux.HWI@garmin.com (J.D. Schroeder)
Date: Wed, 27 Apr 2016 09:06:50 -0500
Subject: [PATCH 2/3] ARM: DRA7x: dts: Fix the 32kHz clock calculation
In-Reply-To: <5720A51E.2000900@ti.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
 <1461693269-19436-3-git-send-email-Linux.HWI@garmin.com>
 <5720A51E.2000900@ti.com>
Message-ID: <5720C77A.3020708@garmin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 06:40 AM, Tero Kristo wrote:
> On 26/04/16 20:54, J.D. Schroeder wrote:
>> This commit fixes the 32kHz clock (sys_32k_ck) calculation to be
>> correctly based on the SYS_CLK1 (sys_clkin1) frequency. Based on the
>> TRM CTRL_CORE_BOOTSTRAP[9:8] SPEEDSELECT, set by the SYSBOOT[9:8]
>> board jumpers according to the SYS_CLK1 frequency, the frequency of
>> the 32kHz FUNC_32K_CLK is set to SYS_CLK1/610. The following
>> sys_32k_ck frequencies get used for different SYS_CLK1 frequencies:
>>          0b00: Unknown  -> 32768 Hz crystal from CLKIN_32K pin
>>          0b01: 20   MHz -> 32787 Hz clock (SYS_CLK1/610)
>>          0b10: 27   MHz -> 44262 Hz clock (SYS_CLK1/610)
>>          0b11: 19.2 MHz -> 31475 Hz clock (SYS_CLK1/610)
> 
> A patch doing the same thing is already in mainline, see:
> 
> commit eea08802f586acd6aef377d1b4a541821013cc0b
> Author: Keerthy <j-keerthy@ti.com>
> Date:   Mon Apr 4 11:07:15 2016 +0530
> 
>     ARM: dts: dra7: Correct clock tree for sys_32k_ck
> 
> So, this one can be ignored.

My change had no issue when applying to the tip of master and I'm not seeing
that SHA1 in mainline. Are you saying it is in another repo ready to be sent
to mainline for the next release cycle?
