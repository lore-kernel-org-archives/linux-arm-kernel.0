Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD7AC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:53:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F5C2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ss8tR8vd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="PlgX07nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F5C2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J/65JFWAGXeny4I8I5KcG/nymDW/kaOtZRVKdVY84sM=; b=ss8tR8vdZVXS+4
	yUPwGi/ZM4II3WbaqgthVmmdMAChEoeYjOMW59n1NYUskn99iC5f8CavzfS1lKzqz+TFT9qQOzsi+
	RwZX8tSz1L4XrwuLOePLK+AZVZiTXy7QwDQgQzXcxEIT7fX56/0bCusHrhYnPxHCzYwBsgpuQ3Grn
	RyDXoLmn9qzptfnEk7XUaOccg8g4Fb40WlbwcbMFnZag/GYeiMtD82aOMTx4/AK+Ttaf0X7DN0IiI
	yPXx3MNG6kuygfr3yiKF0kWCNm0GDMGMzur5uPrfPCpN7YSmTuL0+6ICFCRypbc+vkKXR0XYuTPCm
	cZLqqr+if7ga7AeoEORg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKrh-0005Eg-Vq; Thu, 13 Dec 2018 06:52:58 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKqa-00045i-2l
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:51:51 +0000
Received: by mail-lj1-x242.google.com with SMTP id v15-v6so755832ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=liTu7i/BxQ/14hVWUvO7mO/zt9R5JN2dQC8H0WBWFJU=;
 b=PlgX07ntho9DEthvYS8j9Cf09Z1e+4nZWDAzCGn5ZasGXNL/+dLz7jSc1ZtxeaIshJ
 o4ZidqBq58W5+J7vvaotcSMtU8AUJ67STbPnaaGZgjeVtOG/Va3//qGr6bB4cRicyV5D
 hjqNo21e1hfYTRrZXO7mLF8seigUjx/E+6R/A9YA/n7ChxwIaQ1mRVkwqCrxH605IAjg
 zjFdeFn46/dgOYAI3sUbnCatQhHZXGesXgH+8WInQM37VYoXhQKap8UzY2rYkZGadZEn
 pEgCz3j/X9EGQbhkAPlRUihbs57XAoDIzzvCZ4nSoq7doDRFNUGjGdD3HP1yFGYTri0e
 TSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=liTu7i/BxQ/14hVWUvO7mO/zt9R5JN2dQC8H0WBWFJU=;
 b=A3UNtXFQAc9VHLqO4sFK6VG/5zhZpyLL3MKjOu/A34htjJ0o1F7DFNZcJSh9O4fnUs
 Fnhrvpxvq2JLYQIH+y1sGainJk0gUGNOfQwAV9bveKioEwCxaiPMEMnnOinv241XPyb+
 RYvE8TNFr6L+45Y0dZyUnaWfx/2TK66/IwEiTGfm6pJpVy/zFeRPCVY5EDyau7iDkNXf
 RKVmxhh792jx3QJKrDGfj9j3vg2/w/Nx48T3ZRiTTbGoDdMQYekUmf1tplltcjImxz1F
 vwYluhSbIEoQBQV8lnIsfQP1ZuxNNVUF9y5O97nNcrH1ofZm5sWo2+4WelAYo7sIRd/f
 qZxA==
X-Gm-Message-State: AA+aEWbIIFIc/D0i8zqbXScfMVevhJzWEpl18Dkuw3oevVYbfbiZcwAh
 2mP4/Clcu4bRGAVletfs/KzNojgm4ts+/A==
X-Google-Smtp-Source: AFSGD/VeBKi4mF99u+BqBDO7jfL1EAh4g58s1c05k7+jDT5FmqeUb+PE42zh0Y51mbKC9KymsE+FPw==
X-Received: by 2002:a2e:2c02:: with SMTP id
 s2-v6mr14335725ljs.118.1544683896144; 
 Wed, 12 Dec 2018 22:51:36 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id z6sm175067lfd.50.2018.12.12.22.51.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 22:51:35 -0800 (PST)
Date: Wed, 12 Dec 2018 18:16:39 -0800
From: Olof Johansson <olof@lixom.net>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v3 5/9] arm64: defconfig: Replace PINCTRL_MT7622 with
 PINCTRL_MTK_MOORE
Message-ID: <20181213021639.6n5suqypqxvyb5mf@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <cb016b53-906a-adec-d8c6-019d2c74569b@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cb016b53-906a-adec-d8c6-019d2c74569b@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_225148_746515_5AED9B5D 
X-CRM114-Status: UNSURE (   9.73  )
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
Cc: arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 09, 2018 at 02:03:20AM +0100, Marc Gonzalez wrote:
> Commit e78d57b2f87c ("pinctrl: mediatek: add pinctrl-moore that
> implements the generic pinctrl dt-bindings") made PINCTRL_MT7622
> depend on PINCTRL_MTK_MOORE.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Applied, needed touchups.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
