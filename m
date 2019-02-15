Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0477C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:52:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E985222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nwBp+NvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E985222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bb4zcbNGcY/ntPbz6ZztWn1SZT/wxWD/rmZI+3YQdG0=; b=nwBp+NvFYlt0CJ
	F5mzYJGSuMqNVk22v2oiObMBcM8iqGj03jybrRXiebm+sik8+HmB1qUKgg0yLcMKkQ/OYFKm6H3t5
	FXpjwPmEaJi7Rwk4eh5luduqM1CuC3emqW9SQwfNyJYM/JOf2pIm1lVK1j+nWS6n+llI1VyvKR74l
	miDQsldgRIISzS/ItD/ENS9LFicEKC3ol7Lx4NRvGJwviLLHFY+TZxryJW0/QVf56WZ3YOc1ZuOkk
	VqSZcWtWOm6dij6oDtS34StrWha930aB4clNfeA0bW3+/CDtqCVwNL+l3btcAWvlES3SPt61wWpfH
	D4sloBkgCs+drFKvb3Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufmZ-0005gU-Cx; Fri, 15 Feb 2019 15:52:07 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufmW-0005fM-8J
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:52:05 +0000
Received: by mail-qk1-f195.google.com with SMTP id x6so5947563qki.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CmBATC850mmfvaVW7mtBk1uZrY2BDjTHjdx4/fW6wAE=;
 b=W+z4lFCct/HGPfYFZAUHznioWm3eY6d4/rkT3HNAIJq/9MCXGulaGaD6KQJCkd2xoi
 JyK2pUnmXbhkPk6Irii/TY2GxhQMFOaFeHqBU9lBJoFsekACVVwns8mjfD6kltFwwaIn
 KF5WdCe8FS9nzhL3EYj9PyXYSTs7Pox6yk45/LfKdUkDkiktj8sW10FuwovIWniEt4sz
 6Cj5/8SAOp+VBCvya41mzKoOPv5gL8Svt1amMb+AItAyzM6oIz2GgzzXy+JnPORSc6g4
 TmijsdbL6bhxa/bMKZR1HmIDaU9rrCfFJRJ2n3XCeV7m4xyCYrwA+2L5cQe3AualsIf/
 84sw==
X-Gm-Message-State: AHQUAuZymAsp1hEI/oNAW2muB4g2uImukjf/cPulJLCPK1SifXRve8aa
 QvJy8lGsfUDTjJi+kSMbxxS19Nr5dR9ArDwD28PwQQ==
X-Google-Smtp-Source: AHgI3IbHWbHIOdeYLKk4OF9TABh8jmyO4aPokAw4HZ+EB3XaRNWi4cqM9Epflp5QZxo9BuJTm+ub4xO9w1X7B5j6GaI=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr7521609qkh.173.1550245923428; 
 Fri, 15 Feb 2019 07:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20190208103507.mok75mo2gef3bjas@flea>
In-Reply-To: <20190208103507.mok75mo2gef3bjas@flea>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:51:47 +0100
Message-ID: <CAK8P3a1eazb5xW=udtiC=FtBvS_CoE=zzhT8ZzPf_sBPz=NXrA@mail.gmail.com>
Subject: Re: [GIT PULL] Allwinner arm64 defconfig changes for 5.1
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075204_293997_7DE4E1B1 
X-CRM114-Status: UNSURE (   8.01  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 11:35 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Allwinner arm64 defconfig changes for 5.1
>
> Two new additions to arm64's defconfig to support A64 boards.
>

Pulled into arm/defconfig, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
