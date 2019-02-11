Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E37C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:21:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CB520873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bmc97EP+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUK7X9XZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CB520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Es6jUY0yWgUDsf1mJmyZxBSBOle68nT2mz9x7K/+3cY=; b=bmc97EP+dyMU8z
	Ku83mb+huYoV8c2i/cCE7uQi0B8r/kG0zEHwuPBclagLfxO28K5T0zCPq2jIIoZeTzIPUjaurAtLa
	xtx1aKgA7x2Zugd3LC+RUGKYXGodDi9+C9yq277EKT2MrzBl7MkYP5MAdKcE2vAVfMaYM+9sH7+y+
	40kbvVA7rt1TiTyTi0L48akx9tB1eti+f4nRd7LyIfC4G6YKDAjxo6NugnxAGRvPcAxzy1Ap4L2nV
	gHj54A+OXUmEpQH0IY7BEfEfLk+dwpGk/vjolNp6WexU9GhHBJyziSd2mk/ettUcsPp7pp7CMr9zk
	0/JRKUpRPIgThxMFznaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt6pw-0002S7-IC; Mon, 11 Feb 2019 08:21:08 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt6pt-0002RN-VF
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 08:21:07 +0000
Received: by mail-lf1-x143.google.com with SMTP id g2so1732015lfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 00:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KAP+/QkaC/kPvD0d6Vhaj1cPtEZDAtF44P3YSanj1iM=;
 b=PUK7X9XZbvcnAXgdpuFDtpIDrpwjLcA7TAnPUkdEY+UPDT0CUCIU55KqiWttOC0pJM
 zpMRSwU2NSVK+YPmHLhNAbGjE6PSmc2Xq2o3/ULh96lol/yLCuBNig2Gd9ZFupJWxGts
 6gKaNq1tnlZlPak7R3c5tkMAeFkOO4nZKAAMof08U4Rup6Osp1yoFbukBN9amnyfa15V
 IUpb+ctuU4HL6IRC4pNW4exoYoOuQAK4yKLPdCOUryrUJS3l40yNMbfkzcZtiFgTVvlL
 krCqT38mUthOMHYq84FFCdNKSQdGLFcvzJjNl4y4uVI6qbJ+/fLe5Bk3VTzRawJqZmiS
 jT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KAP+/QkaC/kPvD0d6Vhaj1cPtEZDAtF44P3YSanj1iM=;
 b=Zk0ZWDok110bP0Wzq3PRMfUg1phiZOLRx1+bW8hqQt6YeuGvMFTGyiUhOp3JNxokqt
 7aJx/VN7Q+rfF+mKt8jHLPH0RHXlFREKr4yvGRjMVRuStQjSqlM+Vg5Le6eIaB+z064A
 tuFhRbV+N5YZ7SSpDhIUmlEGChXk55bSQLu3xhR0w+CPKWtPbXGGrVEydt9YjIbjuAK6
 C7U2YslTrFoqxjtf6OG0ncxYrvizz+Ymgbkv6Kd5N4c8RD1YxaobHLqSs4KDeanrzcE5
 Ys4tMnQyQNSpDDlWSSN0Dt3HsTVnbFhW9nHgDNWCaLC0AyREszw+ZP/i72rYPWxIdDsC
 iPkg==
X-Gm-Message-State: AHQUAuaMJ0HTQZodXTN9/ltO0nkf99VGYjgcJSLt4psvaMdfoCVqzzR2
 tsnzqzPoglZ8UqU2yl/WXkFHh/qsvLpqHPKOEGrKRA==
X-Google-Smtp-Source: AHgI3IYQC9maKJWT1HSMkW62nOsngFfw9sDT7x5S4Z+L6hgFGU8dAP8Gzu8PjowSP41wpHOEaWRlGwxTBf8gfOgEGoM=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr19203143lfl.129.1549873264141; 
 Mon, 11 Feb 2019 00:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20190206033239.3619-1-wens@csie.org>
 <20190206033239.3619-2-wens@csie.org>
In-Reply-To: <20190206033239.3619-2-wens@csie.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 11 Feb 2019 09:20:52 +0100
Message-ID: <CACRpkdZFwG9-ap3jMe+eGDCgzG9+fKRXVEb4Q=pWasd5GUs9tQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] pinctrl: sunxi: Support I/O bias voltage setting on
 A80
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_002106_006134_6BDFCD32 
X-CRM114-Status: GOOD (  17.54  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 6, 2019 at 4:32 AM Chen-Yu Tsai <wens@csie.org> wrote:

> The A80 SoC has configuration registers for I/O bias voltage. Incorrect
> settings would make the affected peripherals inoperable in some cases,
> such as Ethernet RGMII signals biased at 2.5V with the settings still
> at 3.3V. However low speed signals such as MDIO on the same group of
> pins seem to be unaffected.
>
> Previously there was no way to know what the actual voltage used was,
> short of hard-coding a value in the device tree. With the new pin bank
> regulator supply support in place, the driver can now query the
> regulator for its voltage, and if it's valid (as opposed to being the
> dummy regulator), set the bias voltage setting accordingly.
>
> Add a quirk to denote the presence of the configuration registers, and
> a function to set the correct setting based on the voltage read back
> from the regulator.
>
> This is only done when the regulator is first acquired and enabled.
> While it would be nice to have a notifier on the regulator so that when
> the voltage changes, the driver can update the setting, in practice no
> board currently supports dynamic changing of the I/O voltages.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I merged the v5.0-rc6 into my devel branch and applied this patch on
top now.

All the DTS file changes should be merged through ARM SoC, and
they should work fine now.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
