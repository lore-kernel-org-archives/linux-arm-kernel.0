Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A94C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:25:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66464218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eht64ADw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66464218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FeMF2jAQegseQ0bCmvmXGSsQg5MlD56s3NqdJV5I5E0=; b=Eht64ADwf1o9bk
	sj/OCgPtOMiGEN9YcrtZSdSDEW8+h5/EGk6UVaexj76Kqq+9syihBwvdg+yu50ztj6KSLP8p0TlNU
	WpwzCu7AM1zi1E7oaaZcFRHlM1+Sr8P/9CVPlMXoPmeiY+BXHYwvdvL4AeS2uKa8RMcbeEdtHljRl
	ZI6j0NKswL0ltA8dr7fi9nzhlPDpDab4X5YUd0x3ZJx8NghhP9KJDfrqxSfB+KbJg87M451ior8Wh
	sAX9wOrVzMnP+Y2mfOCTLctxJ2ya3OZiJ6f/3nfuEVLPF2hbu462b4I0LTAaoMIw6aWFEjbfsDKvo
	OZql2mYwh0vOh0DHeGjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gon3M-0006pE-1z; Wed, 30 Jan 2019 10:25:08 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gon3G-0006Fp-Pp
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:25:05 +0000
Received: by mail-qk1-f194.google.com with SMTP id o125so13352882qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hlTKPLbFlomdOI/+34rsGSFWYw7erPcNWjiJRNin70I=;
 b=h8XujSueKc035dVHIA9pGgnjnrUaVuT6OonBB4g7CIFJf5N90ZdKzgiP1mwkXTn1BT
 46UNPQXUpYl8adpQZlsnkm7Fc9Yvh4ssX2xXBPXR4ZqaFtIQjfNbjdGQktb4XOlfSwYf
 0r84kSjv9HDQPEJkR4i/aUnDMxSQGr5ezV9cqepzmYTRBAE9lLGQqO0CCZ6QceQ2ZR3D
 IERGZ+UKUY3MEZcrkVo3pjEYJYlQQjFKzPitwubtDGx4Tqk13eBc/Y7TYQKk25RztRxH
 orP3DXmlAOAUCuknrL/CBwqTTOcXaKLkcQi9npnWdAiShXYe7Zz0uTh8zFc4sz795cuQ
 MNzQ==
X-Gm-Message-State: AJcUukfNI48i2Fg/r3LNVX0AfGDoq6ng0ub/SMfCF619VLNQYt7PxCjc
 7Ed0/KNfwl5/SpJ43yDlJcYThQQdYyu4eLoEMKw=
X-Google-Smtp-Source: ALg8bN63E0GRUMpW7e9URkYD5WGmTieb6976a6LDzCGms11b25eLFCufNQe8gOhNhpZw+N76/DIQTnF10+liW3P98ns=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr25581055qkm.343.1548843901752; 
 Wed, 30 Jan 2019 02:25:01 -0800 (PST)
MIME-Version: 1.0
References: <pull-1548435073-725543@atomide.com>
In-Reply-To: <pull-1548435073-725543@atomide.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:24:45 +0100
Message-ID: <CAK8P3a1Qra2p=3vF8Mxk8c-ya06OcJ0uO-1TCFSMDh5K=F+Ang@mail.gmail.com>
Subject: Re: [GIT PULL] dts fixes for omaps for v5.0-rc cycle
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_022502_868562_0C16E0FA 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 5:52 PM Tony Lindgren <tony@atomide.com> wrote:
> Device tree fixes for omaps for v5.0-rc cycle
>
> This series of dts fixes for omap devices fixes several device specific
> regressions:
>
> - The onenand timings for n950/n9 have been wrong for a while since
>   we moved to dts based timings
>
> - A typo for the cpcap pmic is now producing erors during boot as the
>   level should be 0 for unconfigurable triggering instead of 1
>
> - Changes for ti-sysc for omap5 left uart3 with debug flags that should
>   not be set
>
> - Fix a new dtc warning started showing up for omap3-gta04 grap_port
>
> - With the generic MMC card detection code we need to fix the gpio
>   in dts for n900 and am335x-shc

Pulled into arm/fixes, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
