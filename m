Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4644C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:49:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC35214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XMp/vQzl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSo7/HSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC35214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xvvXYf3WMZRyy3RvmTSDk4AVypeJxuuH5MUYrVUscKE=; b=XMp/vQzlfedx1q
	puyU/x5ZmdSFQnWpGqvaT1caJA1buTWIMnFtF+sJC7t0Ya9RHzxmbPaiHGnOfTpzwPMUi3IOpMNtT
	Fnj0ud39DWC72Pi+VUvyjMCy000zVZflCL35cbR8F9HlP0ea/zI6YWRX+/ansGFpozNhS/XshYiyP
	zTHKNyefKxI9husLxorpreKYwV+flemNG/kceg39JUm0NCb7id5v4usjbgqQK5xg0nqcEA10nYj9G
	uiKM7j8pK9IpyyKKziwcAyvySXIv8ffIks4VE8AG5awhq4VpqhtaXxolDCyoL+1k9XxNt99FZmVbV
	GwQ5rVjvJC0CPpMWmPNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBzv-00005y-IA; Tue, 18 Dec 2018 09:49:07 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBzq-0008WS-R9
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:49:05 +0000
Received: by mail-oi1-x22d.google.com with SMTP id a77so1455231oii.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 01:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t/S7/FqDmA+7g8YYk57whu1nnBdedagnVtqBFsNKTs4=;
 b=hSo7/HSsPCtWSYNoWH7ZhQiOAlfd3QgDckGMrWRAq9BKcARCTXk68DwzgHcgJrZYOZ
 xX2HclMDi+sO/KYYYnyymOEI0UWwT9ZXTGZY6zYsQeTqIfAX22Cosdu8iWPHpHSXbdYe
 Ilky7pGZSvjHHF/EqFo4OaQYiYgPncA3hIxfDznJ6hh4DuqZxRmHMydjGwn9jAqj3R9o
 pz5EmPSO4AkDDPGa3/21HmuaZe9ew8Hxbi7KYqKYQlgrShO0GzEfwT50bRImo5hDmjFO
 gY+K13PLPN/Q1Ce7e6h41LKdCDcBntGJ7tKGg26LjO4y3m0liFOM5JbK7i93+XXAWPXG
 c2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t/S7/FqDmA+7g8YYk57whu1nnBdedagnVtqBFsNKTs4=;
 b=sGH6j2MW6bfWsIcMfXZavQajnVuDdgln7anhozRPKD4nr9Iq1xZi/F6HJNZkdZEnag
 dt+MAT3ZC9w55/xgvFM7uakBkdt82CCte7N21OcUoGkg8B3WeJhgauG2ER2YQpT0MocR
 bkRCldXJphIr6sDLNLWyFu85vE0yVOGTYD9HPbjgSqaCENCBa9HD86lWdUfhuEwDMXGU
 8cmf+zKTFNql29ivH7V7fyWsR24Qwk0Fdmp/2yiGumQtljLYQs2BNlyd0YpAMZ02zkxQ
 C1Jbr4Xymkn9rtkkrQaZN4AeQAEQzFMyYClr8bjgcXm5Ii2yBTcP0+VolQUdp86qL/38
 qXwg==
X-Gm-Message-State: AA+aEWbXq6x4ch2xzqJNy78S9ddcTNbTimUTLfVzpbb7DFjIOUpJMwSe
 Y5p+pEHFP4592zA/c68E9mNu8HOL7cDKqxCt1fA=
X-Google-Smtp-Source: AFSGD/W05Z5iPtTs0/4NSp24/Jvk6y4O8qD2dKpa7L02+a4WJxXHSnfjFd7X8vpQE/OfhzkZl/j7rRotkwMxo4Q85vE=
X-Received: by 2002:aca:3092:: with SMTP id w140mr7683815oiw.237.1545126529293; 
 Tue, 18 Dec 2018 01:48:49 -0800 (PST)
MIME-Version: 1.0
References: <1545115389-173136-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1545115389-173136-1-git-send-email-weiyongjun1@huawei.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 18 Dec 2018 07:48:43 -0200
Message-ID: <CAOMZO5C1+bxWtapaBrdzf0o3Q30BkBNHLg9=4K5ZsxBk6s2DWw@mail.gmail.com>
Subject: Re: [PATCH -next] clk: imx: fix potential NULL dereference in
 imx8qxp_lpcg_clk_probe()
To: Wei Yongjun <weiyongjun1@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_014902_879151_27C885A3 
X-CRM114-Status: UNSURE (   8.69  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, kernel-janitors@vger.kernel.org,
 linux-clk <linux-clk@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wei,

On Tue, Dec 18, 2018 at 4:36 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:

>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
>         base = devm_ioremap(dev, res->start, resource_size(res));

Wouldn't it be better to use devm_ioremap_resource(), which does the NULL check?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
