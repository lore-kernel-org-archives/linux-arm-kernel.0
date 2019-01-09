Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:32:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D252075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AoP3UjP8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xm4wFche";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jMD2ksnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D252075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YPQRBiIjE6Zm3TqdKyQfH1FVK333DngAVmmVEq2hp3E=; b=AoP3UjP8JQTQ9l2yCCyN8gxyZ
	Qufxx7DbvZ0pzAxaRWFlIZdJSs/S3dcMMpmZm7tP7J+KnJg4c3vqhL2Plyj9iVImP3yoTXorcgwWV
	4t7wZa869Qz0qMFofMbLjcytZeywESFjY+mZBOsrz0v8Ly0wnYI9jPacOMiFa8ASobbtyeyI9oGyL
	DBpvk4Q4rIQRloEgliecUJIG5RJOoytfWM7JfG1OYNPeSMgQB2OdD0aGc08nAzOQnvq1yAoHWYbAX
	2zYdwxmteUwfsT9mRYneU92vqFFZ5eIr1BRT4CFob6+qaLjXH+7oj/8w+UckroM9wEoT3tWvnT5a1
	BJ6thyX9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghADr-00069A-Ma; Wed, 09 Jan 2019 09:32:27 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghADo-00068d-PX
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 09:32:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 74CD1608C6; Wed,  9 Jan 2019 09:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547026343;
 bh=jWz6+3WQiYuNZZY+QEo7F5nS1SRyMJPY1jEGynPz480=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Xm4wFcheaVA5YbXmVAnHCOCChtVHp/htEzeiY5L2YQE0OCFWJF0A00lEuy4N+HMoy
 mUbpXbFhsJdyIki9B0PwmmqKCWrF8Q68CnOg8uxeSx4gSxyKg1v4Di4TwTBiT41+g4
 MEMVC4sGBEelsKKHltHxGzfn2uICpUkA71eaWrfs=
Received: from [10.79.128.18]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: rnayak@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 80DA2601B4;
 Wed,  9 Jan 2019 09:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547026342;
 bh=jWz6+3WQiYuNZZY+QEo7F5nS1SRyMJPY1jEGynPz480=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jMD2ksnnKlZ/n4PJCSLwppotcUGiVoVqRjH9a66cKpW5eXiFLpJbgg0/0nqPFA9hn
 GjKRsq9492tZV5lk+GnVZFtXlGS8NfF2OELxixpDfA3q/KKBKGrUQvShLNC/uB7h9r
 5KIIfu/k8dLh6Qp24t6f4ANOZWXgkQFoVIZ+zhhU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80DA2601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v7 6/6] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Doug Anderson <dianders@chromium.org>,
 Jordan Crouse <jcrouse@codeaurora.org>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-7-jcrouse@codeaurora.org>
 <CAD=FV=VRv82aHfd1dQ_8mjtFFu-u_=JxNGz1qYG+5apTsmBz2Q@mail.gmail.com>
 <CAD=FV=WZkOV95Ka2MVtHtUAYLjzKAZwwe=H87LJCefbm06ogeg@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <ead09599-f4f7-d505-8e22-4eb1869f9cf1@codeaurora.org>
Date: Wed, 9 Jan 2019 15:02:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WZkOV95Ka2MVtHtUAYLjzKAZwwe=H87LJCefbm06ogeg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_013224_847170_6490003B 
X-CRM114-Status: GOOD (  12.24  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/9/2019 10:50 AM, Doug Anderson wrote:
> ...but in the meantime Rajendra has had to change his bindings, so you
> still need to spin this to account for Rajendra's v9 bindings [2].
> Specifically you need to make changes like:
> 
> -                               compatible = "operating-points-v2-qcom-level";
> +                               compatible = "operating-points-v2-level";

so there's now a v10 [1] and the new compatible is completely dropped and opp-level
is now an optional property using the default "operating-points-v2"

so the change should be
-                               compatible = "operating-points-v2-qcom-level";
+                               compatible = "operating-points-v2";

[1] https://lkml.org/lkml/2019/1/9/152

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
