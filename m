Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8556C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:53:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BA220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dLAGDH+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BA220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zi+7qqnSOoRfaJAkK/iTFBIefqgINyxVcGN08jNfQao=; b=dLAGDH+iInxdG3
	7jAcCsH2Wc0I2cIRjPcA3CN1tuCjavBubJCoybKMPsoGcJxAP4dh3rqlODN1fJZXbzFI7Z7j6UQCx
	hXu41cvon/+gmp+6yfZZyALgqR+YnHetk5CTrdBc5WXGXQfkw4bhnXxGGqYWCrJAdXKCEyRTWHLLj
	TxlYu68C36bjMCoWFj+mLO2X/2hY2xQ4K62uNMYlu2vfO6fzvf3IabyH2TIiQJNGEoOGPw/BIoY8i
	w4MU5wSv4zJfgeffkCivSZepcj8t00KGEOTJlm+x4pCWpwIEFWJm8ym1j7bLKWL34mBdx+FvwVAeX
	mhMu0J0mVwqS5zhTDjyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTU3v-0002MK-DG; Sun, 02 Dec 2018 15:53:39 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTU3s-0002LQ-F9
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 15:53:38 +0000
Received: by mail-qt1-f195.google.com with SMTP id r14so11190848qtp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 07:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=92Prjp05/u4wWbtP/02mJndMIH06wvDkiC1JJ3za9Nw=;
 b=arU80IbVRVy1CuOd4MgRsZ5P+3SlRGTWIJnhlMD0/7sBhtYqixq2SNwu5IK25o7m7d
 lPXAyCC0a6t3Ri+k/WF1Pj2YHcaYTOqdzB/6qmVejeFGkGwMM/XzffUuHIWgPaJtA1MW
 /L01lMZN3WWm3VVd+JYtMFz+cDcIeb5bCzUYkMW2K0QygI4qUXlSofillIpt0owFvnxI
 OSUocJOmnmig4mUIkSfor2sNbNeGXbZ6TxOm9wSM4wjt4YzNxPjm6V6wRfyS2tmWRNFD
 BxhZyTdac5W7iIsymde6m0RqU1zHhj3m0vYddqR5KAL8tN7XxYvGfy01uJf28lcwrL0R
 c+ZA==
X-Gm-Message-State: AA+aEWauVK7KinCuhTlkS7r11jp7y/XNJKvl8qs4Sh4L9rR2QDcxR7h5
 vye+qWKjExuR0uK1aQYQMuiHhlFBhIGIOTQ50jg=
X-Google-Smtp-Source: AFSGD/WrJCr60l/IeFdMrjJbhNZllwG44gbHreQu648zmvpdOy6STapOT9kccnZFJRhhZvMjAjYrQ+E8eDwvQ+FEdLg=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr12468283qvk.40.1543766004633; 
 Sun, 02 Dec 2018 07:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20181202111224.1450-1-lkundrak@v3.sk>
In-Reply-To: <20181202111224.1450-1-lkundrak@v3.sk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 2 Dec 2018 16:53:07 +0100
Message-ID: <CAK8P3a3rEuccqhAgpNR6tP1g826m8o-mWtM1vNmGMb_-H8YMoA@mail.gmail.com>
Subject: Re: [PATCH] ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
To: Lubomir Rintel <lkundrak@v3.sk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_075336_499923_A7815E48 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, quozl@laptop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, arm-soc <arm@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 2, 2018 at 12:12 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> cpu_is_mmp2() was equivalent to cpu_is_pj4(), wouldn't be correct for
> multiplatform kernels. Fix it by also considering mmp_chip_id, as is
> done for cpu_is_pxa168() and cpu_is_pxa910() above.
>
> Moreover, it is only available with CONFIG_CPU_MMP2 and thus doesn't work
> on DT-based MMP2 machines. Enable it on CONFIG_MACH_MMP2_DT too.
>
> Note: CONFIG_CPU_MMP2 is only used for machines that use board files
> instead of DT. It should perhaps be renamed. I'm not doing it now, because
> I don't have a better idea.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I'd suggest adding

Cc: stable@vger.kernel.org

since this fixes bugs on other platforms when CONFIG_MMP2 is enabled
in a multiplatform kernel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
