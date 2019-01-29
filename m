Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609F9C282D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D9F2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PaF8HqL6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cxn0TIWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D9F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hTLf696eXo6itVNAtW0UiOZMCyQG/gwgobBzevZsquQ=; b=PaF8HqL6Zd9idX
	DSiqMqqmOdlPFRJXyWFTB/WlPl9c2Tl3zkSj+8Vqg1sKeq+ID61iCW2hiPyG4BZ0/luoT3XIYwI9C
	jIrMUc8iL+8gvXvAWSln1LOW7x2r6OTSqeyhT1pWKCb+pTzJLBhbBb5Ilt8XJcCPOfpVYTYa72iue
	shk47mVUj8jIF4NtMO+/f6+K54GLSDbJmU2ZgaibtAkDW46RYAnx2vn01Mc0zL7UjuJsXI9g0cx8Z
	sZqNSA2EF/un5MZ6cPaxKx2gEGM6S4pQ8j+Vv7ptowhlKoO33spNd8q1LHyt5BP8tZBp/zuHpJ+5I
	97sxsc5aI8fpxqBV+PPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTPY-0006GD-LW; Tue, 29 Jan 2019 13:26:44 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTOT-0005c6-HD
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:26:04 +0000
Received: by mail-pg1-x543.google.com with SMTP id s198so8750484pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 05:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XGbd9FlQew8gsGNv/Xgm9xhO0xmJWMowaC4xsZZP7yY=;
 b=Cxn0TIWBAsHYOlURpxDsg/3ERpvMc8OhoR8R9OUUvx2FeE0L65jyWLxTa5+4Q6pWV1
 tuTQSIJoT58Q0KnBrhc7+AldTeCT98GMMnagr4K2dlc6SDu14Oj9b88TgRSe2B8ZRRGv
 hK0cwUsQTgLzqn6xL64dkDJDKAN8zfkGkUVnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XGbd9FlQew8gsGNv/Xgm9xhO0xmJWMowaC4xsZZP7yY=;
 b=AWjitjLW1hsAsikHAtk51rBr9yUPi17QF2vlych3DX2k1NZJ3m4RJTysED0W3DmBw8
 Xw+uGCY+ByFMmWwqYtObx6zJpeOGwVbbeCTYCpF2vxuPFqiMnpk7ofI+xQ/TlQntRML9
 o4saVjCQq6BJXtmwogtau1k4cU7IgAtWhjnsi7WWahqcLR4uyArrHhl7sdyGIPfvrSqG
 +EOIPRYi1KLEnErHj21QiDoA83jNC53Lc2BCHMkt/Ddhq8FexbDfuCxPBnMPoFDg+Krx
 26qfJf7qdQ5l9uP1y2op0aulzwiQqflp8cYzsPgTV17wRtnhBsgjSPm6AE7JdHSKaQ8k
 eUqw==
X-Gm-Message-State: AJcUukfepOP5AzI8pB//7L5TRhJAb1RUrwEy0DRERWXelkyjFQiEye+J
 DRcZp/9z3E8qKCodb35VfA6YHQ==
X-Google-Smtp-Source: ALg8bN6nfbylqOgeihbdgnPLdWukd1GfnwaLrRGuhDsGJLn1Ry5DDCvOJ6PnXetLMRYkTBwsEEVmpA==
X-Received: by 2002:a65:624c:: with SMTP id q12mr23764054pgv.379.1548768336816; 
 Tue, 29 Jan 2019 05:25:36 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li569-141.members.linode.com.
 [192.155.82.141])
 by smtp.gmail.com with ESMTPSA id v15sm44146419pfn.94.2019.01.29.05.25.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 05:25:35 -0800 (PST)
Date: Tue, 29 Jan 2019 21:25:28 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv5 6/7] coresight: debug: Add Unique Component Identifier
 (UCI) table
Message-ID: <20190129132528.GA16669@leoy-ThinkPad-X240s>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_052538_224561_A9D41B72 
X-CRM114-Status: GOOD (  21.69  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Tingwei Zhang <tingwei@codeaurora.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 12:44:03AM +0530, Sai Prakash Ranjan wrote:
> Add UCI table and a helper macro for coresight CPU debug
> module. This patch adds the UCI entries for Krypo CPUs
> found on MSM8996 which shares the same PIDs as ETMs.
> 
> Without this, below error is observed on MSM8996:
> 
> [    5.429867] OF: graph: no port node found in /soc/debug@3810000
> [    5.429938] coresight-etm4x: probe of 3810000.debug failed with error -22
> [    5.435415] coresight-cpu-debug 3810000.debug: Coresight debug-CPU0 initialized
> [    5.446474] OF: graph: no port node found in /soc/debug@3910000
> [    5.448927] coresight-etm4x: probe of 3910000.debug failed with error -22
> [    5.454681] coresight-cpu-debug 3910000.debug: Coresight debug-CPU1 initialized
> [    5.487765] OF: graph: no port node found in /soc/debug@3a10000
> [    5.488007] coresight-etm4x: probe of 3a10000.debug failed with error -22
> [    5.493024] coresight-cpu-debug 3a10000.debug: Coresight debug-CPU2 initialized
> [    5.501802] OF: graph: no port node found in /soc/debug@3b10000
> [    5.512901] coresight-etm4x: probe of 3b10000.debug failed with error -22
> [    5.513192] coresight-cpu-debug 3b10000.debug: Coresight debug-CPU3 initialized
> 
> Also add a helper macro to make adding CPU PIDs easier
> similar to ETM4X driver.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Looks good to me and tested on my Hikey board (though I cannot test
for a device with UCI ID):

Reviewed-and-tested-by: Leo Yan <leo.yan@linaro.org>

> ---
> This patch depends on UCI support by Mike Leach in below link:
>  https://lore.kernel.org/lkml/20190121233151.13363-2-mike.leach@linaro.org/
> ---
>  .../hwtracing/coresight/coresight-cpu-debug.c | 41 +++++++++++++------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 45b2460f3166..a126ed0b9a76 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -655,20 +655,35 @@ static int debug_remove(struct amba_device *adev)
>  	return 0;
>  }
>  
> +#define DEBUG_AMBA_ID(pid)			\
> +	{					\
> +		.id	= pid,			\
> +		.mask	= 0x000fffff,		\
> +	}
> +
> +static struct amba_cs_uci_id uci_id_debug[] = {
> +	{
> +		/*  CPU Debug UCI data */
> +		.devarch	= 0x47706a15,
> +		.devarch_mask	= 0xfff0ffff,
> +		.devtype	= 0x00000015,
> +	}
> +};
> +
> +#define DEBUG_AMBA_UCI_ID(pid)			\
> +	{					\
> +		.id	= pid,			\
> +		.mask	= 0x000fffff,		\
> +		.data	= uci_id_debug,		\
> +	}
> +
>  static const struct amba_id debug_ids[] = {
> -	{       /* Debug for Cortex-A53 */
> -		.id	= 0x000bbd03,
> -		.mask	= 0x000fffff,
> -	},
> -	{       /* Debug for Cortex-A57 */
> -		.id	= 0x000bbd07,
> -		.mask	= 0x000fffff,
> -	},
> -	{       /* Debug for Cortex-A72 */
> -		.id	= 0x000bbd08,
> -		.mask	= 0x000fffff,
> -	},
> -	{ 0, 0 },
> +	DEBUG_AMBA_ID(0x000bbd03),		/* Cortex-A53 */
> +	DEBUG_AMBA_ID(0x000bbd07),		/* Cortex-A57 */
> +	DEBUG_AMBA_ID(0x000bbd08),		/* Cortex-A72 */
> +	DEBUG_AMBA_UCI_ID(0x000f0205),		/* Qualcomm Kryo */
> +	DEBUG_AMBA_UCI_ID(0x000f0211),		/* Qualcomm Kryo */
> +	{},
>  };
>  
>  static struct amba_driver debug_driver = {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
