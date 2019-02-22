Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E43AC10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:54:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6192075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uw1qbC3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6192075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xNNGXFedmnraClOrIAF/L85z9YyxGudLgesV3S3ZBko=; b=Uw1qbC3i/1qK53
	MIPJbFSUKiT1p89OXBP3URyTfgM06Ffy7wme6r861W2h+QOEYc41igXENK4KrIqzRPxg3J2HbnpLx
	IkAbvUzlS/M+CHK1Bp7VHhQLD4oeu2gITeAwK5gJ0G4BRyYwyIPNI6PrwWN1oxR6k/f8WcQ231lM7
	rdkbw48hek1Pn1VpRQgvYs6IfCItQJpk7oKoRCWmIVmOI4JjUijEBLDw7BRLGbek1wCOfVyDOhgue
	eqcyv8u8nmXkqmSbXGsxL/jxHm9uE/nhux+OXYuFtbzGqKkk891d99RexCuFlxgnrSPiM1cR9Qdfo
	ff4KQNTdbXW9PKUVmdSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBHq-0006fV-PX; Fri, 22 Feb 2019 13:54:46 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBHm-0006er-Kj
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 13:54:44 +0000
Received: by mail-qk1-f193.google.com with SMTP id c2so428627qkb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 05:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R0z66svoHb3PVefLWy6mk+uyzrxw2AjCiWbaeLDe4TA=;
 b=jyLK9hzjwHGHEgEYOjXlLLoT5IJTPGjCWO4jBQTbWxwAMqTm7fsDOZK614fATugeiC
 sETFhKVUExUm3QwpdRgOjgYoJ++CPcmpO7nzEvAkIeUHuqoE5Q0zXd8rVFewfNWvV83M
 a8cxf7LZIIFMG6awFR56Y/aW41seEeBaCidyX4yku2v9F2TTpoTVK9WIJxgb6cE17n+U
 mjZjQHlmuW6svTldIjE1stxAKgGJ7LsM+jOjfvgrwyIrul8fQg9IIHp1kNtPtMIdQxgv
 AO+FygqSvG5LSHsqkaiqKnOeYBJpHFIPYExHb7iZabYPLEgn+FzZnkXu0sU+5PmxaHiO
 P2UA==
X-Gm-Message-State: AHQUAubOhmwrGuBVQ6FLs7wlXCPUe240e6AqZyJ3zzh2pKUub4G6lDuL
 kFF55UyIYhS5H/hZlB52nOMj3WNTM6xZeBtdOWE=
X-Google-Smtp-Source: AHgI3IapnucxzZQEPnhkIm+9hQ79NKn4ZQpksbQZ7kr3gkjBcoFYjd2BzF5DvkPZ75FDd6IqxjwyNj8VLrpAS0ZMlbE=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr3025695qkh.173.1550843677726; 
 Fri, 22 Feb 2019 05:54:37 -0800 (PST)
MIME-Version: 1.0
References: <pull-1550767433-845690@atomide.com>
In-Reply-To: <pull-1550767433-845690@atomide.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 14:54:21 +0100
Message-ID: <CAK8P3a1CMC-vDk_7UXJex8Y2hA7oGa5LCKeKTVKhG1h0CzS9OA@mail.gmail.com>
Subject: Re: [GIT PULL] two am335x ethernet phy mode fixes for v5.0-rc cycle
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_055442_678105_8C2BE48F 
X-CRM114-Status: GOOD (  12.45  )
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

On Thu, Feb 21, 2019 at 5:44 PM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 50d6b3cf9403879911e06d69c7ef41e43f8f7b4b:
>
>   ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug (2019-02-07 07:48:22 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.0/fixes-rc7-signed
>
> for you to fetch changes up to 0661465ec86e8ae28f09a04e51425c486d64dfb1:
>
>   Merge branch 'am335x-phy-fixes' into omap-for-v5.0/fixes-v2 (2019-02-19 08:47:17 -0800)
>
> ----------------------------------------------------------------
> Two am335x ethernet phy mode fixes for v5.0-rc cycle
>
> Recent changes with commit cd28d1d6e52e: ("net: phy: at803x: Disable phy
> delay for RGMII mode") broke Ethernet on am335x-evmsk, and turns out some
> device driver fixes are needed.
>
> Even without the driver fixes, am335x needs to run in rgmii-id mode instead
> rgmii-txid mode. Things have been working based on luck as the broken driver
> has been configuring rgmii-id mode. Let's fix that as that way things work
> as they're supposed to work from hardware wiring point of view.

Pulled into arm/fixes, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
