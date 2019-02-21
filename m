Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA399C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:14:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEF120855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zi3+YK5x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR+1Uru/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEF120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t/ke03WjFKgV5mxTtjndJ11gaB+ef1soAnkAzH34v4A=; b=Zi3+YK5x9kQpub
	n8wd0TCW04pBxNyuW4VYkuqBHJTJo4Sa8/jT0MjjvSiYNb/WPBUuyN+kb/SkcGubum/VmAKk8U3UM
	e0wJJifLVvp1YOVrHkUOFUap/spVh34Bcfa2Q5nWzBew2SmL2gyxDGpbqDw18Hxc5Gyz8dNtAgAcA
	nW9sqAqx5eg2/0tB3dsLYdA47xBOCOaJ3ReDUJHy1RNm+d1ZzFs7NO5oodfOdhvEFuhzfGTW24rFR
	fJYuF/xZmCD1Mz9Tols9BpolIpcdurHEy4hSn5VrnhZXlcBuXT3NiMKKE1NNQxk8wBGbcZvuCsuBw
	tGLPTcrkj0DeNW66XsMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqzN-0006mZ-23; Thu, 21 Feb 2019 16:14:21 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqzK-0006mH-7r
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 16:14:19 +0000
Received: by mail-ot1-x343.google.com with SMTP id i5so45319285oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D9du/BYN4tAL6NkC3F4GoNH69QLNyyVCBAvKlaiSCNM=;
 b=AR+1Uru/DdwHmdzvpCV9BoVMYU0P8iLC3BAwGskErAgkWYZkZvr+AtUY3JUeZWgLy7
 AoypAiPdqdHvCeneLf65LY8DnsPoyEAFxb97kkP4LljkyHi/r++3BLU5PTU9f4SioeDm
 vnT188CxFWMtNJ3ks59mi44tqM/SMBMuIctmhICDdoHwMUPQ6sbUWi/oPV6XC9kJZgal
 8vsjO6PZercz1xOPg1ZKEy/RTIPI20ArgeHa8/jL/A0lR9yqmjBqLi4Fnpz8/2ZggsXj
 fGqgr/ti6OezdrsiajetbB049MHbSW4A/KqPaySAmoJ+T2x+LmZiteM88vg1YTj30Fqp
 la7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D9du/BYN4tAL6NkC3F4GoNH69QLNyyVCBAvKlaiSCNM=;
 b=ulMhl0EsYxuq5D6HHqcBPmZbGXS9eykISvtWNP4ZW2lejl+mvobL9zK+k0rVW43WEG
 sgWVfxXkzLoMuu+6nh07YzbMmqgsp/mM7HPrsug9OO2H9AzcZFUCBXn9PlaHhUimGNZB
 N5ca8MvwzC56KQHcuH0JenvMgyhFNJNXNsteR6O8OU/Yvfrqtf6KpKPbgUUoKLcNbJnF
 xhLlADHR3Aan6ofpVRfOzsV6iZ49+f2TSMKsdmrcvSajyf1azC8y53Ynj6Z49YF9I2zf
 fVUzUbjPOGnqWce/BT7Q9QEtasGuEKUXICevUEOlY4GOhwiyeK39kFyLUneb9GH+oBat
 UkXw==
X-Gm-Message-State: AHQUAuZ7bJoeUBK98yk1v6PsvaGVYz3cITPFR2w5dEGhvW6ZyCZ2lIjl
 fONoRa76DXtEEhUEx3qXiOcRmqxZAEqNdUQvjtc=
X-Google-Smtp-Source: AHgI3IYzC6zsfpyyGZ5P3XPD3JiKv4q043PpeB6Gb9G3CEK56TI6N3odYaOxBmELaR7Zawbw7e2YnIxuGFoiVUrUFz8=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr25438040otk.203.1550765656345; 
 Thu, 21 Feb 2019 08:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20190221152459.axrjce7yqkjmedgl@shell.armlinux.org.uk>
 <E1gwqlS-00053l-QU@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1gwqlS-00053l-QU@rmk-PC.armlinux.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Feb 2019 13:14:04 -0300
Message-ID: <CAOMZO5B_ELinMtAipaM9GP3Frj1YxRA5DmL-RJYnSE5i_W04uw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-gpio: fix SPI_CS_HIGH capability
To: Russell King <rmk+kernel@armlinux.org.uk>, 
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_081418_300326_F0871642 
X-CRM114-Status: UNSURE (   7.88  )
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
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 Mark Brown <broonie@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 1:00 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
>
> spi-gpio is capable of dealing with active-high chip-selects.
> Unfortunately, commit 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE
> support") broke this by setting master->mode_bits, which overrides
> the setting in the spi-bitbang code.  Fix this.
>
> Fixes: 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Patch against 4.20

Adding Jonathan who sent a similar fix recently:
https://patchwork.kernel.org/patch/10804855/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
