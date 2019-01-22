Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3730C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:25:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B8120879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lWLy98uD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B8120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1MS5G9cS1X1dHeqgvebcwmOQUpGJO57TsD1orBOEXEI=; b=lWLy98uDpOKInm
	MLIBx15KCFF0BtZQaVCDpeoNo7o1u3/CzgtZWEeei59PyoZVXFE0FVhpmW6yczk/8dSPQ4Iao/Su4
	jkGlg1i3v0mthQlsv5FURPhKbc0xwwMkJejQHUiyohDYOJIN5ze7I0TdhP59Q5Twq/SZs5JrW5CaQ
	7lbKl2Ql/ZyR9Ea30kVUuAZ3Ra7iSp6DNr/MBsZ/RWV6jkVlp2m4oJTTwgGP3HcJLEe44gUJ5/8ec
	IvQHfVhA0qc1v02y9y8l/Y7EzY1O6MpwPMYTdYfljpqDGq/zL+XqrD7vf7VDq5KeNWctFPiOchnxj
	4zvJXHGrj8BO+y2+y/6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glrNX-0005My-5E; Tue, 22 Jan 2019 08:25:51 +0000
Received: from mail-vs1-f66.google.com ([209.85.217.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glrNS-0005Ma-RA
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 08:25:48 +0000
Received: by mail-vs1-f66.google.com with SMTP id u11so14172951vsp.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 00:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hGyal59jfKp30RrP9BL3MHd18FnsPFo4l6O1GeXCIq8=;
 b=gmro566hax4d9BZr03lRKhMX5oWkesziNm6hWp0bm8Iw2tf35b4Xz6AGkMR60yN+2e
 YolNp0Fx+5uwZgZGgzTL2QDwM6+2w3Imjd3oKEcwgqEjlWrKuwtPIECjo1JczyLgVDUp
 PzEn6MeKCzBRShkboWrZ1lCWHHtjUIkUDRu17g125iOB+UarI+sJifBjiaWA6qBwt+8J
 S0bjPmBEQ+xPCgTBxP2jHS0BdsIgMD2IThJpleKAmEX5cxY0A5fpXBT4WqUbNDnFDxZA
 hEjnn0M+K5UTqZwCPLq2pIjuic72QY4LOggyylOZpbXzdCtL3VDqGFDzRxgVbmTcRtJZ
 9zng==
X-Gm-Message-State: AJcUukfCmLApGpJ5t1nbA29n2X4d/vs2mZaskzU6yGZoZoblsjQbfAx7
 nfjQaF5n6AVW5jFF5wGiL1oBJhUAAJno9GPLMqzpOQ==
X-Google-Smtp-Source: ALg8bN6YhawHudCm6F/ZdRFYEzIKR8e7cGFCRztjkd2dXkzrFm97O4ErANctsVhqDghE+HFX9cQW1xM1vnddndLprPw=
X-Received: by 2002:a67:c202:: with SMTP id i2mr13167796vsj.11.1548145545282; 
 Tue, 22 Jan 2019 00:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20190118155938.12124-1-geert+renesas@glider.be>
 <20190121165600.2lavtrk2djj4adgb@verge.net.au>
In-Reply-To: <20190121165600.2lavtrk2djj4adgb@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Jan 2019 09:25:33 +0100
Message-ID: <CAMuHMdV-AM9GNnDo7W55Mv-uLtWn-nTBtmh3jn30tRSEDLNfTQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: defconfig: Refresh for v5.0-rc2
To: Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_002546_880439_EF668B2D 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Simon,

On Mon, Jan 21, 2019 at 5:56 PM Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jan 18, 2019 at 04:59:38PM +0100, Geert Uytterhoeven wrote:
> >   - Move SoC config options (moved in commit 062887bf5ef73313 ("ARM:
> >     shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/")),
> >   - Move PCI config options (moved in commit eb01d42a77785ff9 ("PCI:
> >     consolidate PCI config entry in drivers/pci")),
> >   - Drop CONFIG_I2C_MUX=y (auto-enabled since commit ea6b13e9fed0fda9
> >     ("drm/bridge/sii902x: Add missing dependency on I2C_MUX")),
> >   - Drop CONFIG_SH_DMAE=y (no longer selectable since commit
> >     a19788612f51b787 ("dmaengine: sh: Remove R-Mobile APE6 support")),
> >   - Drop CONFIG_ARM_UNWIND (auto-enabled since commit f9b58e8c7d031b0d
> >     ("ARM: 8800/1: use choice for kernel unwinders")).
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Would this change be any different if it was a refresh for v5.0-rc1?

No it wouldn't. Same for rc3.

> I ask because the ARM-SoC maintainers prefer the oldest possible of
> the current rc series to be used as a base.

Hence feel free to s/rc2/rc1/g or s/rc2/rc3/g.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
