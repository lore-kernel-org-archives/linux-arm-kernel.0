Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FAEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:14:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0408A206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kr4ONJWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0408A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NwqbQhLQoIEkBSXzbEKvo/Io2hI3ilsOToB/+u0aSQg=; b=Kr4ONJWMHH/NG0
	Ijj4NeLzfHUVaN3KJzMBtVN2VLbdBGQuHIkhZmN0J9fKMIk/wyIKAHrHeHTsPNWEHvOuF8lXuR+zT
	WQFZcJBDtwvrmoVmfqbNKJTWHddJJfYaIHI9dWQxkvIXTa5S2XkSf+a/gmHtBsEtMdu2RUpCJZRsp
	wozfi7kR/k65wYGqElXOE3fClLMCUeFTZhjjgAmgMuHKGVO24+JIoo12ibz+jGEV4qBxNyu66e7zm
	t6IUswI68q9Atmrn/dV/KRWX9sZQOqYJ7nZ9AQVeAH4Utw5nL+uhVTi4SJt6UV0VYmwR4e1p2OELk
	bT1IGKbljqhx9JvsXU+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTa8-0001Z5-4w; Wed, 20 Feb 2019 15:14:44 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTa5-0001Yf-9r
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:14:42 +0000
Received: by mail-qt1-f194.google.com with SMTP id j36so27528327qta.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 07:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BQRnv0vrIQNIvYtV8Fbol+CbnW4W74tpn1ESfd8zZg8=;
 b=XM96rCjB09vHCQhkBooQ99ISp54RduAKLpzSmTSf/5WE9aLJ1sWVaNBVSbIS0jo1Tq
 iFbXQIlP15fASpvvRBEmyiBA6UQt1JBpPCjQKAu1hIg29HGJ38ep3JVImsBdMG/STOeo
 g+gFHWr8QeH8UWZIHVaZ4Yw/ErYQ5yvbQwAr/NReAgAnedk87Lqbh4JdJOLa8BH8ItHp
 tErYS9G7DfKL3EJyFDqcidITFUPmebWizsWi8/Mhb9ez5Geh0CKSRWfkbyqcI64NOoe/
 4NwVt6DBaAbg9/aHVQEs4WmsMsZ5tXSfDTU+5YBCO/xWeqTYrysFhWy+14H+Np6YNCT3
 ixZg==
X-Gm-Message-State: AHQUAub6weJEOTOXHXoltTWts4IfPA02Ul9sgL/DPg5UeKV23Kk0r5fz
 rxIFf554h8cOENEqs2Wc0SrLjOsCn196ISGkB6I=
X-Google-Smtp-Source: AHgI3Ibrg5qiTE3LPSw67wXgNpL6BlWxaKTfPW8KXgJ6fVxLNFUkBEAL72nEcEyqxVcwrQDRJgO4KYqFAU94GBZEv6o=
X-Received: by 2002:a0c:d791:: with SMTP id z17mr25652734qvi.149.1550675680142; 
 Wed, 20 Feb 2019 07:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20190219210953.1840-1-leoyang.li@nxp.com>
In-Reply-To: <20190219210953.1840-1-leoyang.li@nxp.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Feb 2019 16:14:22 +0100
Message-ID: <CAK8P3a2O+x_tRHWs9SNeEMkLhf-XpunifkNiEa76GCN2_NeanA@mail.gmail.com>
Subject: Re: [GIT PULL] updates to soc/fsl drivers for v5.1 take3
To: Li Yang <leoyang.li@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_071441_342168_FA71ED28 
X-CRM114-Status: GOOD (  12.07  )
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

On Tue, Feb 19, 2019 at 10:09 PM Li Yang <leoyang.li@nxp.com> wrote:
> The following changes since commit 3c0d64e867ed78a782a8a00d3b519396d9c5a2db:
>
>   soc: fsl: guts: reuse machine name from device tree (2019-01-11 16:08:43 -0600)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.1-3
>
> for you to fetch changes up to bd3bd3b36df725645036748e58a8c35c8d2cbf91:
>
>   soc: fsl: dpio: fix memory leak of a struct qbman on error exit path (2019-02-19 14:59:39 -0600)
>
> ----------------------------------------------------------------
> NXP/FSL SoC driver updates for v5.1 take3
>
> DPIO driver
> - fixed a use after free problem
> - fixed a memory leak on error path

Pulled into arm/drivers, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
