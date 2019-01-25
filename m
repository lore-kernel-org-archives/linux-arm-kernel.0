Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939DFC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:45:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C55D218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jKdutZks";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5y5pdmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C55D218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9rQ35fFyykOPdykic7pLUuMiA+An4no9Pim6h/yTNHg=; b=jKdutZksbH737w
	V6dDDLrYFqo1xqUwsEYS1GPpXedU5zMl+7hQuiJd7L7UuNpq9GVKFk/Bd6Mbp4kDf+NqwiKYDNnlP
	GzEgmCVxXADpNdSVsGGM2sEr7QB6ZTa+sJwUnr8Pn8UyhbWitp85NEyx5h1uJShDdfSffItgPrWCH
	ZQMR0MWiVdJuBaH0Q8BdxRe/FT31txSmI1r1MgU/73VbqxMY1Swa6e6yUiTvlYrAD6joRbtn8nS1Y
	HsoObhPfx/MyVBxRfnku/zArO8PQzzTRTDpqBGVO9Xb3DfSuuwvvdUWZNVHOR7PJqSDI7C8lipeXu
	7i/f9HQoZMAbi2v4MFlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn4bk-00020i-C1; Fri, 25 Jan 2019 16:45:32 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn4bh-00020J-Fi
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 16:45:30 +0000
Received: by mail-oi1-x243.google.com with SMTP id x202so8087059oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 08:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u4sWGPMdUKMWcq1NKKfpcNuswVfomYyZc++lAV7Dnvo=;
 b=G5y5pdmo6QABwSxcxffQ4oJirxMtQNzkc37VMFoC+UZOoA67WLwF+2NFA4Lm4AXhLy
 5MXp4YLYDBKnQqqotN2mut1NkTI7E/JORF6VqoRNiEDibZ/OgJtPJe85bs9AiS/GRr2U
 F/BVIgiMFuB6XcNJ0ggL8MkFFmiK/Z1SnlWewp2VdgmXmsdW55ZuXQXNuDR3fSXhgBhy
 JuPDMgatm6MLzG3mFUCeVLxtv/4noDG+7qN0B7ImIDjIZeSph94VmbJBSdPhhgvLPXTN
 VzthO/KoV6dHs20QV4GRLIWHJIdc14/g7em0QVNp9f6I/70vL28PGdeZBWuW4X/GeaFy
 dXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u4sWGPMdUKMWcq1NKKfpcNuswVfomYyZc++lAV7Dnvo=;
 b=WsjZg2wF4gyPiycUsw9cfI44MS+/VzxOmpzrO3NXhabl/WxZ0ycJMZs22CQuk74Wbc
 85Vibtm0UJ9afiIITx8kj7yGa5FZp6skgOx8tE+/U6d1nDjm4wClV4YhIRRx6PZASnqr
 gI4NWdF7nYEIFASzHj8tV5R8k7pxCQ38rEwD7MWITIPBA7fcZYp1y3tBjZYFGI4LRXEV
 tENbPO9sFPyPZpqEXg9gkbXvODvI23Fev4OPcxz5u/iFva1gParVdKL8pS+VelaxmqqS
 +mkUgVMuy7PfeVesVidQJnz1+juv8OXX51/7JDMeyH8GFukYyTh5AW26WPkmqcEpSgFP
 s5bg==
X-Gm-Message-State: AJcUukcAyjPe++F6cvZSIAYYOxWcFFUJtJzXaf4p9hSKXPoSEqNTJ2SN
 2ohRzPkRmMdWJQyc03CqBxx4uBUIG/qPOscKinw=
X-Google-Smtp-Source: ALg8bN4Z+P/OvnN+LDOqW0JPUA+T/xu5ulPCby3IDuJgJWyRRugX9Q4aqVw3Qxyku5+ixjK2dmAmwU6cFn2IZ6qg9Gc=
X-Received: by 2002:a05:6808:296:: with SMTP id
 z22mr1847791oic.67.1548434728245; 
 Fri, 25 Jan 2019 08:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20190125162034.12984-1-l.stach@pengutronix.de>
 <20190125162034.12984-2-l.stach@pengutronix.de>
In-Reply-To: <20190125162034.12984-2-l.stach@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Jan 2019 14:45:17 -0200
Message-ID: <CAOMZO5AEEyFLA5N8creQYG1qh=P6g0cACcmfNO5qfxuWzXWDTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: imx8mq: select GPCv2 irqchip driver
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_084529_525053_DC9DC39C 
X-CRM114-Status: UNSURE (   8.20  )
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
Cc: patchwork-lst@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 2:20 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> The system is unable to boot without this driver being present,
> as most of the peripherals are connected to this IRQ controller.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Putting this one as the first patch in this series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
