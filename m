Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E82C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:14:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BFA218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sy4oDHzd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWZmzo1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BFA218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3+lP2HIknAbI4cpopg4A+BtlaalJfWSigMzJR1GR4rk=; b=Sy4oDHzdRIhDNr
	EHMeNoGPMk+nbSd7xP8bVfe5tWA1IDthK9PXq4Xg1SQCvLQbcMCc+OJOI2N/r78K3T4aC2oNaD1lF
	LIqMg3rx973rW1t9A79jZOFV5BJHGByrzI54CUVSU6sxPOF0sj3XlYv06oepQrfQWVjB8yYOIjfbl
	mehwHuZAfaw/Wa1/oC3JV74/m5Tk5AThYUQJQQoslLgigud10ugO6Da8XpvtuHN+GyOj4kdNCi+3B
	H1i57F7gNkmUa7DdGJCwJM2j9ir/K34Rt1zDCwpXiX3uSZ7IMKMro3+ELaaiP2x9mbt3L5s0OMgcL
	/vxP1zFwltc3QRSP9ZxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grILm-00022e-DN; Wed, 06 Feb 2019 08:14:30 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grILi-00022C-3W
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 08:14:27 +0000
Received: by mail-lf1-x141.google.com with SMTP id m11so1095374lfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 00:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FzjpXElKQBdM56kmVWeTXpt5kVUsG7R3DiJdxJ0/xOM=;
 b=iWZmzo1uB4hraokSvpYhm4EUzoSAVrnW7SVqm46L06bMYZnJQkJ3Z79JMaIH3XFYMI
 zuAcHvYZmhpIhum9uOS5AnJvr2jejwgUkTvcX3PIrhvMa3DnIcrF70osLySNA7MFLT5J
 gW9c7JOYjMV1D1rE/OU4ql79zttC92uo8+J+ElOsjU74Z+bEHDOScitovq7wdo8CLuvM
 /5jr1BRo6wrTbFvBMr7zwIGyZw7HYh+faz/IjKw1j7Lcn+xF1N9tzjxBJBPQ/X4gqR+V
 EM+KQX5z9XO2hTnkRhcjiSoiSx1kgfGcUdo1OJLWGsYbOMaU34PfpRRh+BFYl9v8MHQp
 Ro1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FzjpXElKQBdM56kmVWeTXpt5kVUsG7R3DiJdxJ0/xOM=;
 b=S8W8CO9sjGU7ovY438+QH0RiAmtA9P01RMM1AjISCr/PYdhZbnetNaaQIzvn/VjI1w
 mtSnlQntvhMUptXuzDU5BqdJcLAqTry/3k06dstPFTiaW3ajA+zQaO3xebpyyk8yczMu
 Ac9+N8yz5oneIEfQKcfwS+xCUX7VYLS+e/RPL+UApV0ZK4FOUu8B/495t1qOFvq0kj3/
 SS35iKxKX78LvRzXRvs++Hm7Bmze4dsY9JSkzHKgSlDuqW4fuuXHNSdsjocbw/Ag+TCZ
 VAZYigPak4n2JdScLdcRlf58i/h0wgtvn9rJXiqGMTqFiiwSqzBmoTPEz66+2nP53CaW
 jKHw==
X-Gm-Message-State: AHQUAuZ4qAed0fY6nlyVThZ2ywCYapijXWduR0zIVllBzMZKF6JnVT7s
 0N7yTejKRE71xRQysVgNWzEmJWJtHje61hmLmtb25g==
X-Google-Smtp-Source: AHgI3IYxdckRquvcYP1Vfc3ApUor4WMg9sOYbQ3rWimmr3y8hJfGNl67dGVdlfRgHZ+Cd6rXIm+AfKL6eKQ52sL1y1Y=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr5997882lfc.27.1549440864049; 
 Wed, 06 Feb 2019 00:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20190206033239.3619-1-wens@csie.org>
 <20190206033239.3619-2-wens@csie.org>
In-Reply-To: <20190206033239.3619-2-wens@csie.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Feb 2019 09:14:11 +0100
Message-ID: <CACRpkda45Zhopkk+P9-poDut-gJdJg5POPGSa_Rt_wqE24GGqg@mail.gmail.com>
Subject: Re: [PATCH 1/9] pinctrl: sunxi: Support I/O bias voltage setting on
 A80
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_001426_200198_295B28C8 
X-CRM114-Status: GOOD (  18.24  )
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

Hi Chen-Yu,

thanks for the patch! I tried to apply it on the pinctrl devel branch
(for v5.1) but it failed to apply, I assume because it depends on
the fixes that I just sent to Torvalds.

Shall we proceed like this that I merge v5.0-rc6 as soon as it is
out and then try to apply this on top of that instead, so we get
rid of this conflict?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
