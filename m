Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A30C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:57:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F6E20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fOXwC2kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F6E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pon158Nna6K2wdTiyOoTiDpZIeA/1SOSPoSIzaGcxZI=; b=fOXwC2kjTxvgjB
	J34I6XI6bvwN8h3eqvb20XyOedHn67+K8W6onNleeADZpROx4rwbwXqmsYG4hWBJ6wy2zNaaN0bwJ
	Cp/14oWniLmlWxeFDDNQpN4LQp+aAPwpJ/wPWfPntWA1BazM3532lgESMaK7rxsCYx3zmLOaNTWG3
	boYIEncNpXuAwTqUkdjzEeef1o/EtHb+xfnzHrtgcoo0zyfvRXbMXiEyKE9eYY/qvvZayO+1IhYhK
	vOYxNxyc6SjWGg3j6Sr6Td23kHLzppcCAE7qGslBhCZ/R5CyLobpr2vbh9h4U2t0gcJ664C/H+EvN
	X9sU6CL1U5dcWiP8k4og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotAg-00076E-CU; Wed, 30 Jan 2019 16:57:06 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotAc-00075T-W8
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:57:04 +0000
Received: by mail-qt1-f194.google.com with SMTP id l12so234162qtf.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZyySyxst716BYhl3b54MOUregaMJZronirzxjTN2QSM=;
 b=V6i5kNyBWgLzG9aicqURniHY+Fcv7fFNVamMQrZMCOCodXfAefcl/5MmRUWM+0P7SW
 X4l2kGbe3JNI47bLh3B/5E0qpJWcpo7vIB548YRb0IlGY/YvLjHM7FC3pXrTI3mUXD8Z
 Owz+gZ0BCKTPVJIM8PCyd97loi1OFcM/2nHO8yJaYiNqHH/v7DUIhjlQSZSAXnVVqMv2
 wQ2owBuJDS3bmW2saZkmo6yB4a43FvxvekdXNYFey9fOWJIXojMKnfJxr5JYJxx+dRgn
 dJmPU+XAU+uV/IrxAMlOkxNKGPXzqlUbDGyuikH2AvTFyMC4+vJkHx/FLJ3ovepdwhlR
 mwIQ==
X-Gm-Message-State: AJcUukeei8laliurySJ++TtHow9Em7iGV3DXadMpvWSy/2u2cdGJBZGt
 B+HW0NQrguKXPj/EWB0VqpGMBXgKQiXGSMc9Jy0qjg==
X-Google-Smtp-Source: ALg8bN6kv7j5t59HR3wQ0h6ucg1UWgv1yoj/uvAQqM5E9msZhWfUTCIy7Cxy4tz9N/ZBZK8vpBPpkWGnaXAh5z3jlL0=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr28395301qvl.180.1548867422098; 
 Wed, 30 Jan 2019 08:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20190128021635.GA30661@wens.csie.org>
 <20190128022748.GA4728@wens.csie.org>
In-Reply-To: <20190128022748.GA4728@wens.csie.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 17:56:45 +0100
Message-ID: <CAK8P3a2F0FyJ0i=h1k0b1jgqKzA8ccdQR5HUMAGTE9yQ=kbWMg@mail.gmail.com>
Subject: Re: [GIT PULL 2/3] Allwinner DT Changes for v5.1
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_085703_031356_D6DFC72B 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 3:27 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-5.1
>
> for you to fetch changes up to 55533921301e83162584f87fe571545056d03e09:
>
>   ARM: dts: sun8i-a23-q8: Set compatible string for LCD panel (2019-01-25 10:43:20 +0100)
>
> ----------------------------------------------------------------
> Allwinner DT changes for 5.1
>
> As usual, this is a random assortment of changes:
>
>   - ARM PMU is enabled on the A10
>   - The first usage of the PIO pinbank regulator supplies added,
>     for the Bananapi
>   - Broadcom-based Bluetooth enabled on the Bananapi M2 Magic and M2
>     Ultra, using the serdev bindings
>   - Video codec added for the A10
>   - Display pipeline for the A23 added and enabled for the generic Q8
>     tablets

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
