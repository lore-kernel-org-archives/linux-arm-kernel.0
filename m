Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3A2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:37:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D288205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JpBCZLyC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="DVTWvLT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D288205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o99zlfAxonRxMFVEIEq0JqruUmf+PZPDLOsUv7oBiyI=; b=JpBCZLyCgnIML8
	YocdbuUKVSaKEc3ODaSU4gmvfbqHN8kxUi2KVJv/Pg8UjafAaJgPTH4zGGPIsa/9bpV2dKSFF+nAL
	5qOckSfC8kyibfwvre4S89JO9N/H2sPRuBfzavoJM41LVmgB0s3bSQ9jQRNoSuRT3cNAjS8CmlGjp
	/cjafyIePp9/YTLGpJlLs3C9FMmPSyIRR0JV0Mqmi/EUDdyc+aLUUWxAqYlpC0GDpy7OoSEpCtWRH
	vIOGqRTnWq3PxXeUc/OKW434Xv4AO0tO1u45C1gbYBxNoHzwsULDL8mRnsF4uB46THIdpl3ntiR05
	boEzpqfMgejM8YbBvrGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5FI-00005q-CO; Mon, 31 Dec 2018 21:37:12 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5D7-0005pv-Iu
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 21:35:06 +0000
Received: by mail-lf1-x141.google.com with SMTP id p86so18835195lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6wuk01MYx/T22n1RmoV6mfsD4mjku4gy0h2Bo9Voas0=;
 b=DVTWvLT37ypW4gOCh6b4mVN/BkBu01d8Of67AUs6nF/MtEWBi/ZdxgbavSuiGdfe7D
 LJcw6fuqHmb16pDjdPDuJr4L2368GH27nXLlBGlm/6Fe8vpa26ceWBjx1ucBhP7gqJeJ
 4T7eLy/B0Zk1qPxp7e1eLjcuTjpSnGUA5o4EhdMfimXRsKM+ino20O0dPSqJxr1j7zmT
 0Vgi39ushQqzgqXHbWE1udaMhcPkqb8B4739dxpABLYSxQJpgIkFgUrX4lEjCDxhaQQn
 Kbeh3el435uNeXf9rMLfk6HSCIVBZYEbnCFbCGuEHkHqZYtXlmzJBxpL2+QGpd92yHXh
 SGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6wuk01MYx/T22n1RmoV6mfsD4mjku4gy0h2Bo9Voas0=;
 b=CQ3cfxfIQ//XjY8hP8mVFbgYtg/whsXQpgkMx7+b4OTZxEKCQh1/P5fBrVDdJ8v+vc
 rf9v4VBi/h0ID4TdjU2bSTa9spj+6sayZH1qDokoDeCSr8SiYxF5d2JNR/llVuCPMShk
 G+9J+cy6hhPM65ctTRLIo+nO6COvBtTc+Vme/slTaqD35wljZ0thGVtldCONErv3Av3M
 zFgzZLH7BUpUo2i2X+5bhf8IF3quy48c/rGdOXJ7fGDZGAEKo+sl+2Jz+pA3aH94WtoL
 QmR1tiLDsXNMkQOrL7oAU3ykLardQSfAQ3Ze2vItA3tBAwz9vpHCegKDm9MHBpFZH/a6
 43/w==
X-Gm-Message-State: AA+aEWbv0kiuD97XH+Jnri5fePThxPZUFSeMomcOdjlkDo9y73mPANgU
 gi77wVjWsXqHhBZUQEaX6/3uTA==
X-Google-Smtp-Source: AFSGD/UM14oFPYEKwXDHhVLvqF6b0XwXj9MM+5NAxkGY00KskwvcJgxIQFdf0NaGsZ6qfhAM+iM2mg==
X-Received: by 2002:a19:789:: with SMTP id 131mr20383130lfh.11.1546292095582; 
 Mon, 31 Dec 2018 13:34:55 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id e19-v6sm10416018ljf.67.2018.12.31.13.34.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 13:34:54 -0800 (PST)
Date: Mon, 31 Dec 2018 13:13:42 -0800
From: Olof Johansson <olof@lixom.net>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v7 00/11] Add initial RDA8810PL SoC and Orange Pi boards
 support
Message-ID: <20181231211342.ulg4jytermffqi34@localhost>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_133458_429466_1D3A55F5 
X-CRM114-Status: GOOD (  16.25  )
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
Cc: devicetree@vger.kernel.org, arm@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 08:32:27PM +0530, Manivannan Sadhasivam wrote:
> Hello Maintainers,
> 
> This patch series adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
> i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
> GPU. The SoC has been added as a new ARM sub architecture with myself as the
> maintainer.
> 
> More information about the boards can be found in below links:
> 
> 1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
> 2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/
> 
> All patches are reviewed by the corresponding subsystem maintainers. The
> clocksource and irqchip patches are reviewed and merged while the serial
> driver got review from Greg but I'm not sure who will apply it.
> 
> So as per my discussion with Arnd, sending the individual patches instead
> of a Pull request so that the rest of the patches can go through the
> ARM SoC tree.
> 
> Please consider applying it.

Hi,

I've applied this series to our next/late branch. It's a branch we'll try to
get merged by the end of the merge window, but it's not a guarantee that we'll
be able to get it done. If not, the material will be moved to the next release
instead.


Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
