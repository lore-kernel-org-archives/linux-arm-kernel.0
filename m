Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4784DC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:15:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D58218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MipuNFQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D58218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4frX6GMEIQSHxDRBKy5cQ+FTYwU4O9uIg1oyxuhKXN8=; b=MipuNFQJVaQgEp
	XRk5fHDq+3Qpr5cYzXf/sTG3yZIHB8GZaxgOeX2xcJuehPOvX5oUiGKNYUlb569CY8/BSKALMzKDD
	by510YqQTkZehrYU1mBi+6gAC5EZdwcU4SxNJPKOmdiJcJdaATEwYeLImtgbUcISmp3fa6PXsAF5d
	4cY90Ml8KGyQHOT658N+HWMGjLVG5TE2kjjICJaCGEGdrcwCYUBVUO7A27T7T5oAmWCtkheRAwS2H
	ehIJkRP/ZEumqUsspp3IDPprAwhyxLFjvFE826IY20IQnlYw7c4G0ADCl5iFiTrsIXecr9Rtycbtq
	6CuTVwPCw3to8KG+Czyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomu6-0008NU-GS; Wed, 30 Jan 2019 10:15:34 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomu3-0008Mn-9D
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:15:32 +0000
Received: by mail-qk1-f194.google.com with SMTP id c21so13332247qkl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4GDNlm//MFE5FP1XiS5FBswbHuWVO6m+yA1RhhQ+bHI=;
 b=t7v/oyAjP1uhQOfyww9ymbmDVTkxpNx7tKFLtbUggGlcmeEKp+LL/HLKuNQ2PQF9S8
 WNb5aOfhimNtIVLmpH2rW6kcHQDgk7Z/RJGViPQ4m+XYbPEWfry99CPOrTCoXUmC88CH
 YOYlN6xbfUB/znZF4fgpgduAKT7/yAg0qAkA93vTYEFm8Gb2PjK8l/CYk6K7B11exXq4
 +S04HT8+Cbx22NT2ikyJzLM5TOK1UeNSqRFxOIFs5oxpLBI8T62u5vWcIRmzuG3iypul
 HfA/IK8qUp5KCSEW/lYv/EkT9TknGN6xKK07Ib7qKy6jzmLdwYAi5wPNaL7+akZboVj5
 Et7g==
X-Gm-Message-State: AJcUukeUWXoj+pWjlPeGnRFDYQZtMhrGVVrBG+VaT1at2b0INci1Kl1L
 PBWm7+IL43SsyTZwX1AMeltg4ZDMiZtDtgU8YwI=
X-Google-Smtp-Source: ALg8bN431VqAOdiSWckvYl30ifikO1buFSOFPjTCMwshf8TM11TtEGQuYwpPw+0Y1fhRnya5OmQYJEJiU5PI+8yyLWM=
X-Received: by 2002:a37:ad04:: with SMTP id f4mr22227158qkm.291.1548843330132; 
 Wed, 30 Jan 2019 02:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20190118232250.22570-1-leoyang.li@nxp.com>
In-Reply-To: <20190118232250.22570-1-leoyang.li@nxp.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:15:13 +0100
Message-ID: <CAK8P3a3J_8tNLTs32Jq+MgwnDqSMAiRG0VVAThreWg-1tk8+Nw@mail.gmail.com>
Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v5.0
To: Li Yang <leoyang.li@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_021531_358507_9D9E5527 
X-CRM114-Status: UNSURE (   8.02  )
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
Cc: arm-soc <arm@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 19, 2019 at 12:22 AM Li Yang <leoyang.li@nxp.com> wrote:
>
> ----------------------------------------------------------------
> soc/fsl fixes for v5.0
>
> - qbman: avoid missing interrupts by only clearing processed events
>
> ----------------------------------------------------------------
> Madalin Bucur (1):
>       soc: fsl: qbman: avoid race in clearing QMan interrupt

Pulled into arm/fixes, thanks!

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
