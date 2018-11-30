Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:11:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37B420673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XrSsWTR2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1PCw00kJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37B420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gArRwKI0fCRA4eLFyCvFVvV6La9QLz12uR053CK2fVA=; b=XrSsWTR2Y8sI2I
	kU8/oi1tN5CmUN/dLoDn/iu17W2zR75R6Y/2dmrLCTw2w4rQQjWo7h9PMbWElityI3V5eiRTr66XW
	WiDHWDNfm8f0BuXo6pJv9W6s0+oYIcOGhaBGo+2b+KhYOCnz3VVup6re2cFnYZiy5fnrMdrJh3N5O
	PPkay8ZS6ZgrBEJFnq5yg1N7SFfXqH3xY77J7DLVGl20kJfe9BC3NBgB+/mF50zoIjhvEGLGFlbNx
	xsvl2+66U6WxVDjFtz/IG5k4nIWVaNj1B/3aq5uiL5KxnsFFov9zsHQlFE2PN5hHzaOINAyszqnig
	Bdj8h6q87Aq9zBXmLU+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSss3-00040B-Ua; Sat, 01 Dec 2018 00:10:55 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsen-0002DS-D2
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:15 +0000
Received: by mail-lj1-x244.google.com with SMTP id z80-v6so6468808ljb.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=h/nTTzZlldYBmRqsGKRdto2uC2xW+Fq0C4IlKRJUb1U=;
 b=1PCw00kJuAlCPmi3lYLDrgPVM/dfVj9QyYZPFjxdxzS1rNFz4rbY1RT8J4gYL3+dLn
 9vZ3Hyhmk0X30aJ+nxqwAAjOjgRx4pbTuT/fq5YdfgJmzUxDCpv+BpZTdmK84a+L6PRW
 MHSKciysmKAnbro5fkiyyleY6gNkJRIG4NAid2qzrMrY/IdBRQuaNwixsNPy5LVcUhFh
 GM8reodAbWbMwh3rgDz1kEOk1+LUhI/FL0v6f1sLWNhvS28aD/PhUpK1eYDfXaGPCQDU
 HXwowJ7ZvAFWMQAtLp06kGenNhH+8nbRc6g664A4BOJjUrC3DGWWvm1Ym/e857JmEVYZ
 Gykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=h/nTTzZlldYBmRqsGKRdto2uC2xW+Fq0C4IlKRJUb1U=;
 b=RoECU64RnvsEdVRExgSysWlgZjnWqvaoiRVOnSpBJdIn3x85OalruWlrbklqrZkuP0
 N4w7YwweTZ1FbsOUyNo51WqfBZbcbWYescPWe7Rm/yhXZMhoXoCbmAUZ1cJeMAoTm99q
 LtjW2gWGYmmMJ3KQn1j/XoEKbycm4EyfV672Gc9IIHVpZ+ZICQNQpbEET/7WhqoG1CGI
 eA/IDhenjCu8NZVtmer3YH1GfT2bTjZ62P6jg2ByM3rkKMPUFkNtIEtluzcyUm3fZM0k
 T35DhVmM2DCdnBlwfzElvDIXf02S0Z+UIDeLfvfLGJib5rPI/yLCCKks3QRhi6TK5N+9
 N2Yw==
X-Gm-Message-State: AA+aEWaglQcqVZUU/4rGT6NW3DGSGaT91m5ervY9VBw7/crHnU9gJu5i
 Y7vpywNEXI8HQiDojkLgmfaV5Q==
X-Google-Smtp-Source: AFSGD/U7/GPUnLBlEakj+ArSM0aJdBLEkpY8Ut+NDZgxvSKriZT7pdGoKHNeTKajIRiSEPi9SNX9fA==
X-Received: by 2002:a2e:4a19:: with SMTP id
 x25-v6mr4850470lja.19.1543622221016; 
 Fri, 30 Nov 2018 15:57:01 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id c22-v6sm1034155lji.89.2018.11.30.15.56.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:00 -0800 (PST)
Date: Fri, 30 Nov 2018 15:18:42 -0800
From: Olof Johansson <olof@lixom.net>
To: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [GIT PULL] arm64: dts: Amlogic updates for v4.21
Message-ID: <20181130231842.oqwctiwcwdbirtul@localhost>
References: <7hlg5b8v6u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7hlg5b8v6u.fsf@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155713_435846_5442D717 
X-CRM114-Status: GOOD (  13.21  )
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
Cc: linux-amlogic@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 12:50:33PM -0800, Kevin Hilman wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64
> 
> for you to fetch changes up to 5e339a1d7e438b2cc9f46ec9f2682efb58ee2dd3:
> 
>   arm64: dts: meson-gx: Add Internal Clock Measurer node (2018-11-29 12:30:09 -0800)
> 
> ----------------------------------------------------------------
> arm64: Amlogic DT updates for v4.21
> Some highlights:
> - new boards: Phicomm N1 (S905D), Libretech S805-AC
> - fixes for pinmux pad bias, GPIO line names
> - AXG: enable SCPI, add secure monitor

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
