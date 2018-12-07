Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09CFC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:17:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B612083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IoFQ3I+W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK6UBpEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B612083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i0VJPc0qRDIXWiTRlLMFmMTmn7X3S7BW7F/tCH7e3BA=; b=IoFQ3I+WpFahkv
	IC4GNOS6A1xHZv8m1iBI07dwxY6xYinNzLdIZDXGNpLqS7ncoFQojoDVWZUrdP06RDdgIWm4p8jII
	2JzPAWRmdgmjCiYkQGPfgDXiTa4RAdvh71wiYrdhu+K+67wN+ia7rYYMddafmJeEM0V6i9LFqNGwt
	glOIhIso/OU+TZWqtIRE/GDN+9Mfj2JPHD4vSjNDtXCUXuZDhnmWuG6fRP5cZm63V59UkEWCW7CDr
	fo/KwNvofzvFJrDB/KPDYFUBCPx3hs7zoFTJy3q2yfjZTVMtM3GUNUGNm2igMumR4PfSsfR5tOo2m
	p/IfDDJPs6EIvs9OdYsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDCD-0007Zq-96; Fri, 07 Dec 2018 10:17:21 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDCA-0007Yi-EB
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:17:19 +0000
Received: by mail-lj1-x241.google.com with SMTP id k15-v6so3061820ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 02:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u2qwGeTgbyO8t9Qo41jExW00AZ74xr7wwI5DVv3f3KE=;
 b=GK6UBpElqng5YekyK5Pw3gUODbsP5BZoRKM82vgztarSH6e26Z5uscUFwcDEC2ktFu
 DmlYkmfY/ShZo7Mu1ijykAjL4Gr27tzxyxJq0uDe8ZdgIOARptXkuUK6P6oXYZ+zNVHO
 g2x7EsQoy2OaAQZiqGgfDTY0NOSO6a92DCqx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u2qwGeTgbyO8t9Qo41jExW00AZ74xr7wwI5DVv3f3KE=;
 b=WtXLf9Sqp3oFCMTrIEspBDDPWyTmOO1tBSCJD3YD9O6JIcipc4bujFvgeYyBA3lanA
 +kiNXNz3696yOe9XqqGD7zvdoN6j30mNJnstkzx6Zb4GQvm3010MVBSLW4ZaYw8jOoyE
 78ghzIcC7++ZfVAf9V96/48cMWmeVuctgQ23w2Kmxl1sYYLVjotd/MhS5OpnqA8ABc9y
 0NIgf21kTrH6R7+9o+C2gT0nqE99lG4cYFTjiOMnb5BAIBTR7tI/cd/M+iQe2vJE1dcx
 Gh/uMog2NZw5ZnpoHBn3/PbDh5kK4+DSlHn5bPX4GkMRl63NUda38JxVhYeMvYfRhIrC
 iEMw==
X-Gm-Message-State: AA+aEWZriUDoFa+oU0ngvfxT5kK0bg45nKh80IOdizeoYnpgnqx2sUGX
 AZy+ATMuGiohvDjHxMSxbg9UP8yFsN0PzziK7ihooQ==
X-Google-Smtp-Source: AFSGD/V2oLQ0Nuk6y6oDbva1kitnEUtEFEMc76OmaRzBcZ3uOfEAcwLOij/Im8eHymzj4xaT5pd5dA9up43dEtWbVww=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr853645ljj.120.1544177823765; 
 Fri, 07 Dec 2018 02:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
 <20181201165550.51a78366@archlinux>
In-Reply-To: <20181201165550.51a78366@archlinux>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Dec 2018 11:16:51 +0100
Message-ID: <CACRpkdaHSZ-WSGo+CcCrMPc=z4Ofy6oG3kxhTGxQJABEw2DF0w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To: Jonathan Cameron <jic23@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_021718_476956_46EA6887 
X-CRM114-Status: UNSURE (   8.75  )
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
Cc: "Kim, Milo" <milo.kim@ti.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-aspeed@lists.ozlabs.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Peter Meerwald <pmeerw@pmeerw.net>,
 kernel-usp@googlegroups.com, Lars-Peter Clausen <lars@metafoo.de>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Kevin Hilman <khilman@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Kukjin Kim <kgene@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Joel Stanley <joel@jms.id.au>, Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Andreas Klinger <ak@it-klinger.de>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 ilucas.ms@gmail.com, matheus.bernardino@usp.br,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Support Opensource <support.opensource@diasemi.com>,
 Scott Branden <sbranden@broadcom.com>, Andrew Jeffery <andrew@aj.id.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Carlo Caione <carlo@caione.org>,
 eugen.hristev@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 1, 2018 at 5:56 PM Jonathan Cameron <jic23@kernel.org> wrote:

> +CC Linus Walleij as one of his files doesn't have a license...

Sorry about that. I am fine with GPL-2.0 or GPL-2.0+ on
any of "my" files. Feel free to add it with my Acked-by.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
