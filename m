Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF1BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:12:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04A92084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rQJfi6Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04A92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g33aczs6SLBGn8HK0jkB0VMaeqp64JK8FoCR+0IGjEw=; b=rQJfi6SlDXb+Az
	UkUugCmUk7SoMMhHaw+Y0CCAKb/btWBU7Kz+dZmk3u4HJizwER39318TYjovosmplQZ96n5CjXHUw
	krngHD36q2KOFkWHk/WEMQWYl+suzlY1fCtxe7yGXkhn7L1jN3mAv6ba08oulY1TKgnKKPJ6DqtZT
	H2Mm9k+GZTbm/O2PGTCH2K4oY3zaKpWIDvIUrD+jX+mnza5QSHB+PsOB3ZEeofITSD7A/bttzNqq6
	4uWnkc0nD7Y5EPyRbQU+AZRdEXfPFjwwxpAgDxbupiW30HI2FVrZuHiZV63hcRQUR46j59mwjbw0c
	UfgNaB1wXHoG6HZV0UEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCjQ-0004Ji-K3; Wed, 12 Dec 2018 22:11:52 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCjM-0004IL-3h; Wed, 12 Dec 2018 22:11:49 +0000
Received: by mail-qk1-f196.google.com with SMTP id r71so11760926qkr.10;
 Wed, 12 Dec 2018 14:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a4hveH0+pxskiKEONYlkZn2mEsco1rz93C2T/TG9bhA=;
 b=FosRzYXizgnx/CUXfvNNlckQQoRWGtEnDOO6bFriq3WSu7vTtsoP29XjdnfjwZAONj
 fKlWGcza1pFSE7ttLPUUuqlmkrmR8xITLLXI+Da8UfTaGAhmVBwX4Fo/St50FkceoqWu
 N0Pv2RjmIurcMiURX87ThxoZu9ouNiHdgbTDIH5WJbg+qq5pCe7yGY8JeufNLmFPsUq3
 ueuC9Yw3H5u41V4OfmZjWOzSiG4xoqNhhIyWLF+iwT4kuR4JtlUl+UvS7Rik9IipUF2o
 I8wgAImLi1McqQcum9CIpTi4baEWA2fO09sMA8JmTeFYxxTOTv48rsObjXMOZa0x3LMM
 UGfw==
X-Gm-Message-State: AA+aEWZPCqwI3K/pIUhXAfSd5xVYAEiiBiXoGNfwg/8Wgmkq/coWESe8
 /zoLWTpYvY7u349DTDBj3qaxhi1IN3vgQC8MAx8=
X-Google-Smtp-Source: AFSGD/VFBgfLL1Kz14JMpWi9zTruSiShlUK2pA9meBTn5215mbYrPCpoEFEAx6aJ4BOJqbj2EH64cPSvAV1e1oj8E2o=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr18775076qkm.343.1544652695287; 
 Wed, 12 Dec 2018 14:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20181212185136.6620-1-nsaenzjulienne@suse.de>
In-Reply-To: <20181212185136.6620-1-nsaenzjulienne@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 12 Dec 2018 23:11:17 +0100
Message-ID: <CAK8P3a0aUTNOwz2BJjm4H2m2E+oYeeX4G7j6=Yk3PZWvat79Yg@mail.gmail.com>
Subject: Re: [PATCH 0/3] staging: vchiq: fix completion routines & semaphores
To: nsaenzjulienne@suse.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141148_147846_98C6A59A 
X-CRM114-Status: GOOD (  10.04  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 driverdevel <devel@driverdev.osuosl.org>, gregkh <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 7:54 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> As pointed out by Arnd Bergman[1] there where some issues on how I
> converted semaphores to completion routines. I wasn't aware of a
> macro override happening in vchiq_killable.h, which was changing
> down_interruptible()'s meaning.
>
> This patch changes all completions so they use the proper APIs and gets
> rid of vchiq_killable.h. I took into account Arnd's commit to avoid
> merge conflicts.
>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the follow-up!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
