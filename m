Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E62C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:37:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632012173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NniVLqu8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMMRqSk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632012173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GwzobruKriCkPtu0ZqpjcygrHM7qfx2Q8fPFI8HYlxY=; b=NniVLqu8Q6+mYz
	TgMI5101h+6vIo4dNv3wkMbhoHFdTMPeifJoYs3MQKLc1z7/9QCn/+Fe40vbpgW0lcPM9v6rpK3FF
	2fXhTBon/eRGmDpfVpNbpK1NlJin8LFe0KKgjqhgyiEwPqifXwIbFiNwSOwfQFZEvICE9qlIHI0Nb
	1/XIgOGM7T9TvFj3LStGIxJXvQKVN5F1VpyvSchVM5vSf5tT7OfqODtNxz9o8GuICNmck6jHRMyUW
	SxmeHQnT6bEQx2WIBow9n1TViSmxZla6E1LO46elX62GOb+y6ugeb22ihuMH6nlABMhVJeag+VEri
	2kEMYEPgnTsjhVdKzW8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycvP-000717-Ct; Tue, 26 Feb 2019 13:37:35 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycvM-00070I-1c
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 13:37:33 +0000
Received: by mail-oi1-x242.google.com with SMTP id z14so10355532oid.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 05:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JSjDv4hcZl88gGGx2mHdRSPb6viE4KjMCMgatmCI9xE=;
 b=fMMRqSk/AjRdW1IzGTCaSeXiaEvT/z+oxDIeEb3SWbtdlVQvXoFHQYqLGPyRD2VI5B
 eqxgTkngbFipQJkrmsIfvink6ss6TS1jCWVd/V9abbs13mqFd4aL/uwfwEoQLu9vf/RI
 W/dMCI6Ud1A3wygCFvy6vwW+bld0nPjZxHv+68lyMCTszsdw5pTZ+7lSkDFTN18DBMOK
 DpTtRLbVPg46FBpKyYWOAXWZZXUmE4zR/ECoB7lcOwSwap/9qe/Ps/BpU1Rf4oHdIXQu
 XDzbKzlzYvqW5dEwwRpo7pxZhiEo54cU+imxUSfLg8OX/Pe0nNcgr8yQEZ2i84O//rlX
 yDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JSjDv4hcZl88gGGx2mHdRSPb6viE4KjMCMgatmCI9xE=;
 b=DDLcEVEoP7WYanF/eA5IYNgTYk/bXiXHv6tEBsclbdaf/PnhNd6bnfwxlHpyM5DFvc
 QkideHM4S3/EDLAxW3SXEwMYjC145Xqds8dEaUSj1ElHdytuKjhw4RG2lH71OmVKSmT5
 BKZGPCTpej4WU4XMjDRFCFEYQet1NjvH+Fh8QC+9rZGge9yYJMwc/uz4pSHrePW9NSoi
 AlC8LZ5RsdkSWte+aNZ4lRotVypRyIF1kgD/GqHuTMmPesmcCXbuYnEPMEPSL3FEfEAx
 pbVDh9dcwiuRROWOmG7ibRBqsXeGe5CHWRlSr2IuWZ6bMu4H6CV/+bhTX2sCFET71uia
 WUgA==
X-Gm-Message-State: AHQUAuYaBI1+IKK7TLUsTGKRevFcCowmZGVdeGrq+xZzc1JFsSLyB5IN
 0Wd99kQR6dOcOV92qA9TM0pZTIOGStZNd9xK+hY=
X-Google-Smtp-Source: AHgI3IYZtWhaAPcNNlBKLwWqNkgeh9ehmNzwojlKcMhTQUqGGLRV+capIRPFlglTeXPXaG8JDpsQ+7gP49Ng0axhOps=
X-Received: by 2002:aca:b5c1:: with SMTP id e184mr2359488oif.75.1551188249238; 
 Tue, 26 Feb 2019 05:37:29 -0800 (PST)
MIME-Version: 1.0
References: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Feb 2019 10:37:18 -0300
Message-ID: <CAOMZO5AmRAhxSw2KB-LBY68a+DvVSKPQ1ecAf_YPhQhBAdJ1UQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
To: Abel Vesa <abel.vesa@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_053732_109533_0338912A 
X-CRM114-Status: UNSURE (   8.61  )
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
Cc: Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>, Abel Vesa <abelvesa@linux.com>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Chris Spencer <spencercw@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 7:53 AM Abel Vesa <abel.vesa@nxp.com> wrote:

> +       magic = readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
> +       if (magic == IMX8MQ_SW_MAGIC_B1)
> +               rev = REV_B1;

Don't you mean rev == REV_B1; ?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
