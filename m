Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072CBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:10:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82BF20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q8KfMytn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0pN0xFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82BF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kC2ciluzWqJAYE19dQzSgGhUye9UjYpzqbFizv7HNaY=; b=q8KfMytnqcgDOT
	5secU9HV8X4E8qvXrr2aR0Irn5FE4Y22ASz8Lo4hn8hgVIdINet6ApoJboLtElxzd5lMwL8h6Gg3d
	OrvvM8CSu+DIae7qiCAtM5Caq6yPDNkRfA+uT39lPoiNFCuVc4ILO0mayRtmlDsgJXYRQ9OKOOZeU
	QIPrnTzIJMuHA921A5PwJoVWbe6rQFfvzjJOrnuvC7AIR6Ly9wUddid1wNZbRoqA0CS4YtOww07R2
	AHbn44Z1yFAih+jZQ0BaH470p6798WvXOlUbvudvRLDGa0R9E9udvPXADp4gky+74al6htUzmJvqD
	nUP7w7ieV/cDcTHKg4TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUrXj-00030J-O6; Thu, 06 Dec 2018 11:10:07 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUrXh-0002DW-0y
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:10:06 +0000
Received: by mail-ot1-x341.google.com with SMTP id 81so58935otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 03:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MsbKvC3dsLuKuLrjIpJKbElmmt5kYOSNKeq+ipXgjJ8=;
 b=S0pN0xFg8GHIlmGU3OvDu3N+NbpgKQgh8EaRo8aX7NdAaNnWAFFhFC/vjT3mcROYxT
 CNIdMZl7uRezULj4aSsQwMTT6yO3BDTwvbDCs826Ju29zCgujPpWj1ou2C+G/pqpoevu
 dyo3Y8qzrfDyBZ9bJv6HYFc1qDq//jeknPYQEKgw+GuSnKdDrC8lquTPPHgBgF8aiXub
 eKADFPX1JmGbVLw3uSzIjTPwoxzvGsg+yQ75+IHGgDGMh/cGL2q6t6c+XtkOqnilJYgf
 IAZMIhJmCbP7aY7FKmd/8lZ1Z6eia1oyXP68wEkYCvCm4qJpDDetrU4sn4rG7TkzZUWg
 Kdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MsbKvC3dsLuKuLrjIpJKbElmmt5kYOSNKeq+ipXgjJ8=;
 b=obt/2Zre68gWbB0E+PHYXfk/teLFK8KEyFKNVR2qdUeGZXiH++HBfwVxtafzuw2DKh
 WcHZcNutHpGFG45NoYUQjMxFqbuK0c24dlqAZWjkqKHuKQ2jCNSzQjsqMSAKpkW2UNEj
 tEBFG2S9rrnnr1ak7Luko0nwsELn3TSHKdAdxMtGTZ8yn2aXTCtiD5RS40/bsWBL5/Kv
 LzrqJtngTa8M82j5UwBVZWtUC2UNa7HVG8nDrUcPpPQDvGyK3+8+jY7lyueZisN7Evc9
 1jldmvB+YVl7mNzsGzWSnm/x4qjN/rXFlQmSKCMmRh8TMRQ2zb6Nk9O4cw5Jt4wKbuHd
 S5+Q==
X-Gm-Message-State: AA+aEWbCPRCcjKs9rOUvimK0P8Rw7gqJojm8Vo99Exw3OIBLG99lVqVK
 atUUSge06qHFs8IDr3rsCKZ6r2XbdA8dImu5R2Y=
X-Google-Smtp-Source: AFSGD/UflYCDRVA+ZIqCYf/BomfclWY5d1SNKbE3gasuXQoc2CwlqryVo0s0RbzGs4pQaVG1hLOXF6q9eNo2iU/Xn+s=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr15951694otq.255.1544094593665; 
 Thu, 06 Dec 2018 03:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20180921152726.31742-1-lukma@denx.de>
 <20181009105028.17971-1-lukma@denx.de>
 <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
 <20181206092255.2359f7e6@jawa>
In-Reply-To: <20181206092255.2359f7e6@jawa>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 6 Dec 2018 09:09:58 -0200
Message-ID: <CAOMZO5CE2ei-Pu-85zpYHTg-MamMT3DahLxBHNFjX4uLEi1XWg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device (vf610
 based)
To: Lukasz Majewski <lukma@denx.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_031005_089162_720D97D4 
X-CRM114-Status: UNSURE (   8.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>,
 Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 6:23 AM Lukasz Majewski <lukma@denx.de> wrote:

> At the time of development - I've checked my NXP related patches with
> W=1 passed to make. No warnings observed then.

In linux-next the warning happens without W=1.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
