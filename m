Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2CFC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:06:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F5520868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MBq+dNVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F5520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E8yrVBKb6GAowmEIBskpSs9kHfHHVGWZQ4mAor7UcxU=; b=MBq+dNVZybp5HJ
	KLpfh4/VCF8A7sVLpbcfFR9n1fNCEJ064FtqxsV/L0t6dxUhh6cDYIPvP57cFQ4PNQVYE6N/Z1ouM
	wQBFV2GsXuwxu+F3q+5ffUP1LhgN6rs8iGWBha+bcs2QLc2KsubqPktjx2fsKCpHQOS6mJQZOPPYu
	NzXV1XOixyGxKbbXBRPzP3Qo3EE5/Rkzmg9n2d/+Znktn3lZGD6WM+6zrqu/8Cc56tQv2HvHyviKS
	ZCvfmObl5wE/YJiLkNH0rB+YwlzN2+zFsbubHJYhFftKqTz+BCnd+0vepry22lqUyXzu4toqnaXLH
	F3hEtqVqt7yANJ9719Iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSSZY-0001Ex-BA; Thu, 29 Nov 2018 20:06:04 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSSZR-0001Dc-8z
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:06:02 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id F0CD68171;
 Thu, 29 Nov 2018 20:05:48 +0000 (UTC)
Date: Thu, 29 Nov 2018 12:05:43 -0800
From: Tony Lindgren <tony@atomide.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/3] ARN: OMAP1: ams-delta: Post-GPIO-refresh cleanups
Message-ID: <20181129200543.GD53235@atomide.com>
References: <20181107201746.14705-1-jmkrzyszt@gmail.com>
 <CACRpkdb5=2iAaZfLfzuGm9EhHwZxXe4E7-yB28Dn3LAxnyszNg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdb5=2iAaZfLfzuGm9EhHwZxXe4E7-yB28Dn3LAxnyszNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_120557_353219_1FB3DEF6 
X-CRM114-Status: UNSURE (   7.34  )
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
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [181115 10:46]:
> On Wed, Nov 7, 2018 at 9:16 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Janusz Krzysztofik (3):
> >       ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
> >       ARM: OMAP1: ams-delta: Drop unused symbols from the board header
> >       ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file
> 
> This series:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applying into omap-for-v4.21/omap1 thanks.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
