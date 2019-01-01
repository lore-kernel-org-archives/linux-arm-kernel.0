Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E01C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:03:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1771220828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="utpr0N0p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmxBDMWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1771220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pg5unli8aSnceY2FG/u15ly6fAha0AYiMjChwwgIEvM=; b=utpr0N0pFRIhAy
	74VFYa84u03+fT4unLeWHol+33nzSaoZVGUOm0MDuFN0smFqirljAQknadsM18lhWo1BHzETAubuZ
	9VQvtBWkcKxo48Zb790IcN0vAfknkBuKwVVs2vyijuB3sFvHvTyXz8IEtg3ttZjw/Tcw5B/qpzV50
	Ovh2QXJF7tEpdvKprvRGXhauWzaNJsooZH0ZwWUEuPXs5uVMHKwrvuksotqcutyx+SqnAIu4RAXaH
	H5egxuW58rDGLAfQ/O9jQe5F2AuDQxx4tCK6tgW3Dsp8A5M97kFkFlKYG3iZGn/AH9LDx9bcRpOjv
	mqKxcKglizUjNPILDaGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geAKc-00052m-Mr; Tue, 01 Jan 2019 03:03:02 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geAKZ-000525-Ar
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 03:03:01 +0000
Received: by mail-pl1-x643.google.com with SMTP id u18so13154438plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 19:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kxba1AYj0Cp62D3Zqi46mRtdwm+8CtTFp3Dq0lBxQt4=;
 b=TmxBDMWGdbn55y+Uq1FyDcmxHG8zbjT/t8vc/RDlxVDzJRHfVWUnwdVCJTVkC0qoGL
 S7oWWcDD3eePrghi+vDeillWZd/agLArqU9mzGwBouw/QkTBwzoXbYaSmM9sBxOzKC7f
 mffqJVcoNHiFDT7PMZgOP74pW9qCIx1jXJdBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kxba1AYj0Cp62D3Zqi46mRtdwm+8CtTFp3Dq0lBxQt4=;
 b=puVwyDuI16ZbkZ6JMRoteNq+RB14+uUrGmDXjT6NJatHMLZoABI4U7a0EHaaEN6HZK
 eQgMj7XFJ7JE/pkDT6yan9+KrKII5W65A/fLR5MZ0kE8EaBRyeE5SE/BahAA2cVEzXKb
 rIR5wv0nP2L/LWvWmYbVWRK1NOP+XUn1DFiLWlGvOBdh0mZQsRO53wWdvYKXcjoMxOkq
 xbql16rC+bvfCQoONzbZLJLhkw4dxnSDfwfYQQVQRgDKyHEUR4dyW7hjFzXxS3Z3Js7h
 PtvckqhNZhNPriF/hksH/CfhOMXk/olpXzN2+hPUiUa4Uxh3DCYIkyiG2PbU9D2Q0+6I
 Sumg==
X-Gm-Message-State: AJcUukeIi1/B+sQjW69JDOxNS5OP02D0AcpGCC5Zn+z2U2Mqz5nj7+y4
 iHzqLWhiOtP4l35Vwp2wFzDU
X-Google-Smtp-Source: ALg8bN6aVDNvEH0JvMxSuMeIKUBkdWnIsB5SWdw2xIugadFKID7jTTzRJdNdaxJ7x3zNW66etFd94w==
X-Received: by 2002:a17:902:aa4c:: with SMTP id
 c12mr39073927plr.48.1546311778336; 
 Mon, 31 Dec 2018 19:02:58 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:73cf:97ca:3812:84fe:81d3:6fa8])
 by smtp.gmail.com with ESMTPSA id g26sm63005694pfh.61.2018.12.31.19.02.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 19:02:57 -0800 (PST)
Date: Tue, 1 Jan 2019 08:32:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v7 00/11] Add initial RDA8810PL SoC and Orange Pi boards
 support
Message-ID: <20190101030247.GB2736@Mani-XPS-13-9360>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
 <20181231211342.ulg4jytermffqi34@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181231211342.ulg4jytermffqi34@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_190259_378546_1B7CD693 
X-CRM114-Status: GOOD (  17.78  )
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

Hi Olof,

On Mon, Dec 31, 2018 at 01:13:42PM -0800, Olof Johansson wrote:
> On Tue, Dec 18, 2018 at 08:32:27PM +0530, Manivannan Sadhasivam wrote:
> > Hello Maintainers,
> > 
> > This patch series adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
> > i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
> > GPU. The SoC has been added as a new ARM sub architecture with myself as the
> > maintainer.
> > 
> > More information about the boards can be found in below links:
> > 
> > 1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
> > 2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/
> > 
> > All patches are reviewed by the corresponding subsystem maintainers. The
> > clocksource and irqchip patches are reviewed and merged while the serial
> > driver got review from Greg but I'm not sure who will apply it.
> > 
> > So as per my discussion with Arnd, sending the individual patches instead
> > of a Pull request so that the rest of the patches can go through the
> > ARM SoC tree.
> > 
> > Please consider applying it.
> 
> Hi,
> 
> I've applied this series to our next/late branch. It's a branch we'll try to
> get merged by the end of the merge window, but it's not a guarantee that we'll
> be able to get it done. If not, the material will be moved to the next release
> instead.
>

Okay, thanks for the update!

Regards,
Mani

> 
> Thanks!
> 
> 
> -Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
