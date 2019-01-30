Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC18AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:25:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0122087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ayQMNIp5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeCz4Aa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0122087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GLiC3LHnnv9laoviJkRAP4htizDheIUjZyy9GuKRKZQ=; b=ayQMNIp5xd9H62
	MLnP11nIMi+4dDqsJu9R2xpUm+20ENKYqsj59Cz0OoodrGa5EbsmcwwjcqHHaW2TKd1E7I5eYi6KE
	qLuTAzpluE4Mer4wbwsQ5c18fRK//73fI7F3RxGMocoyXU7GLk1CGNXiuNr1M9by9QlIpK4yBJqvL
	bV7uct+4oPdHyB6Ln8ZBCQIlc2Tuzn267UdNs67OSti3fPPtGx6BK3/RuteEmn5kgYSQ4jmcnTklT
	6TRh0An5mMKCbQOOBPkzZ3p49zlRqduqGBbsrG11cRKxLmJA30Kpv6uYvbeIp8coZ42uvYHJVLGTb
	WOx7MybCEc7LkkAzRVBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govUf-0006sy-K1; Wed, 30 Jan 2019 19:25:53 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govUb-0006sd-GL
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:25:51 +0000
Received: by mail-oi1-x242.google.com with SMTP id x202so576316oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6N7Y0ZtoH57SO9ofxRIg7BmtjhFRpiEHwy5BNQdmsFE=;
 b=BeCz4Aa9oHHe1VMDzf3nmQInDEzlY86kxX+ycxdmrWdqRTCg90auociYXrpToNW3/5
 9skJ8iI58UwPi7oB+Dd6bMrLRwkfbqRTPlJfo2ad84gnMfGAh2S4lp5TtMYJa+0CQRNu
 q8x3Ct5KaSx0Oui+OO7Rez5JLJUzpg6td6hdUdx+BBb5d2eV0MjiNnk/VQGfJSRWFvHk
 FZBQCow8GDB1Yu89oXGuxRt/z1C8wduHgwj2oARGpDw/y6mpfiyEkB6Q5oIMSvaXhqxZ
 PSzfqdSgVTW8SiBQB7lOg1pr3wA4/0dji5udaJ6/YwKxe6o1NMA1i6vYW/1AVA5Pt4of
 qU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6N7Y0ZtoH57SO9ofxRIg7BmtjhFRpiEHwy5BNQdmsFE=;
 b=WGLvATp8btsAHXFST5siXGW4nfIavjLPMaWARh8c6SSQpu/nHKqKy2uG+9OixaXIHd
 L6VqZRp2u40K3N4DwHkWNEmm+glWOCCKZPZmnzC7QFOUhZyJj9Qb9t335yn64RlEhWDg
 9ttxKmj5s/NgQYHb/ut7PJL+ESbYk8nYWmuJBLzlDYYZr7ytsumJMY6bg8yRUQuawDSB
 fpu8UfivkcnEGEXVK9EmGEjBioD2G1uPrpJ2M9pymcXW8ZieVSPgl3Qu1A2TjKqfSMwK
 0whMDkyWsRC/JZiIBiRwTOZFIW8j+4UsPF/COVE+iaCKzRHdMK+l8mYeLynzvrkLCu0B
 wPmA==
X-Gm-Message-State: AHQUAuao5WcHjEs6gDUaow1cVXK79ca2yDK79k+u2v4w045eYZ1i2Sm/
 D4lNHZYGVqUm919w1pXd6k7oMYQqAIP8DsKKN6o=
X-Google-Smtp-Source: AHgI3IYkWbLvwj5tAbBoDPk7Z2VETRS5bRawX06NX1qIikIavwi6bJYu0riE+TIofWqlFTJ0ceP2jJUS6ibkMABSPow=
X-Received: by 2002:a05:6808:296:: with SMTP id
 z22mr13642672oic.67.1548876348289; 
 Wed, 30 Jan 2019 11:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20190130120511.11555-1-ccaione@baylibre.com>
 <20190130120511.11555-4-ccaione@baylibre.com>
In-Reply-To: <20190130120511.11555-4-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jan 2019 17:25:37 -0200
Message-ID: <CAOMZO5D83RvWSmLX5xsiRr9kZ6r+D42dAdY1zYFqyDD8XR4hig@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: spi: Document imx8mq binding
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_112549_553754_F31E8C56 
X-CRM114-Status: UNSURE (   8.88  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:05 AM Carlo Caione <ccaione@baylibre.com> wrote:
>
> Add the "fsl,imx8mq-qspi" binding to the spi-fsl-qspi documentation.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
