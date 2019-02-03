Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F43C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:38:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6788F218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nvTKQ37L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="bRx940Iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6788F218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eF3mydfYAmfy/jrhskXT6xVk5KkvA72/Vh+A2isv8Ac=; b=nvTKQ37L7s07bx
	DiX7DJ8im0mr0HksDGa1F1X0aXA0vW+7aPu2bXuDr43/mfrPt8LprNtsGrhK7J+t2sqVI/OTTeRpn
	jYZdauZoYsgFuEspLCnUTZvKZIVkgk52DhdPvlVjzrQQgSHUjbejFAkW7tOMO6HlLbUzIfDf7G2pg
	vMwp6b/D6BgOqGEHh+gkFDHzuYu3ugq3rjGrydZTz91dgDK1hQjK0hL61Erf4RLQIhblY/dn9G0nu
	k/PInWCMBUdr+y3Kn5jZJiDED2RylqRaNc3DKXAHJdY2E0Ko3yklHVDykXHjvfORNPU87j/bjrgX9
	M5PrxVYtTDwT/h1r4Jvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqH2u-0003CQ-Is; Sun, 03 Feb 2019 12:38:48 +0000
Received: from onstation.org ([52.200.56.107])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqH2q-0003Br-GO
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 12:38:46 +0000
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net
 [98.239.145.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: masneyb)
 by onstation.org (Postfix) with ESMTPSA id 2996415F;
 Sun,  3 Feb 2019 12:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
 s=default; t=1549197523;
 bh=LnWd3+ePFENj6ZsFeGVxe5jvVDMl0xelnquHm1oI/vI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bRx940Iyr6eAQJkSaP0is0gdEzRDcPnJqyd1Q+1djsW1XFAGJfacKiUQKeVk8V5r/
 wp0Gptr6aoGyEMEHytL6jtu15FN7LNtQJvBifBlv/6b3VI72QL4riQoRNT/ci53IQS
 urrXspi+6FtVsuiXRko+cuvowlMO9eohrzFQaAVk=
Date: Sun, 3 Feb 2019 07:38:42 -0500
From: Brian Masney <masneyb@onstation.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: next-20190201 build: 2 failures 19 warnings (next-20190201)
Message-ID: <20190203123842.GA8069@basecamp>
References: <E1gpgTf-0002ZN-NF@optimist> <20190202153954.GK20797@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190202153954.GK20797@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_043844_610346_80E3C1D0 
X-CRM114-Status: UNSURE (   9.16  )
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
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, David Brown <david.brown@linaro.org>,
 linux-next@vger.kernel.org, linux-gpio@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mark,

On Sat, Feb 02, 2019 at 03:39:54PM +0000, Mark Brown wrote:
> On Fri, Feb 01, 2019 at 09:35:59PM +0000, Build bot for Mark Brown wrote:
> 
> Friday's -next fails to build an arm64 allmodconfig due to (among other
> things):
> 
> > 	arm64-allmodconfig
> > ERROR: "irq_chip_set_wake_parent" [drivers/pinctrl/qcom/pinctrl-spmi-gpio.ko] undefined!
> 
> due to ca69e2d165eb3d060cc9 (qcom: spmi-gpio: add support for
> hierarchical IRQ chip) as the driver can be built as a module but the
> above symbol is not exported.  

Thanks for the report. I submitted two patches:

https://lore.kernel.org/lkml/20190203123131.28323-1-masneyb@onstation.org/
https://lore.kernel.org/lkml/20190203123131.28323-2-masneyb@onstation.org/

I just realized that I forgot to CC you to those patches. Sorry!

Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
