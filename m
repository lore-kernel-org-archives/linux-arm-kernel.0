From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 6 Mar 2018 09:26:34 +0000
Subject: [PATCH v3 11/25] ASoC: qcom: q6asm: add support to audio stream
 apis
In-Reply-To: <20180301213356.GV12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-12-srinivas.kandagatla@linaro.org>
 <20180301213356.GV12864@sirena.org.uk>
Message-ID: <d76a271d-707c-3f5c-9327-d7f43da3cc92@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review comments.

sorry for delay, for some reason these emails endup in my SPAM folder.

On 01/03/18 21:33, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:23PM +0000, srinivas.kandagatla at linaro.org wrote:
> 
>>   	uint32_t used;
>> @@ -131,7 +191,7 @@ static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
>>   
>>   	rc = wait_event_timeout(a->mem_wait, (a->mem_state <= 0), 5 * HZ);
>>   	if (!rc) {
>> -		dev_err(a->dev, "CMD timeout \n");
>> +		dev_err(a->dev, "CMD timeout\n");
>>   		rc = -ETIMEDOUT;
>>   	} else if (a->mem_state < 0) {
>>   		rc =  q6dsp_errno(a->mem_state);
> 
> This should be folded into whatever patch is being fixed.
> 

My Bad, I will fix this in next version.

>> +	open.hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
>> +	open.mode_flags = 0x00;
>> +	open.mode_flags |= ASM_LEGACY_STREAM_SESSION;
> 
> What is a legacy stream and why are we using it in new code?

This is basically Ensures backward compatibility to the original 
behavior of ASM_STREAM_CMD_OPEN_WRITE_V2 command.

I will take a closer look and see if its possible to remove this in the 
first place.

thanks,
srini

> 
