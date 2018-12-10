Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56778C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:42:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA832081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rZvGz9o+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crossfieldtech-com.20150623.gappssmtp.com header.i=@crossfieldtech-com.20150623.gappssmtp.com header.b="uON42d//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA832081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crossfieldtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=BzqVvYXcMNeF0cQLf5dc5szwdKQ3gQW1GVLOEzWvkC0=; b=rZv
	Gz9o+Ra05TXaEoZm9GQRK6Av1svOd8i0V8ym985Ald0CC9DVTjTT4Q2vuVLsS9hNDU95/GIYOhw5g
	Fv8JuwXwHhWE3fv+6FY0CNR/3+lJsP5zG3aHlSdpPtpWHwapF8jHXhRS9rwykc1wb31V688KE1KMy
	HHMce41AIGVaPrh+94HwWCPkm9arq/Mvfe7j47V6ssOc5sgJHPb6rO2uBhlIc4Bv1csPrDw2TnppT
	WuylqxpBXmQY7bE32pU0hHKtCWcxGA2pw8GfWJel6Mq1YfFSqS+RJ6+rPvzBatzIS6s7t7u5zC+WT
	fz8W4VtAuZPAGytIQRQzpGk1L1mlNTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUFZ-0005ds-SR; Mon, 10 Dec 2018 22:42:05 +0000
Received: from mail-it1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUFR-0005ME-Gn
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:42:00 +0000
Received: by mail-it1-x12b.google.com with SMTP id i145so553815ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=crossfieldtech-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=WvaUTBi2mzRwphJ7uhFrpXZ5B9GYn2dZkPaMpG69mgc=;
 b=uON42d//BQOaUeyDbAr2EXhJodIiCVrsjofEvhiV5Pt0uBWu5ZE8mbfCBVULW+8JmR
 0dGYoGj3bhd5q2ItFdRGaoDe4WbMVIj66jiOedXDYIyi2xLCIE8LMQqGIVC2p10+eeWY
 xv/nDtNqDncDjbXiz4ZBXdVxBxYGn1C6wTAL/Bo+Cauo96TBOaI9Zdq0EmTskGk+p5d/
 NGce3cgrA2PMHlBCgs1pjUAu1Dydsrc4D2GS/VHPWgC30CpJ1FzkP6mGrH7Q+RXLtTrF
 ariSK5DRZimszmrIxDolL2EyzEWF4XdKtOYUj7nLJMavhJyndJfKBo9IyGRlh3T6EBZt
 GDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=WvaUTBi2mzRwphJ7uhFrpXZ5B9GYn2dZkPaMpG69mgc=;
 b=AIUw5gfr7A/iEIJEMVxzpmlyIASnWIV/nDiaDPu0uyLQ3QD3agvoqvTF0NNMT9mbQX
 Nb78AJTyrkw5OuxjXwsuj2OsCWbfDmZws9G80ZvW8A15DIKhwGKVJuekysG9YmD3zIXy
 HoA/hd+FsqyfZTpVDydAEOEbhJBguizcMy9+Re9D6+CTW7lnE2BYi7N6d2UMr50z2rBd
 CdGmK5ZUnppeie0Hpt3Gc2Ngc8CcFmExc4HXuECrWf3FdodX+H8rl5VvN6anQIvhWwYt
 YQJmbfpqptKiG0HsCZXB8wECYh6UbhohsKQ2iD2D/O9gEBnT3y/N4kplEzwKvX+CPgjI
 DPCQ==
X-Gm-Message-State: AA+aEWboPUM+smt2tUjLLjnq48xCM9RDLYX75QHN944YoDCcafbRMq+O
 4iW+7aZg+ItHWiSPRSgLbw3vO/MTmbT8eNkLWXFjuzU6NdzeDA==
X-Google-Smtp-Source: AFSGD/UBEOWpMj72IsMAi6juKT1CQihfix84iJptETF7rqj6YLoowr1wgwuRZEJWIbKRI5mEaKppJpygfD52ob44yQs=
X-Received: by 2002:a24:738f:: with SMTP id y137mr246351itb.136.1544481706122; 
 Mon, 10 Dec 2018 14:41:46 -0800 (PST)
MIME-Version: 1.0
From: Frank Miller <frank.miller@crossfieldtech.com>
Date: Mon, 10 Dec 2018 15:41:35 -0700
Message-ID: <CAB_0SN8Byw9q8b0sGarVU-YRqFuZd0jGpnYd_yPT-DCrN6ZZbw@mail.gmail.com>
Subject: changing arm64 kernel link address
To: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_144158_070520_E58C34A2 
X-CRM114-Status: UNSURE (   8.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Greetings,
I'm trying to build a kernel for the Intel/Altera Stratix10 socfpga
which includes a quad-core Cortex A53 processor.  The hardware we have
has its physical memory located at 0x80000000 and I am trying to link
the kernel at that address.  I have tried making modifications to the
. address in the arch/arm64/kernel/vmlinux.lds.S file but to no avail.

I'm not sure this is the right forum for this question, but I thought
I would give it a try so please advise me if the email is
inappropriate.
Thanks,
FM

-- 
Frank W. Miller, Ph.D.
Principal Software Engineer
Crossfield Technology

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
