Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46230C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:55:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18622081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rsIiJaD2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6A61lSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18622081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iJfeBA1exkgH0ap3SiK6eV6geIRJxKjpsmqTaKPp/9o=; b=rsIiJaD2Iq3HmE
	M/cW3q3//oTxkQn/CgoUNUhqjgZVssyQlMUd1Mt/Ij24AIjrUGUAjux4d96+GmYrxWAzI1Y8MyCLN
	g7/GkBZMxsqxHOs1crFtu5ZWziZcnHWSRIfdCABKRgX6uclRhtrmLEJdutrb/OzXiBZMiuGMQuxU4
	E4TbcoY0FIqHZ5MfJLa+Jas6PeXRNE5kuyJhvBAoaH+CuT9+KfRdwqctsYKSAbA4FIC/TxIOcyWIJ
	IDjUOPVJjfOMtnwX8zMXX9RF/oMqNgfikvvH34leINWGd+btOOO8/ZPTDPFfD+P3PAdOZiLRJPhhG
	ccHFgb+EWOKl8h9Gr4rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gozhS-0003az-FV; Wed, 30 Jan 2019 23:55:22 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gozhP-0003ac-2Q
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 23:55:20 +0000
Received: by mail-oi1-x244.google.com with SMTP id u18so1219070oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 15:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t4Hzl0WnumLfehaM8ySLdsmrRbbatl3xeeXUQDRSUHg=;
 b=i6A61lSqDFJ9Qm1oQGFFoZvqJNXpDsB/xyq6pKqhkI9+1L3AuJTKRdq0TKiqkiSPQW
 Qo3FYw82f1tqc2qPnvLdtNuXQjR5pXlC5ffWRA2Oe75l4gLPzmOsLYrcQ7tyKraGcbJq
 0nhYBfBBQovKbS3iLvsMcVldvNnZoW53gzBfstxz9602pSQj+UOuPNa7epb2sp6kHGRl
 x1sD36io2J2+JrrMZJUGn+2l2W+q4MB5WHtHKmZFGudceBrdK2NqXDg9w4HtiDkMsxZ6
 NQ5bjKx7urlb59qPY+aqMqMXnfczV7QeSCgTgbXO9WdJot946RnBpXgpmmwQrCIOu1+G
 /TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t4Hzl0WnumLfehaM8ySLdsmrRbbatl3xeeXUQDRSUHg=;
 b=KbuA6oVhTGbnuOrDGh2Hb+C/9vlBn8x8r75PaMYZA4mSV73gbREHRq2clzATemPPcK
 nJKFlo0rTWdmeUryGJbsh8tcyzuTAQIckupQpk2wniUApVuJK5s9l9cf6jezBUuIiaMt
 sywJJ3UlTj0lAcKnhQiL63MUy6avWazlLWxeBdW0qnZfKLwL5WTN8TXQ4737kwRmRVVj
 ckZlNrQCMhB/jbmMLq+M6W3l/5WAdzh6gSsfYOCwcJHkme6uLUpajUM4GjhqoqPedAuX
 K/dGhyoxVI5Q6hNe0niTsgVz4vJUQmo5cKHAtR7fiNWHySWGZqbiqPhe2TF5sRU/r8k4
 PVZw==
X-Gm-Message-State: AJcUukfCrS9aH64fzDYnhn+i8hgzirKVmyIRiZIoEWG/p8qOqRcoNEgD
 mv2kyx6b5KKrP6LqG84vdR/xZAKvko36quvaEZY=
X-Google-Smtp-Source: AHgI3IY6OiuRAnVEbsBQL5dFZqovDdRsxmu9eHRz4Gfm5PXMvkwSn2jCH+lxErvOAinha0IwyqD/b5kapwDiNC3w1p8=
X-Received: by 2002:aca:ac04:: with SMTP id v4mr14037099oie.342.1548892517783; 
 Wed, 30 Jan 2019 15:55:17 -0800 (PST)
MIME-Version: 1.0
References: <20190130201725.18961-1-ccaione@baylibre.com>
 <CAOMZO5AU8y1mf1DCMcJ6Y_AN_rP47jx1uVhj9pLRtgL6P70ksw@mail.gmail.com>
In-Reply-To: <CAOMZO5AU8y1mf1DCMcJ6Y_AN_rP47jx1uVhj9pLRtgL6P70ksw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jan 2019 21:55:05 -0200
Message-ID: <CAOMZO5Bs5sBniOtDgc2br9i+eA7CcR7T2K7KACY7STVdkeBHsA@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mq: Add missing M4 clocks
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_155519_141203_56315F6D 
X-CRM114-Status: GOOD (  10.90  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-clk <linux-clk@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 8:46 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Jan 30, 2019 at 6:17 PM Carlo Caione <ccaione@baylibre.com> wrote:
> >
> > The clocks list is missing the clocks for the the M4 core.
>
> There is a repeated "the" in this phrase.
>
> > Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> Reviewed-by: Fabio Esteva, <festevam@gmail.com>

I meant this instead ;-) :

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
