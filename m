From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 21 Jun 2018 23:28:06 -0500
Subject: [PATCH 1/2] hwrng: msm: add a spinlock and support for blocking
 reads
In-Reply-To: <20180622042407.GG27187@vkoul-mobl>
References: <1529594276-12210-1-git-send-email-timur@codeaurora.org>
 <20180622041712.GE27187@vkoul-mobl>
 <efc93d58-4671-2c51-75d4-a19759ab0f0c@codeaurora.org>
 <20180622042407.GG27187@vkoul-mobl>
Message-ID: <484f9b0e-3316-9f76-8036-187575cfe139@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/21/18 11:24 PM, Vinod wrote:
> On 21-06-18, 23:18, Timur Tabi wrote:
>> On 6/21/18 11:17 PM, Vinod wrote:
>>> this should be a separate patch
>> What exactly should be a separate patch?  This part?
>>
>> -	rng->hwrng.name = KBUILD_MODNAME,
>> -	rng->hwrng.init = msm_rng_init,
>> -	rng->hwrng.cleanup = msm_rng_cleanup,
>> -	rng->hwrng.read = msm_rng_read,
>> +	rng->hwrng.name = KBUILD_MODNAME;
>> +	rng->hwrng.init = msm_rng_init;
>> +	rng->hwrng.cleanup = msm_rng_cleanup;
>> +	rng->hwrng.read = msm_rng_read;
> yes

II consider this to be a minor clean-up that's not worthy of its own 
patch, but I can make this its own patch if you really want.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
