From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Mar 2018 21:33:56 +0000
Subject: [PATCH v3 11/25] ASoC: qcom: q6asm: add support to audio stream
 apis
In-Reply-To: <20180213165837.1620-12-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-12-srinivas.kandagatla@linaro.org>
Message-ID: <20180301213356.GV12864@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 04:58:23PM +0000, srinivas.kandagatla at linaro.org wrote:

>  	uint32_t used;
> @@ -131,7 +191,7 @@ static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
>  
>  	rc = wait_event_timeout(a->mem_wait, (a->mem_state <= 0), 5 * HZ);
>  	if (!rc) {
> -		dev_err(a->dev, "CMD timeout \n");
> +		dev_err(a->dev, "CMD timeout\n");
>  		rc = -ETIMEDOUT;
>  	} else if (a->mem_state < 0) {
>  		rc =  q6dsp_errno(a->mem_state);

This should be folded into whatever patch is being fixed.

> +	open.hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
> +	open.mode_flags = 0x00;
> +	open.mode_flags |= ASM_LEGACY_STREAM_SESSION;

What is a legacy stream and why are we using it in new code?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/151dc1fc/attachment-0001.sig>
