Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9091C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:31:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99DA20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BSFibmkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99DA20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FRPreWj2Pqhg3adIr24je7dPo8I6hjNGlmT0u+YSi4Y=; b=BSFibmkc5UFo4E
	1RtgEWtL5J5yLJSkkMLdhlxw8cvdXlP2baoJOFww/Dhves+ZYqZrNlZcPvUdPVZe2/z/b1phvR3EJ
	Kade3Szgjykzz/vghegpSFdNly36CTYe5Kl5Er/InRN5OumM3dLk9JiXQwyd9WD+8xz80Lfgfx41k
	4EqBPlpTVRBE5suOez+9JPr29SkLsQd0E77kITXpwqH4WjJgZl+NJm7bJ4sf9QB+eo2HqaBAVKKLm
	Di66CLPd7N8uEB5Td4oegdR6pUeMmtwEoTzR1f7CoRGxMngFxZasYX4GYNjgJWPxtzSAFcqd0Hbkc
	1K6W2WfPn+85bjBzO+Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gon9n-0002Ic-K4; Wed, 30 Jan 2019 10:31:47 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gon9k-0002II-6Y
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:31:45 +0000
Received: by mail-qt1-f196.google.com with SMTP id n32so25569588qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dihg4V3h1HvEAXXaXbPqcAxjzSPralhmiBIGbTvIWCY=;
 b=AgcewBO5b/C+p5RyYfa2k8249S9+z0+Wll3TvWT9pDMfu9NbF4B9RFG8djCvjda1Mc
 hjTtFy6ArqGgRx2z7+4bol4sP4rpFjN+JEebe8GycgSb97BcT7xZU3n0Fu2dutzenk+F
 V2rsQrc0cwPpEoYcRHQqP20T6IzvaGts2irsPEz7rr9mS0aP7a5GzO0BA1tfK985fuj+
 4alBWNbg1amn1FpthwtOBxWirTupNjRqRogcbGdclX2ge0nuZQomFPDM6CIj5kFZQ7Kv
 jPlbPpXiLAsv3ykig4i075IuVg3OndUX5pSRr3zXzpiCKqp4SkJKK0txRXmKpL71jZh8
 21ug==
X-Gm-Message-State: AJcUukfFyfl917vaArGF8hjsRpvYRKjhF2COcFvn9Yypu5kPV69gtHq2
 1gTQOzlC/BCX9ZM2CMMhLGeZKO8FmoKNVI+sbI0=
X-Google-Smtp-Source: ALg8bN7SRVhA8IS3KZvLxUXtOhWDXx+uMue+NKoiCmY2y1fSpMcd4lEXs113wr5SxfHy3mgPVbF0Sv/n02AjVEGf7AI=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr27364171qvm.149.1548844302980; 
 Wed, 30 Jan 2019 02:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20190128021635.GA30661@wens.csie.org>
 <20190128022558.GA4564@wens.csie.org>
In-Reply-To: <20190128022558.GA4564@wens.csie.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:31:26 +0100
Message-ID: <CAK8P3a1KQbyxBjyoqtVsUd+81rK4z5ou6tawDY3Zh-YjYdPGOA@mail.gmail.com>
Subject: Re: [GIT PULL 1/3] Allwinner Fixes for v5.0
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_023144_238388_32183280 
X-CRM114-Status: GOOD (  13.09  )
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

On Mon, Jan 28, 2019 at 3:26 AM Chen-Yu Tsai <wens@csie.org> wrote:
> Allwinner Fixes for 5.0
>
> A couple of device tree fixes for the 5.0 cycle:
>
>   - Add missing clock-output-names for the osc24M clock on sun6i/A31
>
>     The Linux clock driver uses the device node as the clock name if
>     the property is missing. The node name was changed in 5.0-rc1,
>     breaking a subtle dependency in the sunxi-ng clock driver, and
>     renders Linux unable to completely boot up.
>
>   - Add alias for Ethernet controller on Beelink X2
>
>     This allows the bootloader to assign a deterministically generated
>     MAC address to it.
>
>   - Add property to enable USB VBUS regulator on OrangePi Win
>
>     The board had defined the constraints for the regulator, but was
>     missing the property to actually enable it.

Pulled into arm/fixes, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
