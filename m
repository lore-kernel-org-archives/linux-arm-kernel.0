Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F688C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:44:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E983208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YA3xqRgR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="uzwrmUBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E983208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:In-Reply-To:
	References:MIME-Version:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rsyRSC9iidJDYZjBMh9F/kl+iT0+q4BCe/MWZGRR4xQ=; b=YA3xqRgRvXWJ4R
	ngxoIA9ZyCgDv98FJuFePHYy44mQNOGhIWbivE79T6iGXAyV04iqzxUMkWdDZfYiH+mrOaNwGgDtP
	61uXbDoyK6Ous41bPjCIpuYiGWttF92R0p6Le0WTaSTA5nffFdlgSvSkChZhJWdgjW88Dx75d3lpV
	SCjqH5wyrh63jspPf5pQjnPdZHzsv6W3vPYW1KiyZRjfjkUt7aXxUeyazIU7OnuaDFUl3011u0Zxh
	ukvsEyvc8U+zOf1mO1Aqbyr6n/2g8Qhze7LlZmPwJPWQdRVBLBSQ3d2L+I9ltfiQf24rVWzLGLv2/
	S1ILmXj0UZ3gAlBT2T6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUr9C-0001zq-MP; Thu, 06 Dec 2018 10:44:46 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUr99-0001zL-H1
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:44:45 +0000
Received: by mail-ot1-x343.google.com with SMTP id i20so9640otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
 h=from:mime-version:references:in-reply-to:date:message-id:subject:to
 :cc; bh=1wd87rhCZLQDwfoBNuXmrBkrnssjkjrBp2BHPROLvvI=;
 b=uzwrmUBlbS6XObOHAXQfe2ov3Rjl9+ejyv4Nn87PZk5++1AfhjHA2wrZ08HoJX/gfe
 KiD15rmtxQUPtMvAXmQ9RuVI1dixpD71wIrf2dVTwtcBB8qe4GPc0ovFA64ib7zESqup
 2OynjE4ppiAF67QUvmV6yjqF22lpM1uJr+cxEUj4aKFSDg+Tsx9gv48V6F2L4LblUTSP
 Fj2ZGu0g/r4xNxPojCvBTeXGNpoFe8xmO2OuxDfxrKMTq3nYtVJ7jhhClBtKf/GphBsY
 8xxhtpIvfuFpIQ107sl6gKSJU+WruNsXHmYB8OBGDqSDYx8bcg6Zil7y3rSDII5GuLWT
 3DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:mime-version:references:in-reply-to:date
 :message-id:subject:to:cc;
 bh=1wd87rhCZLQDwfoBNuXmrBkrnssjkjrBp2BHPROLvvI=;
 b=Z8Gg3kaXedqUqXHNXE6j+3lk2LlecB2IvzG4rxt5o1SX9gOtRCsfhHi6+ilDELcUo+
 HDDZ+ePCvaTvn2rf4Ka7qSqfKtoNhcsgb9Du/3/QSt6d5O9J0Q1/m6U/yXPoD4ItA1Xs
 Mp3G0oeQJU1TO82T+PiD0cdcB4RsVstpmO5mox02Q/l60TDxBPYtdd/TeDNFVu+Dw1z1
 p1FBOK+/y/rhzv2mXwXwv5Jfmb5EL5RE/SQuCi44ePrXYJFPQwEArifxJlETti+pFPAj
 98kXUoPTgkVY+o0h1TqUc+haUEUSRTDcA9DkgcGZPKQPkBQbT+h0Z/OWGEP21tqh9Po0
 8AAw==
X-Gm-Message-State: AA+aEWawPU5YFNNp+2bf6T4IQlW32oHCasg6bthb9QkEbhSz3SuLh8+i
 vxCvTk7vwbSw36PTzO0fJoSFuk93z8cCpw==
X-Google-Smtp-Source: AFSGD/V2xIyKon8G86I+G2TFagY7j2UiDYm7saEV/YkMiJ7MppwYLxizt5KPlYSvIxKwKbF7F7apRw==
X-Received: by 2002:a9d:7097:: with SMTP id l23mr16909986otj.49.1544093071078; 
 Thu, 06 Dec 2018 02:44:31 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com.
 [209.85.210.45])
 by smtp.gmail.com with ESMTPSA id z7sm9810427otm.63.2018.12.06.02.44.29
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 02:44:29 -0800 (PST)
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-ot1-f45.google.com with SMTP id w25so21539508otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:44:29 -0800 (PST)
X-Received: by 2002:a9d:12f1:: with SMTP id g104mr17006676otg.22.1544093069163; 
 Thu, 06 Dec 2018 02:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20181206100905.15053-1-otavio@ossystems.com.br>
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
Date: Thu, 6 Dec 2018 08:44:16 -0200
X-Gmail-Original-Message-ID: <CAP9ODKoG-XRSOekKJWkD3Wg_dPsS2baRzPhuuJmmoT7-omBOtA@mail.gmail.com>
Message-ID: <CAP9ODKoG-XRSOekKJWkD3Wg_dPsS2baRzPhuuJmmoT7-omBOtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Improvements for i.MX7D PICO SoM and its baseboards
To: Otavio Salvador <otavio@ossystems.com.br>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_024443_616989_F03E0358 
X-CRM114-Status: GOOD (  11.09  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Kernel development list <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 8:09 AM Otavio Salvador <otavio@ossystems.com.br> wrote:
>
> This patchset rework the imx7d-pico SoM, its Pi baseboard
> and add the Hobbit baseboard support as well.
>
> Changes in v2:
> - replace fsl,uart-has-rtscts with uart-has-rtscts
>
> Fabio Estevam (8):
>   ARM: dts: imx7d-pico: Do not harcode the memory size
>   ARM: dts: imx7d-pico: Switch to SPDX identifier
>   ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi

I did the rebase; one thing worth mentioning is that I have "ARM: dts:
imx7d-pico: Describe the Wifi clock" which is in your fixes tree.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
