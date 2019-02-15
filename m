Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D46C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:49:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426942192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="INU6n/N9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426942192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XdMeB4FURjXmo7R/rPTI2taLyqiUvVIN9rNJvLgwm+E=; b=INU6n/N9vPmU3V
	74kRvFGL8gwC3MUpaw+vAsxbza1pRf0v3nG2XFcOIubg2GqDABsOhXhgl1Wbe7GBXOIqkt3mE1enW
	QItf3ImouYf10XiXO0ck6XjrsaZs8VXEOdSHmVmWTcfRnSlBBfiwOdndB+cjqtLg6WlweVKi1K7dc
	OrVlgKbRRyGcF4MTMwLTdOYffa+Fep6mkghjUz3UNfo65abS1YcpopEsWd+1UdJ1gW6qKnkqnmj6l
	VYta614CygNIbSOT670zLO+YOs/TpKiZ6Pf0287txjG4+P40n/H9yEw9MIffDot959u/QtqZbnMon
	5oz/27wKjAHe2vA/pDPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueoA-00069v-Pn; Fri, 15 Feb 2019 14:49:42 +0000
Received: from mail-qk1-f178.google.com ([209.85.222.178])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueo7-00069X-4B
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:49:40 +0000
Received: by mail-qk1-f178.google.com with SMTP id a15so5851197qkc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ls4TuvD97ikE+e3QT4DuO6Sck09Xcnoh+BEr5oId9DA=;
 b=cZZdgcaZsSVxR0+gIPn4VaOqVnY8t7DK4OUZRxwJQzDX2dSQAEL8T0KroYoPaxXG7K
 Ou/Wbt7/XgZBCPy5xdoDsmuM7DKhQxWr8STS4Znt1K3x33ptEkonI5GyLbhp4239jJff
 ZWK41H/AJWmVVi/xWV3qNaoTrDyPgeaKpQnCNBWTWi0l9RfGGswjP11ts9urImN0aQWc
 zCGu8MQj8FyGkLzfWwssYajD7jBj918nPEbb1QuM6f4YXVqQszHrA0R72vngaFtkUz+d
 8Bwc5mF3mwHzR6WaEmtTb5pWJRGJy4VGLX9rmSL0alUOt7hRzgJCFqlYgdNBjmI1DhO8
 FRqg==
X-Gm-Message-State: AHQUAubplUA4y8pI752fivNDGbYfC+7KbZQ1LXfFwGlXlWLqN9LnJQoF
 HGLnTuPBf+ZHbUNY061vFPHKZscXt69okFLCJ+tuaw==
X-Google-Smtp-Source: AHgI3Ia/9H2F+WloxiAKHfZv4GYot/sFYBE+8h5fbwc4EFp+jaQ1Q1AMSTwb0ldjcg/+dgpvmfai0G8vkMtm7NxyOg8=
X-Received: by 2002:a37:d492:: with SMTP id s18mr6912080qks.343.1550242177818; 
 Fri, 15 Feb 2019 06:49:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549623128.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1549623128.git.horms+renesas@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:49:21 +0100
Message-ID: <CAK8P3a0kYxNOU9PRWwAXJf-u49Ozu=vnL8KFw6HYOqHC-YBHgg@mail.gmail.com>
Subject: Re: [GIT PULL] Renesas ARM Based SoC DT Updates for v5.1
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_064939_163736_42859497 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 12:14 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> Renesas ARM Based SoC DT Updates for v5.1
>
> * R-Car H2 (r8a7790) based Stout board
>   - Convert to new LVDS DT bindings
>
> * R-Car H1 (r8a7779) and M1A (r8a7778) SoCs
>   - Describe HSCIF0/1 devices in DT
>
> * RZ/G1M (r8a7743) SoC
>   - Correct sort order of the RWDT node
>   - Remove aliases: should be defined in board rather than SoC DT if needed
>   - Remove generic compatible string from iic3: it is not compatible
>
> * RZ/G1N (r8a7744) SoC
>   - Describe LVDS and DU devices in DT
>   - Correct sort order of VSP and MSIOF noces
>
> * RZ/G1C (r8a7747) based iWave SBC
>   - Enable RTC
>
> * RZ/A2M (r7s9210) SoC and EVB
>   - Initial support

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
