From: davidb@codeaurora.org (David Brown)
Date: Tue, 25 Jan 2011 11:18:39 -0800
Subject: [PATCH v2 02/11] msm: Generalize timer register mappings
In-Reply-To: <1295979136.16668.4.camel@carlv-linux.qualcomm.com> (Carl
	Vanderlip's message of "Tue, 25 Jan 2011 10:12:16 -0800")
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-3-git-send-email-davidb@codeaurora.org>
	<1295979136.16668.4.camel@carlv-linux.qualcomm.com>
Message-ID: <8yay668eqr4.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25 2011, Carl Vanderlip wrote:

>>  #if defined(CONFIG_ARCH_MSM7X00A) || defined(CONFIG_ARCH_MSM7X27) \
>>  	|| defined(CONFIG_ARCH_MSM7X25)
>>  static struct map_desc msm_io_desc[] __initdata = {
>>  	MSM_DEVICE(VIC),
>> -	MSM_DEVICE(CSR),
>> +	MSM_CHIP_DEVICE(CSR, MSM7X00),
>>  	MSM_DEVICE(GPT),
>>  	MSM_DEVICE(DMOV),
>>  	MSM_DEVICE(GPIO1),
>
> MSM_DEVICE(GPT) still references MSM_GPT_PHYS, MSM_GPT_SIZE and
> MSM_GPT_BASE on the 7x00a though they are being removed.

Shouldn't be too hard to fix.  I'll look at it later today.  It mostly
points out that I haven't been building against 7x00A.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
