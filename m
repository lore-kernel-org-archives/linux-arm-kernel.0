Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F925C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:12:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6A721741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F13VYb4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6A721741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zly/gx10A7B8ZlZqn9c2Sbh5YD//x7ayxfIlt1oh/T4=; b=F13VYb4m5N4oBz
	XJuAmDVnOvARz4a5Vuru1PJUapCWtgYDD1g+LS6lGooG7SafaYAbFzls34rzQsqnz6DX/5VFirHTm
	lRzgMAcVEhnriDnFiiPOhik3o6FuJLKcq0baA4gjrOpyyGR2UpUK+DnkLJruQZWgjuu6yghp+9x6c
	9C9HD9qjRBjldvYhcORKjqHoazm2+QZFw3deSwdKwIo8J9i4rR6mJwZmQjqgfOJvaxVmgTHsTfNHm
	rviHzer7apeO6KE139wsrfS6slu7JjzNgt324VamN2orTQZm7zLyxdBcjVjW5YrIMt+PZn2ZMs3wC
	RPnCDpjQ07i33wiFqavw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0ve-0007G2-FS; Thu, 20 Dec 2018 16:12:06 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0vb-0007FC-Qo; Thu, 20 Dec 2018 16:12:05 +0000
Received: by mail-qt1-f196.google.com with SMTP id k12so2369774qtf.7;
 Thu, 20 Dec 2018 08:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ySbVfqX6pHAExjnwdf4S9uRAjrQJzC3kV0nQmfLdC8Y=;
 b=BeghVhD1vauQkSn/4bd0sGegk5+Ej4DwisceIaq8SXWX46ighgJbK4350leeq7bKpz
 tWQpWmlZG0Tyf/tXr8B8A60L2xnd6sN5sp1m5nIcGRVbx3H0DgYdldX/2WObv7eiMdJc
 lQn1E0J6IXUEr61WD7bAnsYdsNYq82rSfWsAEECUEGCauWQGwZuHuA7TJ94jJU/16M3g
 NF3KksE2C60kSEBtfYYS7TheQOLjMWoxsunMVp35APsmEJIZtPq8smqxm0/ZxvOuVnpf
 f+k88w/42GyPRpJIz8atiqtzYnBbD/UTaxvwr3jfk5F/rzey5yOJ+FCGqXkVq6btMx2u
 mNxw==
X-Gm-Message-State: AA+aEWadxor+oTsazP93ViT8HywAkaT7dyLgy4Y0Kqnn7dkQymAPWCLe
 mmoqyNpteIY3J8evnB43ivAYPxUhUMy9Orq0kvw=
X-Google-Smtp-Source: AFSGD/W9kvXBeW0pzcpXqrPBrN/wmtNhAHyJ6HbsnkLdN+brjyb6Geoa/awzugE+L6sfuvN4MQ+J+dWOsbMcejhzmHo=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr27223640qta.152.1545322312883; 
 Thu, 20 Dec 2018 08:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20181216084854.GJ13243@dragon>
 <CAK8P3a34R+Gv+H8_jjGP452i2kSqq+u0PsE-4pDnRRtY14SG0w@mail.gmail.com>
 <a73f86ff-15ce-9512-bbf0-be852cf39a35@kontron.de>
In-Reply-To: <a73f86ff-15ce-9512-bbf0-be852cf39a35@kontron.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 17:11:36 +0100
Message-ID: <CAK8P3a1PMoR-WWcb_G8sTVW9HKUKvKfUZmcinkOEy9mJ5c=Lxw@mail.gmail.com>
Subject: Re: [GIT PULL] FSL QSPI device tree cleanup for 4.21
To: frieder.schrempf@kontron.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_081203_862864_7C6CDA6C 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: linux-spi <linux-spi@vger.kernel.org>, arm-soc <arm@kernel.org>,
 linux-mtd <linux-mtd@lists.infradead.org>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 5:03 PM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> Hi Arnd,
>
> On 20.12.18 16:50, Arnd Bergmann wrote:
> > On Sun, Dec 16, 2018 at 9:50 AM Shawn Guo <shawnguo@kernel.org> wrote:
> >>
> >> Hi,
> >>
> >> As the series cleans up both i.MX/Freescale arm32 and arm64 device
> >> trees, the pull request is based on a merge of tag imx-dt-4.21 and
> >> imx-dt64-4.21 that have already been pulled into arm-soc next/dt branch.
> >> This comes a bit late, and we appreciate it if you can pull it for 4.21,
> >> as it paves the way for new QSPI driver under SPI framework to land in
> >> the next release cycle.  Thanks.
> >
> > Pulled into next/dt. For my understanding, what is going to happen
> > with the fsl-quadspi mtd driver? Will it remain as part of the kernel
> > to support old DTB files, or will that transitions mean those stop
> > working with new kernels and have to be updated the same way?
>
> Thanks for pulling these late changes. The old SPI NOR driver
> (fsl-quadspi.c) will be replaced by the new SPI driver. Old dtb files
> will work with the new driver if they already have the reg properties
> set up correctly (which should be the case, but who knows what setups
> exist out-of-tree).

Ok, good.

> There will be a performance penalty though if you do not set
> spi-[tx/rx]-bus-width to 4.

I guess that's acceptable, but what is the reason for requiring
this? Would it be possible to have the qspi driver add those
properties and print a warning whenever the dtb doesn't
already contain them?

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
