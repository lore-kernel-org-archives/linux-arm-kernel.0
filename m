Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBD5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:12:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5885214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JR+EtLQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5885214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O5OiXzFJfawF+9zoqwxJFMYsDcL5P6kvfW1gmvjsQGA=; b=JR+EtLQ4bENcLH
	US7enazvLMJF4Wkm5oEphbjkFRDvdyf9YSCG+aXrGGqxdmva6ctxkyQNmnKFp1mud9qooRxawVdfq
	gwIF/JIZlXeTwwHXUDlb5kTHjdL9Fo4OvzuRRJZm3+bnNUUxdOgSivFZTXLLCbYV2D56i3ZpOFn5K
	huh1vkDP8CtHXrdPwYuZFdt2MR25mLbEX9YFal8BqbCWExkb6x7rd0aoFHfjP1yzVe66U1NBltd/m
	vwUSdVUyx18PHJ3ACuAyPigkLKEPvtWE5RlEeEHt8vWHEZYviQGWvfG/2WxjfVBqtTbT9eVfXIIBZ
	1aE6YTPuxihCPLbE1ZCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gviij-0001HY-Sy; Mon, 18 Feb 2019 13:12:29 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gviif-0001H7-Pb
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 13:12:28 +0000
Received: by mail-qt1-f196.google.com with SMTP id 2so19060675qtb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 05:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pVDvp/pZYMpPQNOq3faGwENXNKHYA5c0q53ip6dMAeU=;
 b=A84YcM3OZyjBCZOOBDJic9Gb19rMFxExdIUkA9naovc/R7bUSrJnoiujsCoUgp76Ea
 ciNfqfU4ZzS/mt+JHqjwgP5EqKHN6whuEYQ9Ex7AR0ucuJ9BDHIx9wpjpNpkRy95YlLw
 P2Ho4ZN5VwrTRPzfangj7Vw35gYvtzH3B4d7LKmTdlX6Nd4GkUxg7JD2eoKG/FjQ8Ozd
 5OfSJ5PwmBXRjBcvxt6OvHbniAQv9sgLIKhgiR1M4xobTDCmv/4tYD0RycWxrAi+J0yZ
 dNVfvJ38s3lMdv6k5yh6Bz0r24lRX3i/MTIu3t9Vi/AFZZK4n6Wd35zrjsI0cwFKCMW3
 MNzg==
X-Gm-Message-State: AHQUAuZq3q8/Xks5dmr3KL8VUaK22Dk31yDk5905pgRy3++Isytwd4N4
 nqiUIpEO09vWqFFCiw8ZWfjm8B9ctU6p29FCJe8DN3LP
X-Google-Smtp-Source: AHgI3IY/ZlfYifC+QcHm3Ii/+I7UJohCqL235t4hAdfqNDFfh7SaaxV4XWwtM/61ps9zyxS4MDO1VFQCFMpqGjp4XHw=
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr17565857qvd.161.1550495544653; 
 Mon, 18 Feb 2019 05:12:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549622472.git.horms+renesas@verge.net.au>
 <CAK8P3a0prd-4eyVOVUpp2Bhn1mGOVZwA_we79TNjSa4FF5DP6A@mail.gmail.com>
 <20190218112715.zufzr3knrhs37t6h@verge.net.au>
In-Reply-To: <20190218112715.zufzr3knrhs37t6h@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 14:12:07 +0100
Message-ID: <CAK8P3a1BrahyfrRD=1dSLNzc1mujh+rxdLoU8CtGruRSbo3JVg@mail.gmail.com>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Updates for v5.1
To: Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_051225_826737_B36D1413 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 stable <stable@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 12:27 PM Simon Horman <horms@verge.net.au> wrote:
> On Fri, Feb 15, 2019 at 05:49:32PM +0100, Arnd Bergmann wrote:
> > On Fri, Feb 8, 2019 at 12:14 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> > > Renesas ARM Based SoC Updates for v5.1
> > >
> > > * Correct shared IRQ handling of R-Car Gen2 Regulator quirk
> > > * Add missing dts files to MAINTAINERS
> >
> > Should the bugfix be marked Cc:stable and and Fixes:... ?
> >
> Sorry for missing that, I think that the bugfix should have had the following.
> Let me know if/how you want to handle updating the patch's changelog.
>
> Fixes: 6d14d4d313d09dab ("ARM: shmobile: Rework the PMIC IRQ line quirk")

I think the easiest way is to send an email to stable@kernel.org asking for
a backport of commit 5347a0203709 ("ARM: shmobile: Fix R-Car Gen2 regulator
quirk") after that has hit the mainline kernel and asking for a backport.

I've added it to Cc here, but I don't know if that's sufficient.

If you'd rather have me pick up the patch for 5.0 as well, I can also do
that and add the Cc/Fixes lines there. We will then have a duplicate
commit in 5.1, but it should not cause any merge issues.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
