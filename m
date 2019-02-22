Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4C9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:56:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEF42075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zk2VT2oR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEF42075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HhidI4xp/yfSTflMSozeA+HBGY7zpK33gtCNF6RHu1g=; b=Zk2VT2oR67qsT5
	REcLouIih00fpuS7LDUl2b3I3sXuhyc723q9VlfMe0x9FwNDWztwoDV18A5CbAPIU4vZH8s1XPtKj
	I4qSxJTwqVPehEyNW++Z1QnxeJAUSUVv6obBqhHlKwDMtEEOPoXutwSxvQ55jsBMJh6QJJfYwbgGJ
	iwP9lcNJj36O0Ia4Jtvzcw520TKkndOk1QJk1jKVNdqYQHulLmbU2WqcWTlrZryaBOA6RhalMiXT6
	L0Br9gL5zfXZtcZwIKN0ireN+dZpDmWzPYBYiTQtlgGTLY5pjuw92Ay1PstPs711EHCaESLEUOX3f
	oZhNl34ZhjSs78BVK2AA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBJ0-0008I4-65; Fri, 22 Feb 2019 13:55:58 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBIx-0008He-5R
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 13:55:56 +0000
Received: by mail-qk1-f194.google.com with SMTP id x9so1169578qkf.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 05:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kM5UavfoCUNCI/0xFpYs3WRQilqWHGSATkE2TvR1VgU=;
 b=dI1hpN6jqKQvvRtbx2A61mBxrfpkKQfLwLyhcu/v4MQLnFJLCkNYyrFps+IDqZ1lmS
 6XMgFvUINMEde9k1fVmron0iuIGU5z9Kp2VuklumNNs8gefc9CJpcbR3ETibDxsLSjbB
 AfJwHhEGFWPmzdAAYYU/hHf/g8VOfYFSZHQhmN/htyNbfvBNRdeTNF1ECTGunN2zErcq
 e3oB2lq2KOunHTT5WLupJ0yYwUnRqeetMXSa6XenbBB2SNAwfGJmfNYW14xFfHVl1yD2
 wwKOEIVXkrP3ztkSKM6uNJa6dI1cAgZSqbyrye8Cvw+uWBQi2UHrxCwvWhz3zdMDoEWF
 cBMg==
X-Gm-Message-State: AHQUAuYvLiTgdbaLIaaz0JH3hZw0ahc5GbZ8Fl192scSBPETpbfhhebq
 Hz14WteHL1m3h9/xVZsbhFTOGqdT9rIZZw6M0WM=
X-Google-Smtp-Source: AHgI3IZ/CWXu50Y4mdjHQ2zN1+Q26poKP3QthfUNDjkzuNHnreqdeuqbVRYXpJRyT3pnWynDgWPaj690iWwZWtBY3q8=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr2900336qkf.107.1550843754055; 
 Fri, 22 Feb 2019 05:55:54 -0800 (PST)
MIME-Version: 1.0
References: <pull-1550767488-25979@atomide.com>
In-Reply-To: <pull-1550767488-25979@atomide.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 14:55:37 +0100
Message-ID: <CAK8P3a2vEGLiQZNzWOt17dZj=9-vutsNzVcH3cd82Qc2yC=HLw@mail.gmail.com>
Subject: Re: [GIT PULL] dts changes for cpsw phy driver for v5.1
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_055555_200185_8914DAD7 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 5:45 PM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 947b7802597106dcbef2ddca23d386f9339ba334:
>
>   ARM: dts: omap3-gta04: declare backlight in lcd node (2019-02-12 10:52:25 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-cpsw-phy
>
> for you to fetch changes up to bae2bf97939aebd74dfd8f0b76b4902a19e63eef:
>
>   dt-bindings: net: ti: deprecate cpsw-phy-sel bindings (2019-02-20 08:14:04 -0800)
>
> ----------------------------------------------------------------
> Device tree changes to make CPSW Ethernet use proper phy driver
>
> We now have a proper PHY driver with drivers/phy/ti/phy-gmii-sel.c to
> configure the CPSW PHY. These changes update all CPSW users to use the
> new driver that already got merged during v5.0 merge window.

Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
