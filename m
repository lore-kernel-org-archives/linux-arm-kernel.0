Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52C0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BAA2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GcjJyPuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BAA2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OKBmoKZzqMM2x3bJUSQDJnHwtTEq5a9OE86FI8JnT9I=; b=GcjJyPuFBKVU2Z
	a2qmHSZqEt/se9TPJlSVSsIrAYSP2llv2yMkpR8dSx4vSmTNrW6Sn0jJGZ0MpcqxPyacAFzic9KD8
	iYn5YyS7oFJPepGWgRlO8tS14lbFTDk5GVf10aHDqOTCTlLnw/r+6U6ixyFikmMrheBewZXBIQUUv
	lxnQZh6zz8d4DJ3tYcOdqsCT9uZ7nES9/1Lxt/Kg+0xkj071Mzycs2zw1mnXII6ORS/1LyDrfM6Sp
	To/Boxl2f93W4A8iPsyTE+My+Af+Ib+LRCuZWyts06NlcNDiFGuOrrn02H+oyuOyV6mzvhzAoEsdp
	oLDkc049Rw77dzCM32yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucoU-0002DQ-2z; Fri, 15 Feb 2019 12:41:54 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucoQ-0002Cy-SC; Fri, 15 Feb 2019 12:41:52 +0000
Received: by mail-qt1-f196.google.com with SMTP id p25so10378594qtb.3;
 Fri, 15 Feb 2019 04:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PFFFNCReX68i3hDHiaVQlpz12W9YUWhz8IVuaQ+miK4=;
 b=O6qZ0YoYJ6sDzjggxABjMtICZdO0YZEuszfOKKXfM/H4nzjvCh0W6BwUkjA6U1g15z
 b3p7sNE25AF2Wy7skeaWTR4+GVNRfgjwlDH7gpT6lS2tEI6jryU2JNbnm2+UY6KX8s0p
 uMu0LUBmra5GrR8989DWP1C4me+nLYlEmP3c+CSjSIIwRhxLOjfZDtRuwysQcl+P7Wgq
 d6Dwvcz8vQaNgB0F0SgmAiIKincTo/QF2XawIodl9Xnga9ySPtss04pJFDXPaqh8MrBV
 sc3gYBSoyjHVLQicUvzVUoG1MAvp8FTiULUEvBHXZRv5Bjywsk7eP1lXvk6B1QxkfZdj
 kX8Q==
X-Gm-Message-State: AHQUAuZYgU4aVyANK93duR244fR5VS0rilxK4uitiC7B89yp6U6tuaNZ
 BY4Lknery1y/g0NY6CHG2X7BxWsyhgDdiriV6n0=
X-Google-Smtp-Source: AHgI3IYLQcfKUlH44fJtB8H4lD0HHTghl/N/Xr5bX7VhrgrMMhnbLdwxp/iyzot/6vUo1fbYIVH7m4b80q2EgZUPaH8=
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr7143664qvd.161.1550234509551; 
 Fri, 15 Feb 2019 04:41:49 -0800 (PST)
MIME-Version: 1.0
References: <7484850.KS8GUYnfXV@phil>
In-Reply-To: <7484850.KS8GUYnfXV@phil>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 13:41:32 +0100
Message-ID: <CAK8P3a34EbDO6TNDp8GBZ8zSZxyNmk=R8WWcd7AeNvaGgLk_QA@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] Rockchip arm32 devicetree fixes for 5.0
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_044150_907791_72B21185 
X-CRM114-Status: UNSURE (   6.09  )
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
Cc: "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 12:13 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Arnd, Kevin, Olof,
>
> please find below and in the following mail some fixes for Rockchip SoCs
> on 5.0-rc. Nothing overly major thankfully.

Pulled into arm/fixes, thanks

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
