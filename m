Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D469FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:54:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CE021852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iMPBI0gD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fq11guSm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O8gM1tsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CE021852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fL4Mo3SSA/kTaIyo+3+1O8qJo4Udk1rMbX7BxB6JZZ4=; b=iMPBI0gDlbNAAXzM3xhijSQwg
	MrUVKPeqXf3JQyoecjmUt4C28q48xQ52jJ3e9Pgcn/VcKcAunc69qeE9Q/DbBCqqresS5+X7kOfwD
	2HZn365wBiClifvzrV6ncl+4FfXHNJ+/JbwbW4qtAf2uc16B6wTRdEWObP7aK6U9xNPOksjHtePLi
	WqX+ticvd0gjgsbPHvT1ZE+tg6tI5W+w04sCEniMXdrduO9rf1Q8m2Zjenq8HcFOW9HCjFqbyQp8/
	mgCPE0nPSu2u25ozNyfxLbqFgWquGaRdf2flZfMjKzztoiMhPR4fQnEprrk5oQqJH3PFmX+3HSERL
	MR7TywHpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUmq-0007fx-C9; Tue, 29 Jan 2019 14:54:52 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUmm-0007fY-P8
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:54:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 6644A609C4; Tue, 29 Jan 2019 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548773688;
 bh=4a1KzVQTbGqBLNGcaW04Ct2MNcmCMNFxQwsaZ2ynFy4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fq11guSmTJTIBPK3E+LPzKfugjgZa7EPplvGjsqbOZ3zgPjty6jctJo6rRnMG3fjQ
 JzhB3CieMse7PbvZ4sYO8ZlPtUrKuMroFv6W1TlANisvEM0dhKChVxgnUwFU/oCA2f
 e7S35OY0RKm0qeaeRtSdu3YmVouB85UAZZOWKfrY=
Received: from [192.168.1.100] (unknown [157.49.239.240])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EFBE60918;
 Tue, 29 Jan 2019 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548773687;
 bh=4a1KzVQTbGqBLNGcaW04Ct2MNcmCMNFxQwsaZ2ynFy4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=O8gM1tsrM6uoopLRdkquCIKAh7UgByqJ3+zRsQBoAGpdLjOTm20JxvE15GgJXGEWk
 CpZ1meZrURfri7wU66KUc246ZuUPXhBGfE6+llHY20dCBFchq1EwXK0DKf18yZrZv9
 D502U6PSEb6+McuNe4Q0Rl2xbgKdh5UcZWBAvUTA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EFBE60918
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv5 6/7] coresight: debug: Add Unique Component Identifier
 (UCI) table
To: Leo Yan <leo.yan@linaro.org>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <20190129132528.GA16669@leoy-ThinkPad-X240s>
 <20190129133605.GB16669@leoy-ThinkPad-X240s>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <fabcf7ca-96c4-8a54-f6cf-713eb1f0b822@codeaurora.org>
Date: Tue, 29 Jan 2019 20:24:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129133605.GB16669@leoy-ThinkPad-X240s>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_065448_845484_656B923C 
X-CRM114-Status: GOOD (  13.72  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Leo,

On 1/29/2019 7:06 PM, Leo Yan wrote:
> 
> I just now found if apply this patch onto coresight next branch [1],
> it will conflict with patch 'coresight: cpu-debug: Support for CA73
> CPUs' [2].  Sorry if introduce regression by this.
> 

This patch depends on UCI support which is being discussed at:

https://lore.kernel.org/lkml/20190121233151.13363-2-mike.leach@linaro.org/

So I think this should not go into coresight-next until the UCI support
is merged into coresight-next as well.

If UCI support is already merged, then I can rebase this patch on top
of coresight-next and resend.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
