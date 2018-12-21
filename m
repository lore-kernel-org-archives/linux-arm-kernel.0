Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:24:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F13218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IuTS25eK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6e9S+D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F13218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wuG+B4pMcnhTZep+Nkyc9EZ8II5nv6UfsqI1/MwMYiI=; b=IuTS25eK9AjxmH
	21GUE8iaXGrnbN7b9qr122LToGYZUc/fpgkcKB0kCodiNIebZg2OVJiMuqh7Z2NKf56kzFodFkSLi
	5HLeiOCN42aE8k04kjxlganPhz5KL4I83MI0EDyQJ2bsxKRsoB20yCBF5o9woPNdhOYLTHvmD/0Ui
	MAOv6wfU6K3gIq/GTvJKXfuonjqy6YN42m+IGirZdPOIYnDYoRW9vivjn+IfwP10VZAyqpHezcm9i
	KyHVs5FgKhLmdlSHaFLInecJvRp0EJ2zBGPML0R49iLObk5Slpd++3qov8O7llBtywFaLzl0s+Cnd
	gvGb7LiV4Rrzj6iBcb9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaHyS-0007WU-FZ; Fri, 21 Dec 2018 10:24:08 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaHyP-0007Vk-QF
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:24:07 +0000
Received: by mail-lj1-x241.google.com with SMTP id u89-v6so4266375lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wHHpU32udS8RR4ikuuLYyOS2eHkaZAGtPJAJ066C9fI=;
 b=j6e9S+D18wAMrRRw3hFm0Gf15dGuqnItsvTMGfanvhbtAeaIiLtjDMCqht9wzC/9Oq
 SErPCkTFx1X0hFvJ5DGtvwziLfPpAh4Vr0ojS5Af0iJESLFRr3/qGFJb2m5xy6jRZyQR
 iBd2M7KVSwXSVyMPbOh/J1VfWnl+bnuFWwUhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wHHpU32udS8RR4ikuuLYyOS2eHkaZAGtPJAJ066C9fI=;
 b=dvy05mi7zot0X2mVcSuAp6le4sOa8wjRuSzF/jTrVge6Se4nX/b1sHW4qjS3/Zm1JV
 rxUm8IUu9h8KnaX4sskF7O3qQPuN2GKDepDPRRXxc0zYlNpWO34LA+wy5lAt57Mqp7Ma
 rPpiorA3//ngetsdr/sokLMAIU26Cw8KWrD7gpDNl5M78HhfXZL54YPsnWzLstIph99d
 FX2yXcpsYaaHGbJCBFRDeEDzdWQ0BoO3kzN7JYPM+kf3K9OGxjL38fgt+NMdyJoSQB51
 9W4Pm/i2jPV3hJId7O8/kJGmQQMHoZN7hFGxKLIjojeZPYg26KNNcSwkx5D0AJSp6qob
 8IEw==
X-Gm-Message-State: AJcUukem11ZYvp+Q3aFJgolpw5mwOVxc18nO8Y8kQzIUWI4GZmGtyKvm
 rRlEvHf6ua6C9FdpyXF4p9I3WSKzCOjDqji28X2yAg==
X-Google-Smtp-Source: ALg8bN50tovSeIx3KsBrj4hrK81qcEiJePR8LX0Dp4bwMrSxQx59hP6Nh1ZwYZnoWxd4hor8fVzblOJOb8e+zU5SsEE=
X-Received: by 2002:a2e:29d7:: with SMTP id
 p84-v6mr1213741ljp.12.1545387833417; 
 Fri, 21 Dec 2018 02:23:53 -0800 (PST)
MIME-Version: 1.0
References: <1545060770-19191-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545060770-19191-1-git-send-email-aisheng.dong@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 11:23:41 +0100
Message-ID: <CACRpkdbAy=N=L7HJPjGaeWinJHQC9JFc3UNdC5Rn-dSb30=d5A@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] pinctrl: imx8qxp: break the dependency on
 SOC_IMX8QXP
To: Aisheng Dong <aisheng.dong@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_022405_867327_2EF675F8 
X-CRM114-Status: GOOD (  10.86  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 4:38 PM Aisheng Dong <aisheng.dong@nxp.com> wrote:

> ARM64 SoC does not encourage people to add more finegrained SoC
> config options rather than a single ARCH_<family> in arch Kconfig.
> So this patch aims to break the dependency on SOC_IMX8QXP.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v1->v2:
>  * do not mention the deletion of SOC_IMX8QXP as it's still not
>    hit mainline

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
