Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C84C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:47:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A7221929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fiJ41H7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A7221929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ijfXBrIi/Tjixqp056nRz24zMVYlEIL3PWfMGOxDlUw=; b=fiJ41H7fVlT2lC
	vUCMTaxStEO1St8BCnHV0XN9GbH3Wa5lEhcUeKrC5QVuQ4OxUp3WFmSdoZCmpltqnt3+WAZGdM7K0
	9NxtUpdWYbWcmFc44X7uMV3mLKZaEKn2YYDaBwXzS8vxaplIZOYMuxmAVC3MnCvKyABLfeu1iWRZ2
	9vjILuY67aC5doHk99kjkVo96xg6qtKBwrWCnfLgeKJPdx6+lWdUWmWb2JNqBaWZN4ipSOtbsaGM5
	30VAZuBtGFtrgVIDrSAwbpimp+fu9AZtDXj/QcxpUZwFeB9/v6BXXJivqBjZKBRmTGns4WfuxzJIe
	hPnXddEmV6KUOPeRbI6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudpK-0002Ou-JY; Fri, 15 Feb 2019 13:46:50 +0000
Received: from mail-qt1-f169.google.com ([209.85.160.169])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudpH-0002Od-GO
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:46:48 +0000
Received: by mail-qt1-f169.google.com with SMTP id 2so10883799qtb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bX4Sk1AwH1cFWs7K2tztNEznnQPLqcgS625h2LSYH0M=;
 b=LczZlHMJE3rDzBBgu1cQe5Dvw++itc+LnswhpEGPAgKadT6DcPtyPfP9LwWPtLNMr9
 KfhjmVVSU4Hjn5hHnuAlAieD2r3u1U7NfirAycEsoqiSIiatzvF7vtuf08ZuycU9RRC0
 ra2CW4p9j1eurDSJTCKsxbu892LKLObJALk9jOwo2hglxTFzMf5buElhuvkyo9DSb+q7
 Cldk9ztEOJTwxqjyo/DeArns6Y5XxAyECo0hNH0hHeUGWWV+VJlsH5wlJTaR8Eko8LCl
 JyitlOfXRe6D+NDcS8iU93p2jnpQEYSrPf7frrZqWtQOzgxMgQame3W1jVPxz31qy3W5
 3CWw==
X-Gm-Message-State: AHQUAuZeA5gjUbWbdMFYz1dZ354g8nOtLA+oOO8HuiDTyEogwG1dh2eG
 IB2fu+9Cb7FgTwSTkSZZwnCc7+zihEzpBe8Z6+FSsA==
X-Google-Smtp-Source: AHgI3IY9HgqbAwT2YX2MHj3irP4lxdUaSFFIrLkzRfSC1H2qE06SpvrWQI7uvPeeOQcisNTMN4xXhf6KC0THmTE1/X0=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr7676457qta.152.1550238406628; 
 Fri, 15 Feb 2019 05:46:46 -0800 (PST)
MIME-Version: 1.0
References: <917791d1-d789-897c-460d-89883d46ff60@st.com>
In-Reply-To: <917791d1-d789-897c-460d-89883d46ff60@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 14:46:30 +0100
Message-ID: <CAK8P3a12W2z3vd7bzMdkKuC9Hx6MzObLFnBAGXwRdWCWTLra+Q@mail.gmail.com>
Subject: Re: [GIT PULL] STM32 DT changes for v5.1 #1
To: Alexandre Torgue <alexandre.torgue@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_054647_546260_C7305C51 
X-CRM114-Status: UNSURE (   7.03  )
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
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@baylibre.com>,
 arm-soc <arm@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 3:28 PM Alexandre Torgue <alexandre.torgue@st.com> wrote:
> Highlights:
> ----------
>
> MPU part:
>   -Enable Digital Thermal Sensor (dts) on stm32mp157c-ed1 (and so ev1).
>
> MCU part:
>   -Add SPI support on stm32f429 SOC (4 SPIs instances).
>

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
