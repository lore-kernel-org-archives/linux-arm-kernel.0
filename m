Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B101FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:15:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8058F2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b62sP8Mt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zyfd+33z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8058F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LRhNkPxssPRMNBHgzHpgNAyqe5N9rPZSWONzVrNulaM=; b=b62sP8MtX+6f5z
	LNM+EA4sjQT+Hc59bGDbYgVs26sLCIROLxLLCWjBUudXWcO2ji2z3Do79iWXsqZp+kSugvpT8LLoz
	WgO7MbdrEbAONmoahSTa3TymjpBnOw+QykLaChrQOkK3YDUhxR+smSrTBtDldnx1mak94CurUK5Mw
	JOaEF4M85lz2ygB5yABYs8odiowDHs7t3HPtmdY/rGvS9srKQd1wSpchNzJ6JAJIA/grgzxZaxPDB
	0EkqsVJuX6SqLcTsoKvbYGrFgWR6NkPpVk+gA2qLfJ+jNUZnn8br0KyH6MDSDPBIIBhHhuMBeAGy8
	w9leFkutVe8CfVOz9DyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqjiP-0003SS-Tv; Mon, 04 Feb 2019 19:15:33 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqjiM-0003Ry-U6
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 19:15:32 +0000
Received: by mail-wm1-x341.google.com with SMTP id b11so1099320wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 11:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sjd/gpLNTKreRRpeadZuAFUWi4BCvIcYWCkBfGFB9Uc=;
 b=Zyfd+33zXs06+ui76B+Js0mjUaqNwKqgdUMJ7YcXrPfzgYzr4Sb7MTfcwhD68yWbxs
 CNfHr5hCkRt7aivuk0/I0NS8f28Mz/Uaz3RCcYMplLqtnimhigZYWPZyIKFOTulMO2Lj
 9NE6PZ5DzlWHDt/+uUCZ6GBfAyUW35jI8wZr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sjd/gpLNTKreRRpeadZuAFUWi4BCvIcYWCkBfGFB9Uc=;
 b=IAzPOG518ddxLuzcBugHtXLPThxCb4/ujoM2RqgveOHOMISUb5XkO1pAraeZqbHPr7
 SYwCWCVBeVLTIfMnTFj74QhILcC0wcB7O2YmH7cRsOvRHFBjmMpuCYKbby1rr6zK4D+C
 aK6i/+i7YDZ6HA1Z3u7lmPc9SqzubkuQLpHHUgAFxGZHMzB2tY/MZCUFujorxMgvPfON
 rKErU9l2O7WSiAzluVdhKjtxn5IRHGgvYjIvXdLVjlrqlKi/X6ueBIWOiqF9Z6kf8Bhb
 9FdxyfoQRb8U/DppDV6UWVEtPpRUBQ93GRp5Frs+2pIriteHg4fPRVRp2oyDI3HoCVCW
 9oQQ==
X-Gm-Message-State: AHQUAub22X/uPIJCbydV6oKF6Dri8/AD4sehAKfw1IB3fXudUQhp2C2A
 mqdXRfNweBBMNmFwNYTxhodRaXZQovvhGA6ChsAEIQ==
X-Google-Smtp-Source: AHgI3IZzXt5GYnozx9vPJMEs5mTdXmyGuvnNp/hS8pWOx6zUmsvY3Yst95djA4bKlPPa9hC3Th02rVmVCE0pZUVH4NQ=
X-Received: by 2002:a1c:b456:: with SMTP id d83mr678719wmf.115.1549307728239; 
 Mon, 04 Feb 2019 11:15:28 -0800 (PST)
MIME-Version: 1.0
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
 <20190204090154.GM4296@vkoul-mobl>
In-Reply-To: <20190204090154.GM4296@vkoul-mobl>
From: John Stultz <john.stultz@linaro.org>
Date: Mon, 4 Feb 2019 11:15:15 -0800
Message-ID: <CALAqxLVo8aukbc61YX0r3ABDWYJ_cisSb2NxN1qNyWJ_tfYCyw@mail.gmail.com>
Subject: Re: [PATCH 0/8 v5] k3dma patches to add support for hi3660/HiKey960
To: Vinod Koul <vkoul@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_111530_975110_964C3228 
X-CRM114-Status: GOOD (  13.42  )
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
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 1:03 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 24-01-19, 12:24, John Stultz wrote:
> > This patch series is based on recent work by Tanglei Han, and
> > adds support for hi3660 SoCs as found on the HiKey960 board,
> > along with a few patches I've been carrying.
>
> Applied and fixed the minor style issues in patch 5, and retagged 3 thru
> 5 to dmaengine: xxx, thanks

My apologies for the style mistake. Your help is very much appreciated
here! Thanks so much again!

Just to clarify, are you planning on taking the reviewed binding
documents (patches 1&2) via your tree?

thanks
-john

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
