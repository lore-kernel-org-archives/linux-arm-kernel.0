Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB9CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:29:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78C420857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Exk6LDbY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuNqhcyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78C420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qjg/DretZjOiJJmPrY6OhFRvN9E27L6glG4+9mipnSU=; b=Exk6LDbYqFh53w
	9V9Y36evHGibTZ29T3oPJzPuUuLRr24YQHg50ssNsh8iRL33Zt30P+dqMeOXpVntt4AHs/N31UMCl
	O+FlQK/BdPGC4ZwPGA9ErFVolxd98D8oXIhT9+fOKkgc0oKxnKueZ7oCrctZW1pLAQTYVLFKlHeaq
	Jst/nmUFzHCrNyDbTRjEAqhcXjFDLzVN4dDGhRZGe6vfaTJaI2x/UBAtKtPfZ71SB6rCUoXi3JCqL
	JMqn+YZUS2fRYANFg9OwQ+WQxO8ZyDK9NDIg17hwVDnXRe9IahkiM/mk2bWaQ2iagDEUcAbeJvf5g
	axUaIVUmuz256ejr2kUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grqIK-0007Qv-3D; Thu, 07 Feb 2019 20:29:12 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grqIF-0007QW-L3
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 20:29:09 +0000
Received: by mail-it1-x141.google.com with SMTP id r6so3279066itk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 12:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XQMPFtgiD9kRlMP0xZT8Ht2uYetxaIQrdf6+lFc9OpY=;
 b=DuNqhcywKP09C6NkoUbMBjCCJTWJVY06rTcY5nHiNAAZXOZXE00E0eUwJpcVQmsjGc
 IDh+VcS8g7OpsodKnX2ftUO5X3G9uo6qdL+SGcqn37ijRqmkYb5HCc5DI1buktEry9sS
 glyXZQTDQ8ajIZEzN4p2LJeVpfkBHk0Jx4ca3M6Oryl4uLqxh4VqpQBv76h5q9DVo8vN
 Us6ID3Rpjgv1VKu1qxezX4ppdACsfyndpzI4GF5VzJewcZJCk/IWMKNzOp9ad9O8Qat9
 K6iiITDOQq0Cs4wcPhbkTy90f9Y5I+eGGSOInrX6yN/HaTkU6tBg7DBfG3xwmM2bEHB4
 Ztxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XQMPFtgiD9kRlMP0xZT8Ht2uYetxaIQrdf6+lFc9OpY=;
 b=KBJYyIxhE2y2wObycNVCgOGK7u8jMg6+E+ozxBV78gvnt1pi6rIxLxZIRblX57+A/T
 r2gV6Hzs4KzbqHIfxzEzQMPeEXx+LHsbWoqXX9YHfVScpbPc39PiSeWIIdRnGhJV57r5
 n6ncmmNpD9Xwui2gLWt95LEVv7Kc+tDwEI/T+kugS4la6d1JbyJr7NGeNtaOxMgCI4l2
 3zZ6R2JIcLCvzHvr9CpYS0iQmqaIHk7b1Iv0pPEx4OzARWUS6Ny3mD9pReojkIgOM3K0
 jbFZAfM4kY8K3cfUn64ROU13RYbiHKqyCn+R1Jp/5BvmnpL2nUcXLF3u7G2WRN8ClKyK
 GLkg==
X-Gm-Message-State: AHQUAuZJ8yXgxp7LUsvLIP/PEQG0JAtcBd0xHQlbsHX2rvZm5aspljF2
 EEawYcnb0y7q8edcnf9Ui2Klr1gqsnDeqsUphEuv9g==
X-Google-Smtp-Source: AHgI3IaIb8+ndBXJmvKkRFflVgcEw4+PcfWvXoVOH/BWSeqJXrWzIlFBFARebrSRCDL+K5TWFY9+1TlbfBjvsSSc0qE=
X-Received: by 2002:a24:db02:: with SMTP id c2mr6818644itg.137.1549571346926; 
 Thu, 07 Feb 2019 12:29:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <53cf9d9d3b14f503a6c842754f3c55413f5a3392.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <53cf9d9d3b14f503a6c842754f3c55413f5a3392.1548981329.git.saiprakash.ranjan@codeaurora.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 7 Feb 2019 13:28:56 -0700
Message-ID: <CANLsYky9ujRyftg3WoeSWK37=3_k5hw9x=DV34P_YrUXCLApXw@mail.gmail.com>
Subject: Re: [PATCHv7 6/6] coresight: cpu-debug: Add support for Qualcomm Kryo
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_122907_704633_40F125CC 
X-CRM114-Status: GOOD (  20.46  )
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
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 31 Jan 2019 at 17:55, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Add support for coresight CPU debug module on Qualcomm
> Kryo CPUs. This patch adds the UCI entries for Kryo CPUs
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
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>
> ---
> For testing, all dependent patches are in below tree:
>  * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
>
> This patch depends on UCI support by Mike Leach in below link:
>  * https://lore.kernel.org/lkml/20190130234051.2294-1-mike.leach@linaro.org/
> ---
>  .../hwtracing/coresight/coresight-cpu-debug.c | 33 +++++++++----------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index e8819d750938..50ebf5b7fa4f 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -655,24 +655,23 @@ static int debug_remove(struct amba_device *adev)
>         return 0;
>  }
>
> +static const struct amba_cs_uci_id uci_id_debug[] = {
> +       {
> +               /*  CPU Debug UCI data */
> +               .devarch        = 0x47706a15,
> +               .devarch_mask   = 0xfff0ffff,
> +               .devtype        = 0x00000015,
> +       }
> +};
> +

Thank you for adding that.

>  static const struct amba_id debug_ids[] = {
> -       {       /* Debug for Cortex-A53 */
> -               .id     = 0x000bbd03,
> -               .mask   = 0x000fffff,
> -       },
> -       {       /* Debug for Cortex-A57 */
> -               .id     = 0x000bbd07,
> -               .mask   = 0x000fffff,
> -       },
> -       {       /* Debug for Cortex-A72 */
> -               .id     = 0x000bbd08,
> -               .mask   = 0x000fffff,
> -       },
> -       {       /* Debug for Cortex-A73 */
> -               .id     = 0x000bbd09,
> -               .mask   = 0x000fffff,
> -       },
> -       { 0, 0 },
> +       CS_AMBA_ID(0x000bbd03),                         /* Cortex-A53 */
> +       CS_AMBA_ID(0x000bbd07),                         /* Cortex-A57 */
> +       CS_AMBA_ID(0x000bbd08),                         /* Cortex-A72 */
> +       CS_AMBA_ID(0x000bbd09),                         /* Cortex-A73 */
> +       CS_AMBA_UCI_ID(0x000f0205, uci_id_debug),       /* Qualcomm Kryo */
> +       CS_AMBA_UCI_ID(0x000f0211, uci_id_debug),       /* Qualcomm Kryo */
> +       {},

I have reviewed your work and things look good to me.  Once again
there isn't much I can do with it right now.  Please re-submit when
Mike's set has been merged.

Mathieu

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
