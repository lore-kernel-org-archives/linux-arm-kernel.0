From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 30 Oct 2014 22:35:07 +0900
Subject: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <54521B22.6070708@nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <54520CFE.9060907@nvidia.com> <5452107D.8080207@nvidia.com>
 <54521181.8080005@nvidia.com> <54521B22.6070708@nvidia.com>
Message-ID: <54523E8B.7000900@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2014 08:04 PM, Terje Bergstr?m wrote:
> On 30.10.2014 12:22, Alexandre Courbot wrote:
>> So should I understand that the GPU group is for addresses without bit
>> 34 set (hence forcibly disabled) while GPUB is used when that bit is
>> set? Or is it something else?
>
> That's exactly correct. And only GPUB can be programmed to be SMMU
> translated.

Great, thanks for confirming!

Thierry, how do you want to address this? We could change the register 
for the GPU group, or (maybe preferable if we want to reflect the actual 
hardware state) add the GPUB group. I don't know if that would be easy 
though since we would have the problem of the gpusrd and gpuswr clients 
ownership (seems like they would belong to both groups?)
