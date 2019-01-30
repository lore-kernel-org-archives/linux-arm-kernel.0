Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DC3C282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:32:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12242175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jyuf4iB1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hQSytLBN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hQSytLBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12242175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LjRyxSyYg6TbOuAaGut42L9PNvOwOFCUihovPXoTeJg=; b=Jyuf4iB1QJXt6R
	FPNgzEoQ2qXXMyeWJcCvKbOKTSXpTvtIyVzYMZ3UpnHQ3DL4ewe+hq2+1Kbw5R8PPMaITvFTOQn0t
	W9Q1giEnnXWzV0h/xlLuqSCxRRGHiaXFwkexaqasAVwss+yfoOXOwH7zEcWYSMn3ZhbLb22OlWYu9
	HEmkSnuTAFCTXCvzvpQB997oDD3FV2uqAbGE1SD7eDO1uQaV4zHkY6hWQpVaBs+vKDyLqE2zVq7aS
	fEwWvYTa9I3RpSrUEKY9BSgospo/ADcTQlNWXp3AGlB94+U3OTIsNrM7MH6g07GJnBwxPafWI8oY9
	/amSOLbFUZa1Nr4K5gPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goiU9-0002gc-Fm; Wed, 30 Jan 2019 05:32:29 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goiU6-0002gH-PQ
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 05:32:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 98F6A608C5; Wed, 30 Jan 2019 05:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548826343;
 bh=AscrGqwZ0ug1yJn4iyBIsZyM2plamHMOHGK1pa88HB0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hQSytLBNopQf7ZY52UuJhyja3xySpFQ2QpfFKwhnBR8//FqN5BOQa3H01sFs7HT/2
 fZGHS30LXzGRSq9u+oE8GfDaXFcERxxaeMaWgDS6ibE3ug0WFNCXT/bpCJxGjjsSI6
 p+Syya9njZyfSIY+Mxn+J3jWfqdxIt4xJVUigxdY=
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id F3A5D607C6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 05:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548826343;
 bh=AscrGqwZ0ug1yJn4iyBIsZyM2plamHMOHGK1pa88HB0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hQSytLBNopQf7ZY52UuJhyja3xySpFQ2QpfFKwhnBR8//FqN5BOQa3H01sFs7HT/2
 fZGHS30LXzGRSq9u+oE8GfDaXFcERxxaeMaWgDS6ibE3ug0WFNCXT/bpCJxGjjsSI6
 p+Syya9njZyfSIY+Mxn+J3jWfqdxIt4xJVUigxdY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3A5D607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f45.google.com with SMTP id f23so17981016edb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 21:32:22 -0800 (PST)
X-Gm-Message-State: AJcUukeqzlmkLGqaTruhidmO9qmtiqfoqGgmmfjXv6dj288A3OuSyJfh
 VFjb+VUgLgGoJsQ2IVjllkTma1SxTCO4gUGzcno=
X-Google-Smtp-Source: ALg8bN4CUDwdso6zIc5SWYisyCacHmrKQAFbsZdOZe2b43Jyi/SAb28VS7utAeYWHMtTTf5yHhlMk/WocAMq1EYq9iE=
X-Received: by 2002:a17:906:25d7:: with SMTP id
 n23-v6mr25005557ejb.242.1548826341599; 
 Tue, 29 Jan 2019 21:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20190129132335.30695-5-srinivas.kandagatla@linaro.org>
 <1548806314-31788-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1548806314-31788-1-git-send-email-jcrouse@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Wed, 30 Jan 2019 11:02:09 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHzpZ70_qH9wvu=H_oSxVjoPXRaJ38kR9G73TRZXb5t5g@mail.gmail.com>
Message-ID: <CAFp+6iHzpZ70_qH9wvu=H_oSxVjoPXRaJ38kR9G73TRZXb5t5g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: Add Adreno GPU and GPU smmu definitions
To: Jordan Crouse <jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_213226_849419_E068C868 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: Andy Gross <andy.gross@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Jan 30, 2019 at 5:29 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add an initial node for the Adreno GPU and it's companion
> SMMU.

The SMMU node is in another patch, so may be change the title of this
patch and update the commit text too?

>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

[snip]

Regards
Vivek

Vivek

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
