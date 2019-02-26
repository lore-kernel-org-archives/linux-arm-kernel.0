Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CAEC10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:30:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65962173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p84PJ2Hf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTg5BBmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65962173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jk0UVebKKF2sg2kD2xeTsfIrkYtNUASjG/qYCxb/l8c=; b=p84PJ2Hf3nICAG
	KlkiAdWBERQ9Yc9jTCH70dL+pGM2gyDQCXYbJS3Ywcw4CADHyusMdGM+XtTmG3edgTPW4p7V903Tt
	CTw09lmvqKT4WqRj9MpOQzZI1b5ulBpFuPW3fR93aD/VM5XPyA5LmqAb0KocedZRBRKcV+Qc2ygVs
	gN+5ywwdj+NAgDQO0JhCHIWPzUtg+73hSgn8hfBPBRUPU1JbRxigIqq0Tnn54v6gLYhcog+GC0GmF
	PHYBhUvsNiNJIltWBpm2Bz5IzunlL7iV1joMfMvqXib0sFk7KnZg+REjDHHulpV2PpBz8SWzTt9Pz
	ATRYQldIGDkx3vnmUJIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycoE-0004O1-9c; Tue, 26 Feb 2019 13:30:10 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycoA-0003g3-5z
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 13:30:07 +0000
Received: by mail-ed1-x541.google.com with SMTP id c55so10747485edb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 05:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D9OYMB9rvVsnbcid+V0NjauMAvdeRdz8F6EV7K+P+NQ=;
 b=tTg5BBmJVM0om9Jdg9y62DNwqQR3Ad0w/npEcYgf10ImcluMyPr9Zr4ZtShQpi5Q6U
 cWfFGPv7REDozad352+yl92KblUy4mY6ZTMfhXgkpcZcIKC14eXF159PtE5eb8tX7L+x
 oULTRhlXoEReSCth9E0PgBZWwgmwBDqgWAYQ8+4d5GHjzaWldQjnh5lXcnBoiNWD/DAB
 CJkrVT21zTbtC8uhcjC9zbFPlmW/Q2Mgs87Xki4xvdJ1X0AAHo9q47wWDg8aW4/hZ5ZA
 GuAzhyR4mnkxKODSmA1gqpLfRRasVwDhoJq/mbFQ3p9Lkx6sxRBVbXq/zH4LzI0xYGVb
 0EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D9OYMB9rvVsnbcid+V0NjauMAvdeRdz8F6EV7K+P+NQ=;
 b=hQUZuZ7VVXWzXm+KAK5oNc+y4dHU+zYplKEAhSiZemilSJoP2rgt0bWgr53il2xg6O
 FBsB4xOmedRTfWBzzLFZeeiMvA0ipe1Bw0LGBEoR/WryFZiJhA/lVwiBY/F2D8F7HWzM
 k/5hXpSalfbRPSi6ZV4F45TgVz35RDXO2cPLd+tEPCO5QN2bhr67hyFcMmtK+NWKdQAJ
 F6GcI5StGCv33OoZSwE4EbtkkC0D/igA3RseGaq3vkUcnAc43uRDvzDdHBAhKxRSSOoS
 fOCYgABuMZSXd1MLmiHnnf2Zaexf51ZhJC2091mkYqXyuCI3Dj++kE9hGxPKeBqoo3ZI
 2vKQ==
X-Gm-Message-State: AHQUAuZKN/KF8mWuhNrYGbQkzkxyolK+ZnveOmU6TwPFycFwoMMralK2
 k2xQrnrAvmwreUabnocSiYSeW3wmFvomGTSane8=
X-Google-Smtp-Source: AHgI3IYUhMu6rvuFknbRLRY9YL5YXeczfwmmUVCUpAL/qrPiaSckmU/2x9pW2p2scEZiSnPUBUG0vlUMEjWSgxYy+Gw=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr6120033edc.67.1551187804388; 
 Tue, 26 Feb 2019 05:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
 <CAOMZO5CpefU56xLaOUq0GRwWP9kcMPyZ2PWM38C9FuU-3k1MJA@mail.gmail.com>
 <CAEnQRZBRG4d59y3kteMaZMjfHWZ=FYL4dP+uRcthvXxqtmH7cw@mail.gmail.com>
 <CAOMZO5DTR8aLphJBCqR=oLOz5aZXuNfPVEgUk6K_YOdVD0UK+A@mail.gmail.com>
In-Reply-To: <CAOMZO5DTR8aLphJBCqR=oLOz5aZXuNfPVEgUk6K_YOdVD0UK+A@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 26 Feb 2019 15:29:52 +0200
Message-ID: <CAEnQRZDk=eTOmaAK8YoHy63PomrpfUDJ59mL5ipqeJx8v5bRDQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Enable wm8524 on i.MX8MQ
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_053006_252457_041BF757 
X-CRM114-Status: GOOD (  11.36  )
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
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "angus@akkea.ca" <angus@akkea.ca>,
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

On Tue, Feb 26, 2019 at 3:10 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 10:05 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> > I get your point here. But for the moment it is identical with
> > "fsl,imx7d-sdma" so there is no need to add it now!
> >
> > See the discussion here, and comment from Lucas:
> >
> > https://lkml.org/lkml/2019/1/28/194
>
> Lucas' suggestion was not change the sdma driver code and I also agree with it.
>
> The SoC dts should still use:
>
> compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";

Ok, makes sense. Will fix in next version.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
