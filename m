From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 20 Feb 2014 15:54:35 -0600
Subject: [PATCH v2] hwrng: msm: switch Kconfig to ARCH_QCOM depends
In-Reply-To: <53064C89.4060206@codeaurora.org>
References: <1392912542-5349-1-git-send-email-galak@codeaurora.org>
 <53064C89.4060206@codeaurora.org>
Message-ID: <D66229C0-8768-42BD-87DA-83FAA2328E40@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 20, 2014, at 12:42 PM, Christopher Covington <cov@codeaurora.org> wrote:

> On 02/20/2014 11:09 AM, Kumar Gala wrote:
>> We've split Qualcomm MSM support into legacy and multiplatform.  The RNG
>> driver is only relevant on the multiplatform supported SoCs so switch the
>> Kconfig depends to ARCH_QCOM.
>> 
>> CC: Herbert Xu <herbert@gondor.apana.org.au>
>> CC: Stanimir Varbanov <svarbanov@mm-sol.com>
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> ---
>> 
>> Herbert,
>> 
>> If you can ack this I'll send it via linux-qcom/arm-soc tree's
>> 
>> thanks
>> 
>> v2:
>> * Updated help text to remove MSM references, made more generic
>> 
>> drivers/char/hw_random/Kconfig | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
>> index 2f2b084..f2b9f8c 100644
>> --- a/drivers/char/hw_random/Kconfig
>> +++ b/drivers/char/hw_random/Kconfig
>> @@ -342,11 +342,11 @@ config HW_RANDOM_TPM
>> 	  If unsure, say Y.
>> 
>> config HW_RANDOM_MSM
>> -	tristate "Qualcomm MSM Random Number Generator support"
> 
>> +	tristate "Qualcomm ARM SoCs Random Number Generator support"
> 
> Can the Hexagon use the PRNG, at least theoretically? If so maybe it'd be
> clearest to leave ARM off.
> 
> Christopher

Fair point.

- k


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
