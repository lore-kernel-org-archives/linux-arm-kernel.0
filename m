Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AB2C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:19:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5996220867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ckpAdBLV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vXWPOtVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5996220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q6KUxXalGign1ZsHykApqsO5YC9wuZxmFbyKixjBWBA=; b=ckpAdBLVGxnj77
	Fahc34ZEmPIyZD6yj82S3AWGiU3h34u28zYaq+KOSxK6dTcuufz7ikczGxchSCh2kxd0wPi8L0P96
	T4R52YhdxfPstvdFDx+LVpCDF4bwXhR+g6urhQBPBO75FnABIB1O31gkpaiDkZ3HQlr8C73bVAidr
	jb3mUrmsDA2acQK+7t6LahsuFNebGReAyESgeUjmrZoZLYGXqg8FXO43q/7WsRy6h1T+2G7aIjjhL
	nIac3FibGIdUq9/ujRciTeW1IQs9pPl+25vzQ3N8fGawkBV5iHkIz2F298uw/NNjk4m2f00K35X/P
	KTMKDomno2rlE08kVedg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkZI-0006Dr-Rr; Fri, 30 Nov 2018 15:19:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkZE-0006CR-Uo
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:18:58 +0000
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A4922146F
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543591126;
 bh=QCW8ckCIFFEcd0zf2KZidZdQjbGAkx/mgX7p6oQzpSE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=vXWPOtVw1cCWDc/iwmtqW3yxVxm4UIEk+NqpPh9I+r44Wi1Yq+CokBtErmrUhtjvy
 INqdBPsZ0mD+JD8NlqFeYZlcq5Mz9Hpohq9yEXhK5u56xbsd4nRiHb3EcSrHnGRKXS
 HmNCQloXTyDHHEngpusjTkQx1T0EeZDRDMqrwnsA=
Received: by mail-qt1-f173.google.com with SMTP id e5so6223029qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 07:18:46 -0800 (PST)
X-Gm-Message-State: AA+aEWbLcCDxwuRsZBDAr9WyJU+257tDs5GeCycRvlnZ/IIedoOVEJgZ
 KxKwtCt7PnN63Z4OA7A1bGVlF/9nSdhe7PKPvw==
X-Google-Smtp-Source: AFSGD/UJeAX9yfrb/mzIcU++PZZzonDdREYayVLPHmHujQle0jOTWhI7iEiBYo20x4pfg0mcJ51BGgIUWazb+rqbm0U=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr5017205qtj.76.1543591125348; 
 Fri, 30 Nov 2018 07:18:45 -0800 (PST)
MIME-Version: 1.0
References: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
 <20181102183246.r5xxwsic2mxwihsi@localhost>
In-Reply-To: <20181102183246.r5xxwsic2mxwihsi@localhost>
From: Rob Herring <robh@kernel.org>
Date: Fri, 30 Nov 2018 09:18:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+HFPnzw4Fo3rLRMxber8_itGZ=LjnUeyvvDOt4_txm3g@mail.gmail.com>
Message-ID: <CAL_Jsq+HFPnzw4Fo3rLRMxber8_itGZ=LjnUeyvvDOt4_txm3g@mail.gmail.com>
Subject: Re: [GIT PULL] sprd dts for kernel v4.20-rc1
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_071857_010499_C38EABA9 
X-CRM114-Status: GOOD (  15.81  )
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Lyra Zhang <zhang.lyra@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 chunyan.zhang@unisoc.com, ARM-SoC Maintainers <arm@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 2, 2018 at 1:50 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Oct 18, 2018 at 05:17:33PM +0800, Chunyan Zhang wrote:
> > Hi Arnd,
> >
> > For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:
> >
> > https://github.com/lyrazhang/linux.git m-v4.19-rc1
> >
> > Please let me know if there's some problem.
> >
> > Thanks,
> > Chunyan
> >
> > ----------------------------------------------------------------
> >
> > Suzuki K Poulose (1):
> >   arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
> >     ports
> >
> >  arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
> >  arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
> >  2 files changed, 151 insertions(+), 142 deletions(-)
>
> Hi,
>
> This came in right before the merge window so it wasn't included since
> it's more of a cleanup. Please resend it after -rc1 is out and we'll be
> happy to queue it up for 4.21.

I'm enabling by default the DT warnings that this fixes, so please pull it in.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
