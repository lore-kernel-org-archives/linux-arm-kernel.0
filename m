Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFB7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:24:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A9D218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FRfh9xvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A9D218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nyKimjn/r5r1xwued66zfxT2MGv1ltQiNnJUbRq7vGY=; b=FRfh9xvv+dn4OL
	EWkBkJht8GBYnnblrR3xpnEKqoAu+6EngS2VDMCmBMnPHEhJdYI1TI/xDtsfNI2L60U4qne8YWrQl
	KFTN6fHOoF54sLSOfnrfwWupCBfLp/6ENGNX/T+BszTAVbByOZz/7FgLDx0VsLZfjwQ+Q2ecea8hQ
	J+XqA/Yw/QN6xVgHhp9QXstSKacqOB5K9W9L20peyGQbMKsjp8nNHtoi7dQ4FT0zCYFXZxCr/27Tj
	jmY4EZECNPtQMf/qJVGE29FK6aJyYSSwo0wjaWjAb/JTLePbPVU3Gt4dCPE1F8LDsDI1nwQYbEFpd
	Q5k6NaBhgfxMvIpDVGiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugHd-0007Ym-R7; Fri, 15 Feb 2019 16:24:13 +0000
Received: from mail-qk1-f171.google.com ([209.85.222.171])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugHa-0007YI-Rj
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:24:12 +0000
Received: by mail-qk1-f171.google.com with SMTP id x6so6015949qki.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ItxivupXn6uqNh7NNXXjMgjahAdAnofeEMeE25VbkXk=;
 b=NCMPIYPyCCAPBsF0+0PXR9LwqnkqJPNAOjb89Q4Avw7aS8RbyXZkz1DQDNhDj63PoD
 h7nT1rLPqvoPYTmiVNp/Xf9DjzV74mErXfYVvUgCNCsgOmSp2eiJQ23ytJLakVAS/3Rk
 9Du22aO1/gJMnqm5jLSQH7OMf3CgMytPJ1JEEPgwdfFdy89yt6iQZD41CdR7qac88XVh
 I0NP63Dz1SqHUgXPMQUTceHDg2uXup7wLf54pi/xT8QwCRMPfpw6HlYmcuftPLfaDwJg
 N6DPvO43a5AMK+tBnmkijeRP2ZiMikKgJ9ZB9B1tjfwNLfLHSQROGboOsmU0gpfzIFmO
 iKMw==
X-Gm-Message-State: AHQUAuadkMc2OkRP3xNkhikXPV+TL5FlEzaA1bMq7p/vC8db/gHmkEW4
 JxRIq87A15yEeOscolZQvyRpwTTrhnXuz2WRlYUibg==
X-Google-Smtp-Source: AHgI3IbccI170wZyUA0ctgYa9bFFzDmZ3Uw+ykboklDD6KFHEKhw0VEhUQW/lAQ2upoFSCsMhW9sBu907CFpggTfcoA=
X-Received: by 2002:a37:d492:: with SMTP id s18mr7248063qks.343.1550247849689; 
 Fri, 15 Feb 2019 08:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-6-thierry.reding@gmail.com>
In-Reply-To: <20190208150935.32108-6-thierry.reding@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:23:53 +0100
Message-ID: <CAK8P3a3r_HyCKo7Jacd7gRxcQ86raPZhDiPQ55+bZofRGdrdUQ@mail.gmail.com>
Subject: Re: [GIT PULL 5/9] firmware: tegra: Changes for v5.1-rc1
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_082410_891721_1AA7EE1F 
X-CRM114-Status: UNSURE (   7.66  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> firmware: tegra: Changes for v5.1-rc1
>
> These changes add support for BPMP on Tegra210.
>

Pulled into arm/drivers, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
