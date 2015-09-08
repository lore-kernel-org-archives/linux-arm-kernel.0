From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 8 Sep 2015 16:39:09 -0700
Subject: [PATCH] soc: qcom: smem: Move RPM message ram out of smem DT node
In-Reply-To: <20150908231858.GB13472@usrtlx11787.corpusers.net>
References: <1441750812-13041-1-git-send-email-sboyd@codeaurora.org>
 <20150908231858.GB13472@usrtlx11787.corpusers.net>
Message-ID: <55EF719D.80702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2015 04:18 PM, Bjorn Andersson wrote:
> On Tue 08 Sep 15:20 PDT 2015, Stephen Boyd wrote:
>
>> SMEM is a software construct built on top of a DDR carveout and
>> sometimes a device memory called RPM message ram. Having the RPM
>> message ram in the smem DT node's reg property leads to the smem
>> node being located in different places depending on if the
>> message ram is being used or not. Let's add a qcom specific
>> property, qcom,rpm-msg-ram, and point to the device memory from
>> the SMEM node via a phandle. This allows us to always have the
>> SMEM node at the root of the DT regardless of whether it's using
>> the message ram or not.
>>
> Based on the codeaurora limit of 99 aux-mem regions I figured this had
> to be more generic. But I think this makes sense and we can easily
> extend it with other specific regions (if we ever find any of those
> other 98 supported aux-mems).

Great.

>
>
> Can you update the dt binding document as well?
>
>

Sure. Is there a binding document? I couldn't find one.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
