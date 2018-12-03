Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F10AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:52:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D1820848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SCdsf3OF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJHQmgm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D1820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=sVvYtN/zmrjSMsg86Se2CSGk9k3NUHudgO4FABKc1TE=; b=SCdsf3OFIW13RJu1P+aAyO+w8h
	8IoApI5ctW0B8aHfVjC4FrR+vykFy7+8WCthYNNcAzfbKu4r9kppEUueF+VzdOkYTVZcUQiHScheb
	ShMN1Ok4+mKv4v9mof1rwjSVkHzxjbKMV/uMXHj4IG/EtBPF7C2Cub2OQ/jitqen5su+Zh1+OIi4+
	J75vfxkwk9jV1zsU1K2kcoqQAcsYPtm2hwQeOnwWL3w4Idw33m8A3HTViKMbpTdfcL+GMjLDHFrIp
	TDw0xV45ZnjTihqYCxowb2wr6TlmYqb6qHakk34UCQdhlfVyWwJyj2acnu0R8OKRP3eIRLun8dENW
	mMceGUHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTuG4-0002g9-DF; Mon, 03 Dec 2018 19:51:56 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTuFz-0002eT-8B; Mon, 03 Dec 2018 19:51:53 +0000
Received: by mail-wm1-x344.google.com with SMTP id z18so7200605wmc.4;
 Mon, 03 Dec 2018 11:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M+tZ+Yvz9JuacATj3m55Ts39kHLw7ktuAbOQzLJQ8u0=;
 b=OJHQmgm4QX2/pywf55lqxhcDl0rO0Ed3TawrLybGgK6s4YVSsYheQLCtyGfH7ImyNU
 s8jM5EWffoCnE6jA+oMDcllqHSzWbkvKCmsa3jKOLJmqMjAPc5x464RrgyDev/krINjG
 l3zKxvSAYShnXnnX6RoggS7lj921+4EVQ/EthWzgNJrIr4tDi9laPvesFjO8vmife6dr
 pM9ZD7riCEMBIQFBYVg31c2GjoAjZlzqFWekWG33JSFj2Jljo92uUsPK0CHJY8cnS9hf
 DBCi87y8HurLpqcXCTaPnw3vx5NvXQfbFa5c4bkFKM4f8vuU99o9kfjDQK7ixEbBn7Rw
 ezug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M+tZ+Yvz9JuacATj3m55Ts39kHLw7ktuAbOQzLJQ8u0=;
 b=l5fO7mnjrA/gEtVQXdjR2PiEMpzs061DCjPAOuGyXvOJPpqTxgpOZWnqKZreRAYDmS
 Po0dPM1ow5iLJpHh0Qiaq8sh4XYzuVUM6WBG0wiiZeG5la87zg/zumuLkcdSvrLl0dJY
 HVdFZ6ZnL9qF2oagW8RZS0tvTQ0QtbV7HEWZH82ZaA6yLNBrSOr9UQHIfJXV17h2ywsN
 h+eRunhHzJ0qazZJhofUOsPE7K5Is448zzANktc8bE/kcpIymO9UWrCkhhmudiRrI3t3
 dXBdA4gqVgfFH+Y3I1x9eJHJ2XcV2SnvUdrTnRYDDpUVokyude/WiPSA735nil2BpUvy
 hbow==
X-Gm-Message-State: AA+aEWbAZvqqWDDx1GoOR16p1eFmI1yHvEuTp2l9oBCNdqepOijw9Moh
 bG9xrKfkmne28IdZMa3/nNY=
X-Google-Smtp-Source: AFSGD/WFYdyNOFQVZbgu8wekFs5/A4XnW7GF0j0RBJdV7nBf3gd0paqp2GJN3JhXdWRp8WdqI07IZA==
X-Received: by 2002:a1c:848c:: with SMTP id g134mr158399wmd.93.1543866698635; 
 Mon, 03 Dec 2018 11:51:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net
 (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
 by smtp.gmail.com with ESMTPSA id t76sm17569433wme.33.2018.12.03.11.51.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 11:51:37 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
 Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH] ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs
Date: Mon,  3 Dec 2018 11:51:28 -0800
Message-Id: <20181203195128.4417-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1543862228-3863-1-git-send-email-stefan.wahren@i2se.com>
References: <1543862228-3863-1-git-send-email-stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_115151_317139_02768E43 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: stable@vger.kernel.org, arm@kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon,  3 Dec 2018 19:37:08 +0100, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> The commit b1b8f45b3130 ("ARM: dts: bcm2837: Add missing GPIOs of Expander")
> introduced a wifi power sequence. Unfortunately the polarity of the reset
> GPIOs were wrong and broke the wifi support on Raspberry Pi 3 B and
> later in 3 B+. This wasn't discovered before since the power sequence
> takes only effect in case the relevant MMC driver is compiled as a module.
> 
> Fixes: b1b8f45b3130 ("ARM: dts: bcm2837: Add missing GPIOs of Expander")
> Cc: stable@vger.kernel.org
> Reported-by: Matthias Lueschner <lueschem@gmail.com>
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911443
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
