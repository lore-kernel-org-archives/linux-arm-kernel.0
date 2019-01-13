Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A0FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:11:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E482086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dwto5Zut";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="tt6cOCPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E482086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ArDsv5xJ8XXgF1UOQB20ZFCs+gNz08wlc+ekWP4bkDM=; b=Dwto5ZutBdppx8
	HAkuMTgS6hZ9Hbx6dvmp80xhFJoDssHWgEPFbQEODWI557giCnuBUgoMCnYgWlK5+yT0dYzOQfOJX
	tacuMLBoFDWxT+OKUfZ1FS1R7PWiaFpbF9Vx+tbYWk1Q1uunClAz2IExfkVIQbl4WbvbxlaQvWIYy
	c1/pXI1rEXVlUxd6TtPza10pqKeMk3a1qh/9yi57UBL5kq6DLpbLe742bkwNQwPGvt3CdkASpHEqp
	SMlM4jvvIuUvO4VPg9mypyNE9hi6IJ1BYB6yuFBUGQnSd69YFdg3SLTFAynZYvx4Cm4mORWSSy3oE
	SliXQxYYVM/OV9Q0mn7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giYzm-0004Kz-DV; Sun, 13 Jan 2019 06:11:42 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giYyy-0003Zq-Qk
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 06:10:59 +0000
Received: by mail-lf1-x143.google.com with SMTP id i26so13529356lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 22:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tpGZBMv+2Blxh4V/XE5i9mZ2QtJ6+hBIEg7uehgXemA=;
 b=tt6cOCPjqgPNi0TRL7/t78hIWoMG4wPa3FgWWgmI4zRxFkl/2d1409e4Lxf31bdDnV
 iHmXEkk8ZPWhb8TY0tJbUz4TB93MAyQgnt+02GfpuQ3g+/wbfveJX9Q7rJXf7AFe+5ZR
 fy7BWat0MCJIz3E8byrnH3YbIbeZjsXl1hP1Vm8eP1VnMsSZ8yN2ZtvP0MsAv8mYgOMR
 xn2s61fn5LHbpWNfvvAgccEkHcK8+G4FxKS6U1HbkyvOvykCRCo+hxlsKW+ab5W8yNHd
 vV6pwD+HTDQhmSifeYm0ymyuk3TCgJ1OUF9X84flqby4zlSFT6Fzzo34XotgMGsSBIBM
 muxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tpGZBMv+2Blxh4V/XE5i9mZ2QtJ6+hBIEg7uehgXemA=;
 b=o2656I2asFvf9Id4/vhCkRUa8z09PJrnX2epRrtcT6q4A9gX2dqpCTuuHtC0rxEI/a
 O41LJD2XmnAWguRqXiXkIFRsIpvIVlS2bIyf2bjD65RULHTsus2SquybcGFpQwMzBPaU
 C6i+TUjkzJpldIgvonEA9HXzAJpC5Qh4fqjvgVPjQuixdck8WeQ9H1xCaEh7yIqgsWFg
 l/YlM+10iIf1ryntPvXgPW4ZMQoZI37pq1Y6ZhqmXfSRYxfdLCf7oJ3mgOQvkaQpNZ1G
 U16aiN8W55kpX1Hm9dmjRxs4Xh7+f44BNYlDsawuQb2ocIV0MOn9edfPb9k97zeJ+jNm
 CzZw==
X-Gm-Message-State: AJcUukc++jCNrMv7MIHe5rUXhvIXnb+M5j33w18tTBzB1tpjaMyAL5sm
 MLCRi6Gb+lHCtpualqXHdM2/Zw==
X-Google-Smtp-Source: ALg8bN7dv05vPQ+vUdZf63wl3plyxr1wQtmlk3ENEONCntNMwoETtfHIZhXP3viDeTLhBst0SMFZqQ==
X-Received: by 2002:a19:2106:: with SMTP id h6mr10804651lfh.29.1547359850830; 
 Sat, 12 Jan 2019 22:10:50 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id m4-v6sm16414543ljb.58.2019.01.12.22.10.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 22:10:49 -0800 (PST)
Date: Sat, 12 Jan 2019 22:03:38 -0800
From: Olof Johansson <olof@lixom.net>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [GIT PULL] Integrator fixes for v5.0+
Message-ID: <20190113060338.serdqlsfb3hih5jn@localhost>
References: <CACRpkdb22-JT3GeJeqcOdXYJa9MyGMhujHxX-RgZOk7kbEkejw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdb22-JT3GeJeqcOdXYJa9MyGMhujHxX-RgZOk7kbEkejw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_221053_243399_EBEFBC49 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: arm-soc <arm@kernel.org>, Nicholas Mc Guire <hofrat@osadl.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 04:07:21PM +0100, Linus Walleij wrote:
> Hi ARM SoC maintainers,
> 
> these are some overdue fixes for the Integrator.
> 
> It's your choice whether to queue for fixes or defer to v5.1, there are
> not many users out there, at the same time it is nice if the code is
> in shape.
> 
> Please pull it in!
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/integrator-fixes-armsoc
> 
> for you to fetch changes up to 21face6f0d4d033d949d5517f307a15f76a9d9f2:
> 
>   ARM: integrator: impd1: use struct_size() in devm_kzalloc()
> (2019-01-11 13:33:00 +0100)
> 
> ----------------------------------------------------------------
> Fixes for the Integrator:
> - Handle failed allocations in the IM/PC bus attachment.
> - Use struct_size() for allocation.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
