Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379E1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:10:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0193C20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ixy7bqk8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENmfwGsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0193C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a5NFOyGNa00BX4WWoRBsM+0aSsAEK0vT2HDoyV9fYiw=; b=ixy7bqk8DSlmVA
	2qU5s2sgT3SPL+w9ZufmFCFouDzlO/5BF9P4Zz4U5+7Cti6++XjQPeiFflDgnkFetkoaP9qGXtZtR
	HFPg8uUMbEskYGiJTresYp8ovaqRu9d3wDAywCs04gQGkLIsRkP59o+w5LxnKfnThLWhauLi9oeo6
	lvmXxvsxGwZNI3lBhAETc/0EQ8/8RtOfOWji8nhrNaOel4zGRupWZksLYEZkRyODetLLOOyxDAymr
	DQN3M7HVI6HcItVG5mkFWB3XFtGLIK0arK2C6cxX9GgZGI2q+ELwV0lmq42X/C50INXI8XMXuHR/l
	Tx/xnplwQLvEjHs9Tz3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcwaB-0007RW-NC; Fri, 28 Dec 2018 18:10:03 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcwa7-0007M2-8D
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 18:10:00 +0000
Received: by mail-ot1-x342.google.com with SMTP id n8so19239626otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 10:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pcP8nay6+BqK4kz8+c0D7eGBAh67Q6vhSfU29ALBgEo=;
 b=ENmfwGsyH02BbKh7IKfwam0ZkkSz8LlneK0HheRFjErnrW7qhw2ZIDwRFyZOtMI0bk
 eF/41HhpKXF8QTFxNyWyg2YjB2KNS5nSwMmsgRuHQ2KWhXc5FXwKUSctv+yl/CPX9IhA
 zcyEeEGlPs0gspxwNg3iRNNOvorucOZIxMOqe2lc4GYesK6rF7jHuH+HG6gAkwR/LbRX
 yciSJX7rhUBDI203r44NgM/EJmvN1be407OM81LHa23BTdjBGzRv8rTbQ4iSz/JK/xmQ
 NawxShO/+GWSkp5guiNOdlILF3QA/jsCcqLg2eP6tHK6dW1eDPBMK7H2VpdkTXjGB2MF
 p6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pcP8nay6+BqK4kz8+c0D7eGBAh67Q6vhSfU29ALBgEo=;
 b=lxVa/j1MczBFOFTVWsjWpuTWe9StD2Sm02/3yNb/rxgyPAQdX87spyMis0a4M49G5F
 Pt4xTptOUmfp4PPoA9b1+p374jz1OuCZWUolkmQPs/w3pyrvOnHbu5E3j+6IlvlxFTpJ
 I8Xz8UfNXdqRI8uhwj0VrlUbrrd1wprsaX2kg+Alu9YbzkQJcWanw7LLNdvI1JQvlRdi
 IV+IvXY4zVaxcipgdsY6SW2bTSjM0WxilOoN/nINkgnlE36uYodgaEnrftC+TxfllVbk
 G9p075+yqS2EbjeDiWTk+pJEDTidZfS8U63m1AbgaRl2VmsenwjkPkBe8hve9MXYDagv
 PIrQ==
X-Gm-Message-State: AJcUukci9xbwEgYEcUnZjBnJz2wdY3BUpyCxIcVZEpsU4FTT0KD0jJnT
 Z3uCUKvrcM3GOdIJx5Ui4UNSvU3+h/+cgqWLsSQYRDUJ
X-Google-Smtp-Source: ALg8bN6X//ozrMVa84focVztNuWnrZUiq8k2muTpP2bmHIDj0LvB2CvLWmcKEt5on2mf00B8u+j6km4KNlNt2K1o4zs=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr20064670otj.228.1546020587086; 
 Fri, 28 Dec 2018 10:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20181228033323.32308-1-haibo.chen@nxp.com>
In-Reply-To: <20181228033323.32308-1-haibo.chen@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Dec 2018 16:09:53 -0200
Message-ID: <CAOMZO5BeUA2YwzH2Vme4xmpwiciX5xRmCqxA_-=VAV7zPmeQdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx6ull
 compatible string
To: BOUGH CHEN <haibo.chen@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_100959_293516_09DB69ED 
X-CRM114-Status: UNSURE (   6.90  )
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
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bough,

On Fri, Dec 28, 2018 at 1:26 AM BOUGH CHEN <haibo.chen@nxp.com> wrote:
>
> Add imx6ull compatible string

Please explain the reason, like you did in the other commit log that
explains the need for handling erratum ERR010450 on i.MX6ULL.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
