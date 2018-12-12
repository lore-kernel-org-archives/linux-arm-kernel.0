Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A97C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:27:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C9420672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jIjJ8ZJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C9420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sRHk+zJYfyEP8FV5OZeJvheqkwRcUXIaac7I291i0eE=; b=jIjJ8ZJ+LyMhMd
	HgZ9R8Z5W0dWF0fnP5NipFC2ZOqbh4Jhy+tlG+Tmpa9YS459mRJH8vvTcP9ur7VJJO6gAnDlgYiKD
	T/OyV3HhM1Kq5VjAqlvPjj1hdcRbFhEwg1nTlCvqCeScuGXHPbXEfTzF6+tDOtiFqycwx80WEf9mt
	Q4uN6hNvYYYSfLGB449/NYXEagEODHIbSkqgF+/91qu9ZmH3vb8Q5jHfZ6UufIWemdnwquxIqL55m
	4QJw0uZl+GCHML7p5X39JJXtstqHeC0GOY2udNVJC5vcA5fMC4qOyPGZKBfJmDf8JMNIm9EdQ8PBx
	goNnF/oAjiBBtgNMc/Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCyV-0008V9-JN; Wed, 12 Dec 2018 22:27:27 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCyR-0008U7-Lj
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:27:25 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 993AA20743; Wed, 12 Dec 2018 23:27:10 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4ECD820723;
 Wed, 12 Dec 2018 23:27:10 +0100 (CET)
Date: Wed, 12 Dec 2018 23:27:10 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: at91: DT for 4.21
Message-ID: <20181212222710.GK19816@piout.net>
References: <20181211171112.GA30925@piout.net>
 <20181212210553.jk4uznjimi37fd7p@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212210553.jk4uznjimi37fd7p@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_142723_844669_01EBE5C7 
X-CRM114-Status: GOOD (  18.78  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/2018 13:05:53-0800, Olof Johansson wrote:
> On Tue, Dec 11, 2018 at 06:11:12PM +0100, Alexandre Belloni wrote:
> > Arnd, Olof,
> > 
> > Here is the DT pull request for 4.21. The clock DT binding switch has
> > been in -next for a while and doesn't seem to have any issue.
> > 
> > This is based on the 4.20 fixes branch that you alredy pulled.
> > 
> > The following changes since commit 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14:
> > 
> >   ARM: dts: at91: sama5d2: use the divided clock for SMC (2018-11-21 11:50:32 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.21-dt
> > 
> > for you to fetch changes up to d8007306f6ad18f2ba0dcad68ffe9b2fd1d56bfb:
> > 
> >   ARM: dts: at91: nattis: initialize the BLON pin as output-low early (2018-11-21 12:24:50 +0100)
> > 
> > ----------------------------------------------------------------
> > AT91 DT for 4.21
> > 
> >  - Switch most platforms to the new clock binding
> >  - Small improvement for Axentia nattis
> 
> Merged, but how does this affect downstream users who have out-of-tree DTS
> files that include the SoC dtsi? Seems like lots of stuff would break.
> 

A few may break indeed. However, there are very few clocks that are
actually exported out of the SoC (2 to 4) and they are very rarely used
(usually only one to clock an audio codec).
The other affected dts are the boards using the flexcom and my opinion
is that we should probably get the flexcom stuff back in the dtsi
anyway..

So yes, some out of tree board dts may break but they are pretty easy to
fix. Also, the DT ABI compatibility is not broken so I don't expect too
much breakage overall.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
