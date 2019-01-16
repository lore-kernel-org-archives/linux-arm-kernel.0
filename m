Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8016C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:59:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7758920840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W18ykNeU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="IImQkfO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7758920840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cBD6DRuwC5Tt4vjKTxO3gxjcLzZTwEow7r9s86oZyD8=; b=W18ykNeU22JVAq
	3eX8XRJyZc4pK4b7Bg6iuBOqyvTmNlPvBIMcA1NP8b2LhLatL5Tp+jAxuYV1QPjyjILougcCrTfb+
	vjq2FtL/I7V2liEhCJG/jSPYFk+t6KRXpffMpilJqNspaXCicFAaFhBRZx0b6vGQuPmYUYCdz6ZqD
	4MqaV1tFNHrl89WDBuR616edOaPbFsLHwG/KWAazZdV9R0Rc8SuoniLPugF3qLKrCZz7fp8yYmHBH
	y6SmBlhZuH2c0DNxnIYR82vdzACvWrsyVpuSEay5mZnv8hsXSv7UC5hf6PRnsCrRXsRUIieDz06w/
	Ad1INtsKj8NqWZji2l2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjg6n-0007nr-4b; Wed, 16 Jan 2019 07:59:33 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjg6j-0007nR-Bx
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 07:59:31 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id E1E0E4042D;
 Wed, 16 Jan 2019 07:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1547625535; bh=gmAgAhUX+s8x+bckN8RcCtKnRI60cxc9Uc7EsH4eRik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IImQkfO4fpGZzgOxmliZ32woI9BCrL9oPaLRHO4XAjorGbl5eMJ4uZLEB5m0C83sl
 u4SNNeH0txG6cOlR2+C+8g6FH/tU+WNzSK/4FzBbQBEa4sMOs7sSsJVZ036DHvROch
 XTL1hQsbxACTBwlNS0O+GKH7yEH/dU85ZpdWelVU1gJcuxAfANTB35MEM4E3dwszEb
 dL/l3hVRn3Jzp5ozaqQM0DeRHlwRuzlg6wKNDioWzB9eBvQ2oKa9fcRPA8JhO9IdBK
 90MDi4VKW1l1p7u6OxvPwffQ2/D65oOcJwuwZYKHuyqUwSEInxe6DRS86kBc5diamX
 mgkxjbuY3oH5A==
Date: Wed, 16 Jan 2019 07:58:54 +0000
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [linux-sunxi] Re: HDMI/DVI spurious failure
Message-ID: <20190116075854.o2kme5nxq5kckwem@plaes.org>
References: <20190114132934.rywqqtjarbf6fgcr@plaes.org>
 <20190115094951.e7jnjpibj5tcp5pz@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115094951.e7jnjpibj5tcp5pz@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_235929_551755_8D359E46 
X-CRM114-Status: GOOD (  21.44  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
 Chen-Yu Tsai <wens@csie.org>, Jonathan Liu <net147@gmail.com>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 10:49:51AM +0100, Maxime Ripard wrote:
> Hi,
> 
> (Sending those kind of bug reports to linux-sunxi doesn't really work,
> you should Cc at least the ML involved in the development of the
> driver at fault).

OK, sorry for that.

> 
> On Mon, Jan 14, 2019 at 01:29:34PM +0000, Priit Laes wrote:
> > I have a somewhat curious case with one HDMI/DVI screen that fails
> > to initialize properly every 6-7 boots. The display itself is also
> > somewhat flawed (missing HPD pin and the VSYNC/HSYNC pulse width
> > is set to 0 in EDID), but I suspect there could be some issues
> > regarding timing in A20 HDMI driver in Linux.
> > 
...

> It doesn't look related to the clock rate itself, since it doesn't
> change between the two cases. However, in one case the DDC clock is
> enabled and in the other it's disabled.
> 
> Was it taken at the same time? Maybe you can try with that patch?
> http://code.bulix.org/z7jmkm-555344?raw

Thanks, after doing ~50+ boots I haven't seen a single failure.

Previously I had following failure cases which are now both fixed:

a) Linux without u-boot HDMI, where one in every 6-7 boots failed.
b) u--boot with hdmi enabled switching to simplefb and then switching
to kms, where previously all boots ended up with garbled screen.

Priit :)
> 
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
