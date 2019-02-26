Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE55EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:54:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF6A2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z5tZ342m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6hbdVXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF6A2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DwjvZHtEtRyclEsCyA+nJQhRSxsAAbrXcFyFKtMltUo=; b=Z5tZ342m0wWJFI
	NtBjtxmztppVxbcD0XYkmI9BrR6ROJZAxvi7lntsNuiOFomWAaz27vU3hqa4dYYza/id7DItgxqhw
	hEoKZRPcMUtuzDfmfJI5XKIIPx0IpL3EcZ6xtV0oHpjFy2wfMB1h9TtuWIcoNyH1ZHWAgvfmcJikr
	6CE9FjUP0htytryHeZS2ZPE/JWiuR5yvL7WNHpmwApT60aMOcFd3ae5xj813sQfQZJioAZsSMrR10
	5J/emqYkszKW1/8rbqPHzUyYISPKKfBeNHx9g8Z7TcQml3l2S072VOaDooCuSVtLXaU3HOfUMZEDJ
	1yuQfgGgmZQ4Tz7qYGJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycFu-0001P0-SL; Tue, 26 Feb 2019 12:54:42 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycFr-0001Od-1P
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:54:40 +0000
Received: by mail-ot1-x343.google.com with SMTP id z19so10994464otm.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KfGzKP/OLXFBdjiuVCs3RGt0v2kXfo/dPlY5xcAlpsY=;
 b=m6hbdVXkG9ZxucmX1mzVB7b51wIhJgICWRNbXc6Nua2Fnp4ot427x+gms/YlDuWRkX
 yaU2RVsCpReESSwy5hqRrpm+d8pA2B0wMuNGayihWd80QCF7mIz3r9ckVTPbSz6DptGj
 SQYUiNM9ccDu9u4LuMxZLDN5rF4txNH/IxJ2s/CzZc6MtsaQyAO4Pd1APC8tSQ6yG+0V
 Z5FurLuLgQJLqa4ZFTqQ6gCweFGTCiSH2jiR8wg1zHeMCpJVarrG3GiJ74DXLI+ovDu2
 IG9vkqdVnCICLoZqYqn6L+xGVqzsfcNlQS0+y8y5jXwu9f2VhIak7YxUc+luGG+lFfAd
 x68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KfGzKP/OLXFBdjiuVCs3RGt0v2kXfo/dPlY5xcAlpsY=;
 b=Dm424bQbfZkwsFV67KLigFyzdZHIPi8DjFO5M2gHt1Nump0zmfa1rBOwbShJ0OfDY8
 MTvoemU75WhngDrmjw2nZgq94NAR/GVoyqNSdjnEAkkChBEQ75oqw+6/2/jz4464/brU
 TUtcYEK1L5ijDs/xfNX8ZDaJRtuAWIX4bQn0Sw2yTn3X2bV0Y/rnHdjLlZM2Xcw//Wdg
 myZoKxCxtW5B/inY1SFTKbRGgiTFuJ3Bw99QXwX6J3XIWNfHhEggIm7oEeMETOAcrVdJ
 ad0W0Bh5veNLne9qTMiphMZVxAu0Ew7OzRPXCLnP3FHUIC59W9G62glXJ0P49K/G8HUI
 buWw==
X-Gm-Message-State: AHQUAuZQMGICZK7q5kCErGNyrLM+NB1dlwarLjkjXp8PzeDCrZr62n8c
 gxQT+Vnu2mRG0lc7wz7xqKvO6ggDH3+n9JIYsi8=
X-Google-Smtp-Source: AHgI3IaSYAQqg6JF8aKCdphdBJRlWfYUmGrsWTG0Xua+jMIdFKm0WEXRHRaYN6ZcBy7kK/DqmUfyhvikcf1YuomGo3c=
X-Received: by 2002:a9d:7645:: with SMTP id o5mr15927777otl.225.1551185677777; 
 Tue, 26 Feb 2019 04:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
 <20190226070742.30551-3-daniel.baluta@nxp.com>
In-Reply-To: <20190226070742.30551-3-daniel.baluta@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Feb 2019 09:54:27 -0300
Message-ID: <CAOMZO5AzUzyr_xixDcntoNt1KNSRih_2ZRFnzQHcg6pZmHsYig@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: imx8mq: Add SAI2 node
To: Daniel Baluta <daniel.baluta@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_045439_089670_07683823 
X-CRM114-Status: UNSURE (   9.02  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Aisheng Dong <aisheng.dong@nxp.com>, "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 4:08 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> SAI2 is part of AIPS-3 memory region and it's the DAI through
> which the wm8524 codec gets its data.

Please do not mention wm8524 in a SoC dtsi file commit message.

It is the imx8mq-evk board that uses this codec and this information
is not SoC related.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
