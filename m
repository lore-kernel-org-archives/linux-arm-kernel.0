Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC2CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:23:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3C220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IX9Gf1RR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="FulObfOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3C220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9QGl4rcTUM66nN/PEkMJmhRz7TUlVoLyEGytcgRvKC8=; b=IX9Gf1RRRo2qOU
	ZQjDDUEql3nBlF6rn3TVJL8+CRBsWy+OWmcxJL036Bvs7X+TOYvAnr04npZBzsFeCO3ozMa9jB1N3
	jP94OW7zC4hb+BwWZ4k3m5WcI1tRsET28TN4WAZVyT1YGcjWGNmrIUOUDAWqwL0ciRHBe3PYg4r34
	5cU/GdKgTFvkQcyrIztO7c6ghYlWasbd4KXnyC9uCHj/DnzWb0TpKr4j949RbUldOaEt0QgjnXrIV
	/J5RsRbK9x5hTzMglHOX9elkyP08+z9Uu3BvXwJnNtUkaEgZnBToGRa17TC3LQZxmPmMHKxx0pvY9
	d3K2CkiRyk5ztjrhHEyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCuc-0005hv-7N; Wed, 12 Dec 2018 22:23:26 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCp1-0007rq-DF
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:42 +0000
Received: by mail-lf1-x142.google.com with SMTP id f23so14751857lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pvkDH88DFEKX+nlI5rRYs99WCfwACxaTtGEVX/qvs+I=;
 b=FulObfOWgF7Hp2vGWadFKffj8xHPEtWOj/mE64WJlh3Zj8+BvhgX4GGpaJm/w+qFfI
 lgKIAjF33+8osO/KG8LPfg+IipmShFumCE1s2YavhLLfASiJdE2WfjsSGKWd77vVhgBX
 xrvmZkekbJ4rGPE24aesliUpdm0KQllBHqQ/2hjnewaki8b5nagvIbNa5DzXN4q2CVJo
 55RnTfmbB019TudGgc5GbCuHLnEMoia0oXfFog0g51X8dGM1k7aBZYtwLnJCRNA8oUr+
 Dx5F0mJ5H7xrY8BOcpyr0h8+FZ8gNH//CzMS+L+JjIwYScNArgNvVY3C/eDsys6ysqXI
 uEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pvkDH88DFEKX+nlI5rRYs99WCfwACxaTtGEVX/qvs+I=;
 b=lbvAT8YTZwea/xLFwHadu51UlUsqjf5NFo7+dIXjP2TMo6l5IHQSTXfbpwZtOJvmJG
 Yzrs1dVcwHq9ouQTR5jGvFy6qFH406XAIDoIJY8Rj8DF4IZctgxI7hnttlCIfhHcDwDa
 bwRbwRJtfoEPLL3XqwQRzSVnXEAaJB1CipAmtNijuliaEi8VSp5UN8jBK0l7vOCr0nTv
 uvmfgvWiftpvCIIFA2oB26/58MuUpQtUt5CPEkwwr7hkVEwUTyD4nqGooliT/+UpoY1X
 p6S9DePp/bzBEBH7gXCnZASdEiROJ4wEBUwi4JJBznMcos+2o85MA7nuZHEMWqw3soLu
 nahQ==
X-Gm-Message-State: AA+aEWaJDIm+PXDEu11UeA/w+TpxCk7aQ/Coa7yu3qO8GisvmgW/vlQt
 Lfcu/wygcC6U9w5GjHzN8NFTiA==
X-Google-Smtp-Source: AFSGD/XCcYUUXPt6DMdnRVXjMZNM4P5h0/BQnFz7QwYh0YMWMTYTUsDrzH6FU6S7CQ/4Px87+LTQ4w==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr13639219lfj.83.1544653051362; 
 Wed, 12 Dec 2018 14:17:31 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id p23sm2673lfh.47.2018.12.12.14.17.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:17:29 -0800 (PST)
Date: Wed, 12 Dec 2018 13:56:26 -0800
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] ARM: pxa: avoid section mismatch warning
Message-ID: <20181212215626.p5otg6g7l5lut5n4@localhost>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210215856.2238253-4-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141740_367521_610830EC 
X-CRM114-Status: GOOD (  12.31  )
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
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, arm@kernel.org,
 Igor Grinberg <grinberg@compulab.co.il>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 10:58:39PM +0100, Arnd Bergmann wrote:
> WARNING: vmlinux.o(.text+0x19f90): Section mismatch in reference from the function littleton_init_lcd() to the function .init.text:pxa_set_fb_info()
> The function littleton_init_lcd() references
> the function __init pxa_set_fb_info().
> This is often because littleton_init_lcd lacks a __init
> annotation or the annotation of pxa_set_fb_info is wrong.
> 
> WARNING: vmlinux.o(.text+0xf824): Section mismatch in reference from the function zeus_register_ohci() to the function .init.text:pxa_set_ohci_info()
> The function zeus_register_ohci() references
> the function __init pxa_set_ohci_info().
> This is often because zeus_register_ohci lacks a __init
> annotation or the annotation of pxa_set_ohci_info is wrong.
> 
> WARNING: vmlinux.o(.text+0xf95c): Section mismatch in reference from the function cm_x300_init_u2d() to the function .init.text:pxa3xx_set_u2d_info()
> The function cm_x300_init_u2d() references
> the function __init pxa3xx_set_u2d_info().
> This is often because cm_x300_init_u2d lacks a __init
> annotation or the annotation of pxa3xx_set_u2d_info is wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to next/soc.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
