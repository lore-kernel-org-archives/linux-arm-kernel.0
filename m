Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9A32083F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K+InCXig";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="boO1yCdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9A32083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7qcquOe2a1KOEP9Ldli7MHUtlP2bJLF+nqXMG/o6gqo=; b=K+InCXigQsC5Qd
	muKs0Lqy5CHNOq20PMQmXBRIEzc2xLLL0FDlbMdkBp8nLBE+u+Fr+acIlDRHMHo0flqOtLj/jmOJn
	0BuovYLKjm4ZifKGxseZCpqnLoikcIgXmcT72Q43CmkBJzdOuGFTJLFYnQVUsH642VlDpc6CSFPzi
	/SG0H9DLVi8YBC7rjvnipOilRQ2Fecex6xtJUH76LBf77Vm9V1jTTBecJko2I41uYhH259DbgzCx0
	c1D4wOzVoI3Cul5Bu+r8vtUWWr0nR63CDHkYuYe1u8bkrSNTla3F+45SLgwQPcYqHGzCndLuGKMUq
	d6ikpjjNlT8qA4cdqBvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUY5s-0004mj-HA; Wed, 05 Dec 2018 14:24:04 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUY5i-0004iZ-25
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 14:23:56 +0000
Received: by mail-vs1-xe42.google.com with SMTP id v10so12144537vsv.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 06:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EIvb4BQKwGHXOv6QLdm4mSfUSgJuFgwSYljcvzR/CXM=;
 b=boO1yCdoWDdWAf5JfeQl+Pk+Qb2zcrFmrbTfp4kL/PScNLbbKJJVtF9+5Q37Bki475
 QOVKT5rc72Agq60OblMRiotfN6YR7tFCI/8ZKuE+8hseo/M8z4GgdwVeSoJBZNS7g6RX
 68/EWsmFG1e8BnN75R/jq6YOCdbRyxLpbHFbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EIvb4BQKwGHXOv6QLdm4mSfUSgJuFgwSYljcvzR/CXM=;
 b=VIl3x5cB9jgSgqG1X5pmfaCoSJZ4mheWxefxVFi/ZvruAhTLYZ/cPWDn5Ym4B0SrCp
 SV236mnFsEto9Vqh54ORQ82xc473cZ866zEHoskj6/jEFQx8jPIIsBQHtSiLgS1rh4n9
 8BDEnNo2YzrLI0S+9/zeTR13AO6g5pIW1JaIj/Yjl5VniHb9fU6ujlTx2gdRSdjz2Q8J
 O7gLpdjt+CMdv/lPXNiAUTnKXsZP1pkqorWKcFZaezVbr6FJcCme2XFew1L8CEG6Exst
 nx50x3tZUiCEyVDvuV/jMZlhUIsZrEgLXwJtJVk9eyq4BHcjls6r4gTPW2d/Bb8sp7bk
 +eYQ==
X-Gm-Message-State: AA+aEWaYPeZ9TaDYMcn/y55VBkLngApM6IEEBqMlr4oaKfRZDphvKVtr
 DTlQJntEN61JV/zaLXHFj9FZ9PTSeSqxTJ3ukcaYXj9n
X-Google-Smtp-Source: AFSGD/VQGUxkAW60ENMNOuGL8Ydx7B6qiTmVtyWE57yebwkDcmEVNGqR8W9Ql6w5+lPEnFEeEffsRZErH03n0Ofa5G4=
X-Received: by 2002:a67:b245:: with SMTP id s5mr10892886vsh.200.1544019822027; 
 Wed, 05 Dec 2018 06:23:42 -0800 (PST)
MIME-Version: 1.0
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Dec 2018 15:23:05 +0100
Message-ID: <CAPDyKFqM6RB58n-ZdTipDQZ6v9rQe89ndrSNdhd7OtRkcSozww@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] mmc: Several fixes for bcm2835 driver
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_062354_562473_24DD1D9D 
X-CRM114-Status: GOOD (  15.73  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, Phil Elwell <phil@raspberrypi.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org,
 msuchanek@suse.de, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 11 Nov 2018 at 21:24, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> This patch series fixes several issues which has been discovered after
> submission.
>
> Changes in V2:
> - add my own signed-off-by to patches #1 and #2
>
> Michal Suchanek (1):
>   mmc: bcm2835: reset host on timeout
>
> Phil Elwell (1):
>   mmc: bcm2835: Recover from MMC_SEND_EXT_CSD
>
> Stefan Wahren (5):
>   mmc: bcm2835: Release DMA channel on driver unload
>   mmc: bcm2835: Avoid possible races on data requests
>   mmc: bcm2835: Terminate timeout work synchronously
>   mmc: bcm2835: Refactor dma_map_sg handling
>   mmc: bcm2835: Properly handle dmaengine_prep_slave_sg
>
>  drivers/mmc/host/bcm2835.c | 58 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 20 deletions(-)
>
> --
> 2.7.4
>

Applied for next, thanks!

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
