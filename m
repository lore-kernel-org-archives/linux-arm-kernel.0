Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB024C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:11:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5872082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dzxws6Vn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJyWZd59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5872082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QEb+yTYdKYxHfK4eS7gkj88VIhVj6ABQfm0b4/vsDqM=; b=dzxws6VnVSGfxr
	9c8fCIet8nXdxMETxcJCzrFomI8y6nO+caWdbEUnB5f3jISryyF0HptZW3unTXU+M4cp8gO355kWV
	ZoJjX08mQB6LWwJI2grtFKtb9nVV8CkvjMRGtSmEcwLg40FAQ1kDRw7+fOjPnZxYNmJwhZj2UUUVb
	RIexmKjxw3f7Q/hAL0K5tuaPuZKvH1ek7G1Y4flUvHhG02+vPxHAfD7HKkvLeWWX7glDGqiTmjt7P
	G8yeiYfedLc1yESruariThET4akEggg940s4ywSvZE38C0ka/sHoSS88XGgrVDXKyATnghODZMSTI
	oJVKmsQ6+Jd9abLUQ4dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkz1-0004IY-7n; Wed, 16 Jan 2019 13:11:51 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkyv-0004I6-4D
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:11:46 +0000
Received: by mail-ot1-x344.google.com with SMTP id i20so7124883otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 05:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WYbvESzi3MHLWnd2PGoU42O5hBXw411ONY7gkyHaweA=;
 b=lJyWZd59FaF+sDcCyxfI4zq0dQrY8hqtuP/ONPOlHzW4xkWKgK08Esf+0zFEmIs0R0
 sFsiEdRU/HNDlgAj9K/nixJ9rUbzeYamq/0EsNFOa3P90V833Lc4xLTgSAQn8x0929UH
 6ulmfUYONnFguxnmczQqyK4bjWgIvp6ebTMbJ68B+Zeqqi5FNjE6NKOio14LGazt29cA
 uBhLNL1cbqXfaexqapfp0cBFDX+Ber4fezboPqJxQN3wHa8DAWB9s6rPAuRhSvy4twoX
 hijroa9K6O+XS61T3wC2ARyC2VPcJdgZ+yTT2avo1qGV2FRmIMV1iqKPLhaTI7tl1PZE
 aeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WYbvESzi3MHLWnd2PGoU42O5hBXw411ONY7gkyHaweA=;
 b=nrasBtcdtDYdTr2BFhvWf2jTUGythLH2uFrc/N2fCtS9wSXgQSVCVkBBwehQgUQM4C
 TDPctuNZT8tsoj1sTanSOHyjo/+f14vkDcs1z9LDnbFuTUr26V3RpcPdoVu0LiaAOS7H
 V3WyZ8seBAZSxrWUbZLHbx/Mqs759FPdsAIKlnsBqalTLH0ty6hpzLgurgaLrR3vcmD3
 mTxg9N4R5b99kBlr5ihdJNCTbbdgb//NK1mQnCMM6gBSvRWLaLktL+IQ0MjYXn3ABZ76
 +Gw6jhF4gPW2U6ALywthpUUj0feJeTKSqGaGzOiT8ixdKD6WuvpOf8Q0pZtRp76HieBM
 FMzQ==
X-Gm-Message-State: AJcUukfu3p2UCaMRCKseu52XoOVFDfJicD9tBnam8XNKf2kazJs3qO4Q
 NlGTW2axSOVAhoyy8K+ECPYJR3wlgvuQfoP+B0M=
X-Google-Smtp-Source: ALg8bN44D17nhZKn6Ag2Wr9n2qTeJbgXIhCDi+pB3ACsyOCmzO4A2mlXK/ld7I1p/1Zxq7ZQy/38hWxwtNb78UhBg28=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr5701786otj.228.1547644303237; 
 Wed, 16 Jan 2019 05:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20190115170501.10952-1-daniel.baluta@nxp.com>
In-Reply-To: <20190115170501.10952-1-daniel.baluta@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Jan 2019 11:12:12 -0200
Message-ID: <CAOMZO5D_kakB82dEcXrU4EZARLj90US8Zf+sGgaKkZvUG3t=PA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx: Fix MU4_INT number
To: Daniel Baluta <daniel.baluta@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_051145_165449_3288C80E 
X-CRM114-Status: UNSURE (   9.55  )
X-CRM114-Notice: Please train this message.
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel,

On Tue, Jan 15, 2019 at 3:05 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> MU4_INT correct number is 180, while 179 is for MU3_INT.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Two nitpicks:

1. In the Subject it would be better to specify the SoC name:
arm64: dts: imx8qxp: Fix MU4_INT number

2. It would be nice to add a Fixes tag

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
