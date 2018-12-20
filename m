Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F22C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:42:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7592186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G/P7I+8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7592186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ehUMu4rqRRkJ60hvDw9sxz3Vqcp+CY/V3M8+ocXnlrg=; b=G/P7I+8jQ3iNOj
	bdfMalFut2K/smcCL5NcXxDxAdPHff1FUF7OlhD1GsLKyq3YaRpy2U2iCi78ivhQBgr8eSRxFoVqH
	+t1nLiMZjoDW5SwXWVXqtVaK6FD27/KoZ0Xi9TtPHiLDYUqJzJN2abahk1JOpFXWYtaa68V2njGD9
	GaSwSxIAKvA60QAVj+jaYPMQVWFTSK+uO7KqETtf40f/OvfSxGAx5HlBQp6vG5GCXHZzwgyDmaPBd
	6AGMRvtn4yd1op95lTcXcjBccmXFV9QS0jvUL4mlvlFZ0LVGiSeCtaA7bJZq4n5SwcoNE5pcRRHqA
	jAm6kuQ2ET8f0m26RKBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga71F-0005wz-Dw; Thu, 20 Dec 2018 22:42:17 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga713-0005oX-Su; Thu, 20 Dec 2018 22:42:07 +0000
Received: by mail-qk1-f194.google.com with SMTP id a1so2018787qkc.5;
 Thu, 20 Dec 2018 14:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M5yVewNMCEuWqwKt7RGtu94TxkIpyukx9AL0sXO399A=;
 b=Pa6NMVtbRwRbpLSEPuChk/T7W7WQrPe/VNDbvXQDKOnPBU8HJym4AmQHuk30MV/sTx
 /HqCFqR1ahgb116OdntnjxDmtpTjam1/PuZ6sMIecY2DYrqZHhQXQb6MxHIurMIN6hi2
 sXfefAVjs0Pi4N6mJufcKyL9EklVUuWdpz0Vh1kfX0jiCHGfZm95ZHQcDlzuU/7+btdY
 zfcbrKUCFZgkohF4pF9WJpjM76tC86WeroxS065ggHFO7Xxr7JeKkjJFpJwHOlqso2Jd
 Uwa28eXuWTLkbnmsKRrwTqjNPwp9gevnI89jERTh/ydedhrD99wnSkqe9bOJGLmL25nH
 x6oQ==
X-Gm-Message-State: AJcUukeX39sIJzNbblB6Y/XQ7UFkOfBJoiQEc95Ou9v2x7u463gkt8m1
 huQHHVcbj/Mcr44xGCnwixGiYX+rqF9dtgs+cC8=
X-Google-Smtp-Source: ALg8bN6h1BVzDgByjESrDJWvHbPvIV2Il0t2io3cVK7A8qgutsNvHmdIhXiDmLmPuDjiDH3lwOq2ybsmQdSZ8Nd19z8=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr59680qkf.107.1545345714346; 
 Thu, 20 Dec 2018 14:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20181216084854.GJ13243@dragon>
 <CAK8P3a34R+Gv+H8_jjGP452i2kSqq+u0PsE-4pDnRRtY14SG0w@mail.gmail.com>
 <a73f86ff-15ce-9512-bbf0-be852cf39a35@kontron.de>
 <CAK8P3a1PMoR-WWcb_G8sTVW9HKUKvKfUZmcinkOEy9mJ5c=Lxw@mail.gmail.com>
 <6dde2248-da0d-7bd3-801b-b42b2974c038@kontron.de>
 <CAK8P3a0WCOcVjSegBKRPw3kkokE8S4JEXManqBkq4CjfcBRSMg@mail.gmail.com>
 <CAMuHMdW1NsqEHWBBn77wTAYnXi068iT2Lo8rxUUSvbo5UHDTkA@mail.gmail.com>
In-Reply-To: <CAMuHMdW1NsqEHWBBn77wTAYnXi068iT2Lo8rxUUSvbo5UHDTkA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 23:41:37 +0100
Message-ID: <CAK8P3a0QxoNyq=5LzQObFnq2i7mVRJDj73j7ur+cQ9rmoKZpMQ@mail.gmail.com>
Subject: Re: [GIT PULL] FSL QSPI device tree cleanup for 4.21
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_144205_927532_A33B4D7A 
X-CRM114-Status: GOOD (  17.88  )
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
Cc: frieder.schrempf@kontron.de, linux-spi <linux-spi@vger.kernel.org>,
 arm-soc <arm@kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 7:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Dec 20, 2018 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Dec 20, 2018 at 5:23 PM Schrempf Frieder
> > > As the new driver is a SPI driver, the common rules in
> > > Documentation/devicetree/bindings/spi/spi-bus.txt apply and
> > > spi-[tx/rx]-bus-width are defined to default to 1 if not specified.
> > > So we can't set those properties in the driver if they are missing in
> > > the dtb as we would deviate from the standard, although it would make
> > > more sense for a *Quad*-SPI driver to default to 4.
> >
> > Right, I guess that makes sense.
> >
> > Now, you could change the binding for the fsl-quadspi driver to
> > require the bus-width properties, which would then just make
> > the old dtb files invalid, and you give us an excuse to override
> > the properties by adding the =4 ones, once that is documented
> > in the driver specific binding.
> >
> > Since it's only a performance difference, I suppose we can live
> > with the limitation and stay a little closer to the normal binding.
>
> Please note that a quad-capable SPI FLASH may be physically wired
> to a quad-capable SPI controller using only 2 wires, so defaulting to
> 4 may cause issues.  Defaulting to 2 may work, if the device is
> dual-capable.

Right, this would only work because the old driver used 4 wires
in the absence of the DT property, and the driver would warn
when it's not there for new dtb files.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
