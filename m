From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 13 Jan 2015 10:21:35 +0100
Subject: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <54B4ABFB.5000501@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com>
 <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
 <54AC93E0.8010705@samsung.com> <54ACFD69.1020500@collabora.co.uk>
 <54AD0293.70909@samsung.com> <54AEB384.2040005@collabora.co.uk>
 <54B36C5A.6050109@samsung.com> <54B3F1B7.7090307@collabora.co.uk>
 <54B4ABFB.5000501@samsung.com>
Message-ID: <54B4E39F.8040506@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joonyoung,

On 01/13/2015 06:24 AM, Joonyoung Shim wrote:
>> 
>> Also, the SW_ACLK_300_DISP1 and USER_ACLK_300_DISP1 are needed for the FIMD
>> parent and input clock respectively. Adding those to the clocks list of the
>> DISP1 power domain gives me working display + HDMI on my Exynos5800 Peach Pi.
>> 
>> These are the changes I have now [0]. Please let me know what you think.
>> 
> 
> Good, it's working with your patch without u-boot changes and reverting
> of commit 2ed127697eb.
>

Perfect, I'll split the the clk and DTS changes in different patches and
post the series once we figure out the "power-domain disable failed" issue.

>> 
>> Yes, I was not able to trigger that by running modetest but by turning off
>> my HDMI monitor and then turning it on again. When the monitor is turned
>> on then I see a "Power domain power-domain disable failed" and the imprecise
>> external abort error.
>> 
>> I had to disable CONFIG_DRM_EXYNOS_DP in order to trigger though and that
>> is why I was not able to reproduce it before.
>> 
>> I think though that this is a separate issue of the HDMI not working since
>> power domains should be able to have many consumers devices and I see that
>> other power domains are used that way.
>> 
> 
> OK, we need more investigation.
> 

Agreed, since even though I think this is a separate issue, I'll prefer
to not add a known bug as a side effect of having a working HDMI.

Best regard,
Javier
