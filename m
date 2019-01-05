Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F77C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:29:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C74E20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dnYinS2v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oy21tj0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C74E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dCnsERDHvp1OKAWT7LCnXChn+fleG0wEmvrl9AvaMB8=; b=dnYinS2vtvneBs
	QS1/0vJ3Sb2NdgFgfvEnZx4rst6hqXWD8ipZE3eQ+VIc++1EWJTZJ6uV/YZFO17V2NPEcy8pAebDs
	r2M6qENHw4WMi79dFA/kMT1zNWETT98fKOiYOhZH3gA235VPy5LcohJhGcVP+Rr+4TU5nIT9Th6de
	gjLrumgDgV8xQ7I4fHg9jpQex3RhM7EdgQe4ZmeUDS222NGAhGS0Zfc5vBveY+q2sBw0goPXP3AGM
	EBm4cgNJbTDLIhsJtjArLT4TOLAMCSiGIUyepoPY4DG69T5FEXuJ28yOyPqELND7zwgKRLGMiHF5H
	joVGVrFlbznxFOCTdNEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfda8-0004j4-FF; Sat, 05 Jan 2019 04:29:08 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfda4-0004iU-IZ
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 04:29:06 +0000
Received: by mail-wm1-x341.google.com with SMTP id t200so2936495wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 20:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SZSPuh0GXoAKyYjln7SJ7jKQMpi8XwwTaPAt7OPwCjc=;
 b=Oy21tj0QQqmmGz7i2/XrD2TeUMqgmQrkK5jy50yVnBDdaNDQ4WOxYS9YI4jb6B2cUM
 qUZ8XpbC/7RjbKdIc3RRGCCQnUjupiyogCyQ9DhdRSMyTlZapSmfRabA4ifv7ofpnoqm
 bjp9y4bcHOOH+TjYIO00SL6Yn13bD/nyVKXWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SZSPuh0GXoAKyYjln7SJ7jKQMpi8XwwTaPAt7OPwCjc=;
 b=t0UYUI7UsJGONVJH+uTSMTsNXCHvhtnsT4HFYmTzbGPa7BPCAgusrEYdVEeuwbsLny
 CRh1kL5cT7ZM3rnZX8leS9EQSkUFxCt8ZJobj7UHIG8/utv/jpMmYRWWZmxuTF4lUTlb
 y10MDWhDsynA0bnlldX90163HPDbIayr75GbIkkg++6een8Tia5FHMXUAdG4UxIVtu7e
 TS31/4dGlm0C9tQP4vyO8vkI8WaZcJwbMEWNDGD0wDvplNvwxrx44GbrHoqhb0kTYOIz
 e0rh9zHvrXevB0o/qaNIihEkGH//h7wmrJh4wV2f//7wkcdsO17s+2uoNjKZ9E3zgP/4
 AKZw==
X-Gm-Message-State: AJcUukdDmy5QJj2dhUErWfO/I2Uk/am98Dppw4pMb9eT1dY8xZP8THIO
 ZPec1j0TxKCxC4+V04p2sdF0sTkxcsqaH46PUhlT/Q==
X-Google-Smtp-Source: ALg8bN5quKAQpWOq4LNucC+H/1bH9zn7q5I8ge8a/LwB6gqregrDQL7e4yeizLVpqht9G177mObTS0vgm47WVYjo/no=
X-Received: by 2002:a1c:e088:: with SMTP id x130mr2867040wmg.23.1546662541221; 
 Fri, 04 Jan 2019 20:29:01 -0800 (PST)
MIME-Version: 1.0
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <20190105033738.GA2477@Mani-XPS-13-9360>
In-Reply-To: <20190105033738.GA2477@Mani-XPS-13-9360>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 4 Jan 2019 20:28:48 -0800
Message-ID: <CALAqxLUkLExkYUY+JARcp6znngFiRnXO8dYF9qWEZNmBPtdDpw@mail.gmail.com>
Subject: Re: [PATCH 0/8 v2] k3dma patches to add support for hi3660/HiKey960
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_202904_614686_13144404 
X-CRM114-Status: GOOD (  13.04  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Guodong Xu <guodong.xu@linaro.org>,
 Ryan Grachek <ryan@edited.us>, Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, lkml <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 4, 2019 at 7:37 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi John,
>
> On Fri, Jan 04, 2019 at 12:56:20PM -0800, John Stultz wrote:
> > This patch series is based on recent work by Tanglei Han, and
> > adds support for hi3660 SoCs as found on the HiKey960 board,
>
> Not sure about the description/subject here! This patchset adds support
> for ASP DMAC found in HI3660 SoCs, Peripheral DMAC is already supported.
>

So yes, it does enable ASP DMAC support, but the full set also enables
the Peripheral DMAC as well in a few ways:
* Avoiding setting the AXI register, which is configured differently on hi3660.
* By adding support for the dma-avail-chan (so we don't try to use
reserved channels)

thanks
-john

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
