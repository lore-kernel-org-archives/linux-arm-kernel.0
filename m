Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B963C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:17:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DFE2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N8Em+lnZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LD7BUv/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DFE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8aiU0GAUQZDikPizNsBdJ/Gthk//8srGanQkYkxdwms=; b=N8Em+lnZZnna7w
	ailmZCnu4BG8iUwyHl63q8Lrb+F68OVeRNeEIMstXhIstFnMX63I2kctIDzDVP6JZNUTN7pbdb3FU
	g3Tb3iFKqLw5uUYnnd3sVYFglghV+JCMrf8Tq/5uhztZOo0U9uzLEs6AqvcDkXrRKVidC/I/HRb3R
	FDyCr8/8I+cWVkx9Ks68AFQBFWX7rNO4PVoLxhsbL11C7j+3/tqCxMQve21q62CaS0+/AW6LRRC6X
	f9xqPU79G7zfZVyFW0jUdDIIMPMsSIYMGRnqeO3ONkXnFTIizMzpvnA51LiGM972T2Dh9hblt9Qsm
	PMgkUqCou7x5MKYV7KEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj3zA-0007kl-DL; Mon, 14 Jan 2019 15:17:08 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj3z6-0007kE-91
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 15:17:06 +0000
Received: by mail-lf1-x141.google.com with SMTP id p6so15893184lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 07:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+Ead8LSWG66DphT0GLyzfFRHfp2cmEwD0BAU+nVi378=;
 b=LD7BUv/wG7xDyC47T+6D8/d/xO5Mzy2eH7bmx5svjDtl0ZPuSjt7Rc82NM6Ts46tq4
 xM1AJlk8hqFyL1sN8+J21mFqRLNkNySMjvgszHcTnXL5TWYMjKhaaPQrErz600xYHl/r
 rIGiYmvU6+6nNwwmhPuUIOJ9vWvCopomZCOT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+Ead8LSWG66DphT0GLyzfFRHfp2cmEwD0BAU+nVi378=;
 b=pIFxq7Ix93yUv+EU9/GsxMJt/qpr+fxeFQ8fZah0ckentK6ra7V3ZWcuN6YGRR6aR1
 PieKsSQmfE2klIM/yQI9RwxHUNBr3N0k/4rdFpx5x7qf6vz1XT6ZHSYjEyxmrpYzJpeS
 qeubUD68Ga4znF0Txw+BmrOai16owxMX1oYxJ8OFC7mXOxKfeozd9Gz9hI3MdK+KMP0H
 DUB7Aojx3jauKlxz2vLqbscUrLo2Y2zbXD2Ev5LUMOnkpAIg9hFuW3cIxW6IucyTUEwt
 4iXPK65/hGCnZKk88qAld9TsiCtWUnj7gC0HNe6RFepIaL0cfgngW/bfxQBeBZe3fFqP
 DRjw==
X-Gm-Message-State: AJcUukdsa/ufyrGl1WZOys3q2v252MhcO8tWANMGmm2lPdK9mpmTUGrs
 tPDMRHFHoWPb3KebpdZ2/i6vn/DajFlJRZdyCCl46DeHoKc=
X-Google-Smtp-Source: ALg8bN6baeAcO2Y4iwM/cwg8J9P8BijOQY3CwAVhwt+ksxWZpz8UiiolIKzvyrOTOE/7W9qAXajM6tBeRvM5j8rK8JE=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr14614209lfa.32.1547479021918; 
 Mon, 14 Jan 2019 07:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20190113095723.25295-1-wens@csie.org>
 <20190113095723.25295-2-wens@csie.org>
In-Reply-To: <20190113095723.25295-2-wens@csie.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Jan 2019 16:16:50 +0100
Message-ID: <CACRpkdbJRV2hL2gZ84izY_30XCdWvXZ7T5pzxNHJTqLPk2BWzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: sunxi: Consider pin_base when calculating
 regulator array index
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_071704_318397_E78F2EEF 
X-CRM114-Status: GOOD (  13.23  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 13, 2019 at 10:57 AM Chen-Yu Tsai <wens@csie.org> wrote:

> On most newer Allwinner SoCs, there are two pinctrl devices, the PIO and
> R_PIO. PIO covers pin-banks PA to PI (PJ and PK have not been seen),
> while R_PIO covers PL to PN. The regulator array only has space for 12
> entries, which was designed to cover PA to PL. On the A80, the pin banks
> go up to PN, which would be the 14th entry in the regulator array.
> However since the driver only needs to track regulators for its own pin
> banks, the array only needs to have 9 entries, and also take in to
> account the value of pin_base, such that the regulator for the first
> pin-bank of the pinctrl device, be it "PA" or "PL" uses the first entry
> of the array.
>
> Base the regulator array index on pin_base, such that "PA" for PIO and
> "PL" for R_PIO both take the first element within their respective
> device's regulator array.
>
> Also decrease the size of the regulator array to 9, just enough to cover
> "PA" to "PI".
>
> Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v1:
>
>   - Take in to account pin_base when handling regulator array index
>     instead of enlarging the array to encompass PA - PN.

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
