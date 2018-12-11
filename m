Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948D7C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:10:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640222081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4GVkVQi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OYOvDDQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640222081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Eo4DdrPqueCcRcOeJfZgK/s74DT/DWHs+IADqSSHZg4=; b=U4GVkVQiOCzZPX
	0X/I9Y5VVZ/yhk9cSjR5o+rWPjpwwp3yG0wgjmXVyiIq0VB14OSq8zA3Vfu34+2Az8IgrlHd1puCS
	xytnPMjxccjnEq1DKzQsgLJd248a35LEY/7ryeIuV3kduAokfYKS43l3YkeALWt7L8wD2eXqITGtn
	eOnPr14Xbw9vpjTGPs3n0/T/TjycZPud64kZ5wRqfCrHT/EaN3UoMFGyJVB+rrLXNLM891suRYJfH
	DZMkyERAiGVs2z//4yyHY5gUblXxlrClSeb+POYPjboqhLcu8BWS5OTJjj8iu6YL4aBe5BZuqO8eQ
	tcFCve/IvNx6AffPnakQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlXt-0001ck-LT; Tue, 11 Dec 2018 17:10:09 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlXn-0000cg-MD
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:10:07 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id m129so285943ybf.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=isO2lANIsBVerOp9/+QCe4JcFwBPboQ0U8MIF8oqQdU=;
 b=OYOvDDQFgjozMi950T2wJ93zbDHzYcx+bfPnyIb6rdTSFYHlViftwQSOQcY4QG775t
 09y1zJ5g4smFLTtIjNTDmVm/1VpgPUyEzTnL/ebxBWyjk02/QnCGxdOQ75x8ngM2KA60
 4laWTqPVVGIE8As0SAH931j74l1PdaVwr+WxU4xdc26T3TD8pF9rdjErrGsazJf36OQ/
 z6fejXl7yzurPttsfkPGkhBn+QdCfv72XRHz1/5syIfJsF6xFbKvrVEI4yaIQvXMBW2X
 E1yPEVKVE+OpgD3AI5oeqNc4JSltXTAVTr0i2CqTklCmkOpdeoS9dbq58osmKyi9QUQg
 NmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=isO2lANIsBVerOp9/+QCe4JcFwBPboQ0U8MIF8oqQdU=;
 b=qme+K4Lctj05HWI/mqJiujsYCCnUoBbEkQEHvnqWyDZzS3+ikvzh1Ws3QZJxsLCRMh
 Y1ThHAwbp+QRV9yE2fE9Wz53C+MFLgyG49cl62JMZLKl7BJFy7W5/75hZtK5ZoUNADy9
 uWqv7LSmjS0Gf9M740CGxK5ZEQLH3xxsi6UCbQeVufL8gOWXO2s5+MxUQk9g0Qx6nI0t
 XAJm6F5HqZUMGGkpzE6k8wFvaIENIodqbCiy2wcfsbGPGwoi29ti7S4RFv+EV09ZtLMW
 ndZx668W4LSNR7nOdtj+1Yx1z2ZIWU05clV4cy4CVhMaUBs0RO38Hsob8je6vFBvAIg9
 RqTA==
X-Gm-Message-State: AA+aEWYDpBvo1uaWPU13kjDr9l8aOZWW0Kf5joSmGd9b5594l6qXWtCp
 w/dJ5p/nl5NvZi+347rimSm08A==
X-Google-Smtp-Source: AFSGD/X4yQhW/rhJ7yUmhw+Fo7vORTq6PUCcBWTLcqmXZBn51hSXskaboJZ8Y/yaRD8xYOVLbyRh1Q==
X-Received: by 2002:a25:4b86:: with SMTP id y128mr17018799yba.10.1544548191724; 
 Tue, 11 Dec 2018 09:09:51 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id j6sm4929467ywi.110.2018.12.11.09.09.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 09:09:51 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [GIT PULL] arm64: dts: Amlogic updates for v4.21, round 2
In-Reply-To: <CAL_Jsq+SdoMCsk2uf=W_bs7ObCL6KvLA7gaojteFJmRhm4QjwQ@mail.gmail.com>
References: <7hpnu9w22b.fsf@baylibre.com>
 <CAL_Jsq+SdoMCsk2uf=W_bs7ObCL6KvLA7gaojteFJmRhm4QjwQ@mail.gmail.com>
Date: Tue, 11 Dec 2018 09:09:49 -0800
Message-ID: <7hftv4uh0i.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_091003_764480_C41DD353 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: linux-amlogic@lists.infradead.org, ARM-SoC Maintainers <arm@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> On Mon, Dec 10, 2018 at 2:37 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> The following changes since commit 5e339a1d7e438b2cc9f46ec9f2682efb58ee2dd3:
>>
>>   arm64: dts: meson-gx: Add Internal Clock Measurer node (2018-11-29 12:30:09 -0800)
>>
>> are available in the Git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2
>>
>> for you to fetch changes up to b29e9eccaaa721c2a303db6540535ee77a515f61:
>>
>>   arm64: dts: meson-gxm: Add Mali-T820 node (2018-12-10 12:11:32 -0800)
>>
>> ----------------------------------------------------------------
>> arm64: dts: Amlogic updates for v4.21, round2
>>
>> Highlights:
>> - GXM: add Mali T820
>> - fix IRQ trigger type
>> - AXG: enable GPIO IRQs, PHY IRQ, watchdog
>>
>> ----------------------------------------------------------------
>> Carlo Caione (4):
>>       arm64: dts: meson-axg: Enable watchdog on Meson AXG SoCs
>>       arm64: dts: meson-axg: s400: Enable PHY interrupt
>>       arm64: dts: meson-axg: Enable GPIO interrupt controller
>>       arm64: dts: meson: Fix IRQ trigger type for macirq
>>
>> Christian Hewitt (1):
>>       arm64: dts: meson-gxm: Add Mali-T820 node
>>
>> Jerome Brunet (4):
>>       arm64: dts: meson-axg: remove alternate xtal
>>       dt-bindings: clk: meson: add ao controller clock inputs
>>       dt-bindings: clk: meson: add main controller clock input
>>       arm64: dts: meson: add clock controller clock inputs
>>
>> Neil Armstrong (1):
>>       dt-bindings: gpu: mali-midgard: Add resets property
>
> Submitted, applied and a pull request all in one day. I have review
> comments on this.

Sorry, I didn't expect this one to be controversial.

I'll respin without the GPU one, all the others have been in my queue
for awhile.

Kevin


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
