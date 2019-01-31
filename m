Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9F5C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:47:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C3C21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tHG001/A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUOrc1Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C3C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F5Vr4/aQ3EdumTKUVkY1sLFPTf0QrxBy6PTmykfVIeM=; b=tHG001/AfSz+8M
	yIp9gGzQ6v43EqZxmHekLFl2Z3TxTQcYhvZfdIUwVmE3U/CrbwpuHdRanytLcmaKENJezeDXCDuPF
	LP0F5kdBRZZcILCjoUmuzI/nuE6bhncgYeB+5vbxF1q3Cn3QHDyFzuy2aEkL6JgTvCF0Jn+W0+c3M
	Svt7fFIZ9vcIESdd5L8gp3jbbt9Xvtqu7vHe4JhBut88eP/4HUJXWV9pKY0lej+J0WU+aefjqL/ld
	nbr9sUw2GMsqPr5l2IUwVzxOK8pjutfY6SYws1ICak2/ZmiEBMUGVeR/x9JAOnpE0fwLcKGB6BIPm
	WyIkAU5Egic6jXi9Z6fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpKB7-00021Z-HL; Thu, 31 Jan 2019 21:47:21 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpKB4-00020t-8Z
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 21:47:19 +0000
Received: by mail-ot1-x343.google.com with SMTP id g16so4186105otg.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kL3+GDISpQZ58uwge/BkM8/zP44zX0DhbSWXoUUF9SA=;
 b=jUOrc1MrRT08E0dwyXHhA71uDuyjdfXWS8+4yFHWmkt98ybVJw5P93J3DfbNY2Yevf
 kdTPtsvL+JipSQttZiUqLjJ/BfEIKmjpt+kcJU1o7Tliy8pctozRxX5ZikqbK5Fg2Fwj
 f511KUNPUrKZh2BYIipzDUX2Em72uqgB2s3IoY9lInG74TlmAMGGvy+YhQlT5kmvAeHo
 yjJ0uR5/3dlwxyl22RnFEw0m1t5TublZpVEBAHKNM3NqXNsX1D5QfDkH1xQjwEqc1cWG
 PVePcxpGJgZa2/fU96ptXPaL/hRLH4GeV7TwX/RTN9jGqasx9XuAmdG3JwqQS4RVZOM5
 klmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kL3+GDISpQZ58uwge/BkM8/zP44zX0DhbSWXoUUF9SA=;
 b=k3TcdxdvgVaR5+vGPX09K09QCY8LtpPQL+CMdTiVBWM6R9n4gAvfEJvM9TZGOmQBcw
 J0MhLpLxxqC9DoCWVod42KjldRoOexWWzzwwOwWR8IKmW402MIj0V7G1rZqry3C978Kv
 NP+HNmQjQFqoNr3donaWL3fWzUsP778yTPbmlE2Mm5IgBU7dh1c9HEv/Rka50YFns/Um
 OQMZzJLrs5iInB/oYPxCvtaCEWtLp2hdZAa1LjQbg/RmXh9SH6WZ0vFVroPmAc5HcYNd
 5Cp0KDsTuG0R/YsvASLPvbVbAbQXLnoT6r982iLHBmIX1kDMqSehsY2a0l0iltrnoIbi
 rieA==
X-Gm-Message-State: AJcUukdTlOVSLnNy7gjaGnJOaKVyEumw5DOVDcz4dNzU0UwQRZ+KjeiE
 tC4Hu2SMirEqLESdaRYBtvJAlUobqfeU0n5WjwQ=
X-Google-Smtp-Source: ALg8bN7TI3U5L3SG3mgwt87r70JQeWsyKD1APwwwVJiKY7H8kxex1+kIuc/86beJ7A3jlSVWHs0EKVpZrhNHSP6KgEs=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr28414254otq.255.1548971236353; 
 Thu, 31 Jan 2019 13:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20190131204524.1218-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190131204524.1218-1-andrew.smirnov@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 31 Jan 2019 19:47:06 -0200
Message-ID: <CAOMZO5Dgz1TS_KgCR5ikdYsM=VAS3iJ-TDGuythzxvGULuaC-g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Make GPC default interrupt parent
To: Andrey Smirnov <andrew.smirnov@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_134718_327347_5FC26784 
X-CRM114-Status: UNSURE (   8.08  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrey

On Thu, Jan 31, 2019 at 7:11 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Now that the GPCv2 driver supports i.MX8MQ, make GPC default interrupt
> parent.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Lucas has already submitted this same change and another one that
selects the GPC driver as part of a series.

My feedback was to send the GPC selection patch first in order to
avoid boot hang when people try to boot without the GPC driver
selected.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
