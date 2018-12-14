Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B24EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:11:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6997A20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwyhQacH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nt4O2c5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6997A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G6Tz9pk0cACXxeLujwVJb8owHBTjJvd7wnkkxEnSwk4=; b=lwyhQacHDdqZOl
	L2T/eO0Ch/tGeoxFgtcrnSBcAZvlqcFjxOLeu6Qe19rMSQVWnrtnZsbraEKI7j2OscmhDZzXAlQga
	/wtrvbFBXouHverdbWXkYZA3T+vyjFWPZzxGxU1tPHzPbHRQMJlv1jtgF7l1O2ulGaPzamqZ4/Mav
	m3Ovy9LSJLPNyZ24Ml1V77KudPv3ZkYHLSYvVh4SNmN+lTrikpZElcTCsUb22VIzxpkyayM+L30VU
	d4ArYwWW4dvaRzgDtMu1kyo997TU2x549GK4ytcqvkcaX5UMZTl3iLvPfcFD6m8dVLlmKD4xi6x4c
	Cdvx7S/o9vjqrBe/+kkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp7x-0000MD-2F; Fri, 14 Dec 2018 15:11:45 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp7u-0000LK-Cc
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:11:43 +0000
Received: by mail-lj1-x241.google.com with SMTP id e5-v6so5192659lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O5f+R6CkYyF+DB4rXL4f6VuBpAL6bXvmcWoosFFq5X0=;
 b=Nt4O2c5+ox61MBT7vu9pb/zy9nXOO4QR5tyU1RpdSHKosr3a5J97z/MXttK0liQs5S
 N209RYEysgy+aI5BWJM9w+jOFxFIjTNDP7ZFS0s5iejZZlryJwxjdhn9UkZ+j8ftdXji
 kda0N46fhC9AFHvFJxxk/KajtKXDcIf59R2QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O5f+R6CkYyF+DB4rXL4f6VuBpAL6bXvmcWoosFFq5X0=;
 b=VDW3vk/KT0vUgPdCUqi6R1GX2eWFWS/jyNwyW41ZQO/oFF3qTDi88MHmAfI6Pny1Yq
 AeTssPrW8mbo4kef3U/wFOy++KPgrUGMvcQ8n3pmYQpIgt9Yuqr9IZzVaY+0aeTaKfTN
 hcTIOxO0N7BQHKTzlkxb59YCnmNrC++OnAQTiKDIKq/a+fvkfYytDMw+Jl8BI9ZeNfVt
 oqbjY9tgM4QHFIvJ5vg/hk8GjjnSlBA8hQOBxwtKn990kJXFGcwIj5kMHd50jzDzBXt8
 PZNvVrExEF8emD4FK91G5kAk66wfS2ZSMGR2UMumicIJgzubdNrpuPFT4X7dAKbhAbGQ
 fYuw==
X-Gm-Message-State: AA+aEWZb75MXM7EoUViHic9/T8JJZCe2HLsz682xw8TJ5ynWLxwrg7Rm
 mnaoqWDiSjn+FBvMKAML0lwVEzF5fTrZCLWLW01GfA==
X-Google-Smtp-Source: AFSGD/VAyAPw1ch/TsSLArR5bgvYkj4Sr0t6uv2/s3XkkW1TD/b5dq4amrVe20z67DNsxsPHod3IHftIZfNnxvC+lUc=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr2099822ljk.4.1544800288389; 
 Fri, 14 Dec 2018 07:11:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.50931fbda5c95345087740e4c1ef5a57fdd53480.1544104801.git-series.maxime.ripard@bootlin.com>
 <3401ca7517927243f567899819e0d02eee12984f.1544104801.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <3401ca7517927243f567899819e0d02eee12984f.1544104801.git-series.maxime.ripard@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Dec 2018 16:11:16 +0100
Message-ID: <CACRpkdZU5jnEMe=eAgF5HoFUjyGbWVungSbu4XpOkHaf9xEYiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: sunxi: Deal with per-bank regulators
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_071142_421522_DFB741DF 
X-CRM114-Status: UNSURE (   7.90  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I have applied the patch, but noted that this might need device tree binding
changes/amendments, are these already done?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
