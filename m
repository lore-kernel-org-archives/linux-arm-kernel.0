From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 14 May 2013 08:37:53 +0530
Subject: [PATCH] ARM: EXYNOS: Update defconfig for Arndale and Origen board
In-Reply-To: <87sj1qzaov.fsf@linaro.org>
References: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
 <87sj1qzaov.fsf@linaro.org>
Message-ID: <5191AA89.6010901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2013 05:36 AM, Kevin Hilman wrote:
> Tushar Behera <tushar.behera@linaro.org> writes:
> 
>> It updates following drivers for EXYNOS based DT platform.
>>
>> * S5M8767 driver
>> * MAX8997 driver
>> * MMC SDHCI driver
>>
>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> 
> I tested this using v3.10-rc1 on Arndale, but still don't get any
> support for the wired network.  Do you know if this is a Kconfig issue,
> or a missing driver?
> 
> I suspect it may be related to the various "unable to find transceiver
> of type USB2 PHY" messages I'm seeing?
> 

Yes, right. The missing USB-PHY components are one of the issues (they
were there in linux-next when I last tested).

Also, on Arndale board, we need to reset the USB hub during EHCI
initialization (a couple of those patches are required, which I am not
sure if we would be able to upstream).

I am collecting a minimal set of patches that would enable USB and wired
network on Arndale with 3.10-rc1 kernel. Once done, I will let you know.

> Thanks,
> 
> Kevin
> 

Thanks for testing.


-- 
Tushar Behera
