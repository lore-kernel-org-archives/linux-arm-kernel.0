Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8456C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:02:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B738920867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GHaJ9jnb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Qt5wF0dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B738920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1HuX0NLsOIE3imFP287Bgl8o08Ux5UtJrVFmZg+IyP4=; b=GHaJ9jnbl+19Uz
	uUG9xiA57TGEbGJzBE+axAU5HbVCP0Zn0nqWcvwvW28aKC1Yot4gxeH4T0IwUBCzEVhXPvqe+d9q2
	pgzOUgOgl6F4gdeUHY7uu/Rw+poYXtXJGL/RGd8ALVrFlwzs/bLWAL4gLwoMX5hyZnyhhhHIl/Gg1
	kBymPLu37w2IkDjNJtmTvdjz4p7d4/bQ4yTReyvRgUcJDpDqOguzdxqsVPdodu32Xjtr9sBQO2N1U
	JhHZ4WkXf0Y8hQuah662cevT61TVDxtUrj8/rytL/aoeX1q0fid48SKXPswumJ+DJ5sDID6xb2xLI
	knBja1KWjCgjd+YPblAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsjz-0008AV-8Q; Sat, 01 Dec 2018 00:02:35 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSshx-0005up-62
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:00:59 +0000
Received: by mail-lj1-x244.google.com with SMTP id e5-v6so6502964lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HYWqfGstftOSKIavnOY/u8y/miyTPH18CXsr4jDdYoY=;
 b=Qt5wF0dWBulsPK/91GI1i2UrQ53Cfejbi7KFFfxw4l4II2Lr37CfC70GkuXkvGz55M
 sMGknyQCn21Rrw0wGWMkjnznHxK4prCv8CyVW9Je/LW/QAkbL5l1Bu76syeByhotVfbr
 zBR0AIGgC4oz13w0lF5VUsN0fFlKi6P8WdMuA1S10z7sLOXBNXVK9QUz2dzpRwYrzbWn
 FSPJCVfADPZyxSyl2lv3jhuaq7udL8L9ILpSyuVZMEheJg/8f9G+ibcXKgfbJf1Dgwv6
 dOQOPGm6vbLbjQLyvhjvt3Z5BB044r/dvnUBMFD/vQbTUrlaV1ZQPzEgVWBHSEcq3ewj
 CEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HYWqfGstftOSKIavnOY/u8y/miyTPH18CXsr4jDdYoY=;
 b=OMUMhtthiRILOOxXFxdlNSN7FCnBU8gOX8eyP0EmTe4YoX60x1QZknKCsDLStBcn7p
 IxGG9h+Elt4VNnlr6PpjwtIqwDXBsnOC77u3GbanXPll41TWsM2tQFIM7jAvK9h1SEEe
 GZECStKGval8l98elYQwehA0uGi0GcovHDB98aL2VkHEoZkaKo7b++duo9svA9zPmAaw
 VYlBq8DstI935ESVmjNe0dD7k9nugTHSkEB3RCmnP9akJDoVMLvLLudtZiz/xrWmMJXN
 AxfGkRKgTEfr2ap7WbbYxbyeVbX2cj+r4wHP8kJe/8idLHR1FqvJMIRkAtz7OGzrZw8L
 Gwgw==
X-Gm-Message-State: AA+aEWagNdL8D0LVJjpFYHb6fIMOFELhy0WghXCFTxhdSOAixyV0lHl6
 JXWnLtEH22PbOr6XbqNHpAlDug==
X-Google-Smtp-Source: AFSGD/V+H247VtLkfMkogq7O7AOuGT3/06ejzp1Wed0sqGEzgaAEP9OqNUVIgr0eFwij7GB8iweClw==
X-Received: by 2002:a2e:8156:: with SMTP id t22-v6mr271391ljg.32.1543622417432; 
 Fri, 30 Nov 2018 16:00:17 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id z9sm1021898lfj.79.2018.11.30.16.00.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 16:00:16 -0800 (PST)
Date: Fri, 30 Nov 2018 15:59:28 -0800
From: Olof Johansson <olof@lixom.net>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 15/20] ARM: mmp2: initialize clocks before the timer
Message-ID: <20181130235928.vqknywa54pta35am@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-16-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-16-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_160029_878596_BB5E7272 
X-CRM114-Status: GOOD (  11.04  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 arm@kernel.org, Pavel Machek <pavel@ucw.cz>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 06:53:19PM +0100, Lubomir Rintel wrote:
> The timer shall enable its clock.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---

Applied to next/soc, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
