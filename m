Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D057CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB2521721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ab41tPMo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxTyxHN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB2521721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GVTxfrlloUB1U4N7p1C2FqmGsnVr2BLClQM1xutCQo8=; b=ab41tPMoUkYV+b
	M9g7qWkOj+mW3oM5lng2G9quLMI2iBTmRY0CZ5nzbhUF3IFE/Devd5/DMjhVBiBDq1NGUy9LHg76u
	Z5Q35NTgvvU/2K48nPI2Z1aUXeUPhoR7OgS+ChrmbO/nazy77LQFqm3jdA/rpGoe1v5CEkq5pUSvB
	ijvvCy8mI/9OrQu/J8cnJrCKuhhOsAzghY48LEBV3R5xojFWEC3Se0kwkU1Y0VXwtpa3vYB5OUdeN
	Rs3D60iyljR2b9oTZpBT+qHpvkPnQW2PwjRICcMqBdwN00qqD9ojmui23g9D8BgNPsaKPyhl2YXYG
	ES/RXrBEVWWyY6+hkvsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grqFj-0006p8-Pr; Thu, 07 Feb 2019 20:26:31 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grqFf-0006od-NJ
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 20:26:29 +0000
Received: by mail-it1-x143.google.com with SMTP id z20so3196480itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 12:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YYogv0ka9R4eviTDJxJgfktV/LLRttaROHsNpKGSpSM=;
 b=PxTyxHN1hoesG4TBnAHUlMse5Rx1kOxDW0RujRmLvjkBFwEeMz5u4yT8I69L70ENnf
 3g1+jSbFJtvkg9Js5jFe2GNFHbedkucDl9MqYG53NwtlLT/cBYr8q0wfw+RU2a9vAvSt
 LUDYmOMjsd3uIe5PyrBLb5QVcT6bjeeJDQVUCeeR73mtv5200ufpsXReSoLb4TjcaEoG
 KcZK03EWFWekB5RCjvyD3n6iYbY4yYYOPVRLdzYswpBlMa1fL2nqqhUqOMTSD8AMDXF/
 NTDA1Ssk50W6NEZuP/C9CaGv/N/PNDcJpfmpjOJB1m5gx4QG/wM4w3XstEngvmf3dsl4
 3ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YYogv0ka9R4eviTDJxJgfktV/LLRttaROHsNpKGSpSM=;
 b=IZ9Z8mQ3MazL6X4teccIyLr3rtGnmdPo+Mqdt0+byI9dobLR6vM82WJiVo5jn3uJfO
 m49DPsGBY0/Y2vLsdebiB0WZ/iOe52VaK4Joy4wtbCzMmHpwFLxZuK0/SyAhDOVy0/PN
 mkFJnscKK3o+lFAg/Uj1MtiOMyYXhOX4uqd0M/BX73RYXQek345mNbDM/F0Ax+WGt9xB
 LZ6ws+Op+1xi8caEdDG6cpIwaRY07Y6uvtm8faC7E6cPwpQKYASFxMyWwJ9x8KA2ABg1
 s5wVqCxkKhrWfDTOZMVtwCb5+9gtdOANX7lYKmsLIU7ngg3aQU28im+UL38fTm7VKdwv
 bwww==
X-Gm-Message-State: AHQUAua7FlYb9W1/znziynj1tuMoPjKMTuty4Kb5g7XU52AEQ1ENUUUW
 IdgDGyVebgtTP8H4mihkQNOmco5iJaff+ydf+/aYhA==
X-Google-Smtp-Source: AHgI3IaQ3+vJNfeCJ+W99aHeTHlZlgJ6d9QJM/gUgVMCJqkxMBpECb7Ts13bCba8MHs1MtIm3R9abENa/+xiFwL/iys=
X-Received: by 2002:a24:db02:: with SMTP id c2mr6811884itg.137.1549571186682; 
 Thu, 07 Feb 2019 12:26:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <c050252dc8eb3fea03119cd5efc422ed6e48834e.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <c050252dc8eb3fea03119cd5efc422ed6e48834e.1548981329.git.saiprakash.ranjan@codeaurora.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 7 Feb 2019 13:26:16 -0700
Message-ID: <CANLsYkwoqOhtENkhhSY5Tv23-vgUst4oakWrmQsB97=gDTVQLA@mail.gmail.com>
Subject: Re: [PATCHv7 5/6] coresight: etm4x: Add ETM PIDs for SDM845 and
 MSM8996
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_122627_773576_91D9FEAA 
X-CRM114-Status: GOOD (  18.47  )
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

On Thu, 31 Jan 2019 at 17:54, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Instead of overriding the peripheral id(PID) check in AMBA
> by hardcoding them in DT, add the PIDs to the ETM4x driver.
> Here we use Unique Component Identifier(UCI) for MSM8996
> since the ETM and CPU debug module shares the same PIDs.
> SDM845 does not support CPU debug module.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> ---
> For testing, all dependent patches are in below tree:
>  * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
>
> This patch depends on UCI support by Mike Leach in below link:
>  * https://lore.kernel.org/lkml/20190130234051.2294-1-mike.leach@linaro.org/
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 08ce37c9475d..5819ced2beec 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1078,11 +1078,15 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
>  };
>
>  static const struct amba_id etm4_ids[] = {
> -       CS_AMBA_ID(0x000bb95d),         /* Cortex-A53 */
> -       CS_AMBA_ID(0x000bb95e),         /* Cortex-A57 */
> -       CS_AMBA_ID(0x000bb95a),         /* Cortex-A72 */
> -       CS_AMBA_ID(0x000bb959),         /* Cortex-A73 */
> -       CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),        /* Cortex-A35 */
> +       CS_AMBA_ID(0x000bb95d),                 /* Cortex-A53 */
> +       CS_AMBA_ID(0x000bb95e),                 /* Cortex-A57 */
> +       CS_AMBA_ID(0x000bb95a),                 /* Cortex-A72 */
> +       CS_AMBA_ID(0x000bb959),                 /* Cortex-A73 */
> +       CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
> +       CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
> +       CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
> +       CS_AMBA_ID(0x000bb802),                 /* Qualcomm Kryo 385 Cortex-A55 */
> +       CS_AMBA_ID(0x000bb803),                 /* Qualcomm Kryo 385 Cortex-A75 */

I am good with this patch but there isn't much I can do with it until
Mike's patchset has been merged.  Please submit again when that has
been done.

Thanks,
Mathieu

>         {},
>  };
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
