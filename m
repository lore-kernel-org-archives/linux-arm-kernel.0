Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306B3C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:57:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026EC20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QQArB7jM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K1IaFcoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026EC20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jTTSUnvQ9pkywDPK/hTcu8oXjh6eFLxa9YJQGBzZDuk=; b=QQArB7jMoqGQY8
	QPuTPtBS0qJHphaeF6XpcrctHoXjV3c1pnBWOJ05p5yTbgyqmQ0xql9urtvBTSNOvkdcpdZgSkvOc
	JNCRa1TtuQCofz3gE9Z62iPSKMt24y2tI39s+ary4pPFuQxoLxwr6rQfl2cizRbWaJO+jjx2qNjrn
	dKzeRk2e1CN0kxFqjObCM8eVtU8GlyibfzdKjZzhFFdeW98ENjC+aUcY3E7o1tM6zwtXBgM+v12+y
	U3undMlrP8Cupo+lopsH6NYFq4tCtfEK8cMrDHUeswaGA7VLkXJogWvFFgIM2eVEJL0yYHwIODpLH
	xbYf+0/56TiIFJ2Jp1Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs6eM-00014y-T7; Fri, 08 Feb 2019 13:57:02 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs6eJ-00013b-G0
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 13:57:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eJruefPcMHEKq234LqT7fqJHZS65f9i7tRyihQ55IMA=; b=K1IaFcoyAp8CGcWGrnMi5i7cgT
 ZvaCidjrp07atWvi3dIHtBX8K53u83v0IP+wR4zsPGWqvZ0dOc+sDpwmN/cFsM7Nc5ia5+J8yWlvi
 jyW99oQOzXD2pRpJl4efDRlozHFs8aR47BaLd8I/N6crobsyXc7aRXhNniWOpMXWOB20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gs6eA-0007LG-49; Fri, 08 Feb 2019 14:56:50 +0100
Date: Fri, 8 Feb 2019 14:56:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Coles <coles.david@gmail.com>
Subject: Re: [PATCH] ARM: dts: add description of Netgear RN NV+v2 LCD
Message-ID: <20190208135650.GD26594@lunn.ch>
References: <20190208045305.8759-1-coles.david@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190208045305.8759-1-coles.david@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_055659_681481_4520F5F0 
X-CRM114-Status: UNSURE (   8.44  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 08:53:05PM -0800, David Coles wrote:
> GPIO pin mapping taken from NetGear NV+ v2 5.3.13 kernel sources[1]
> (see arch/arm/plat-feroceon/mv_hal/rtc/ext_rtc/usiLCD.c).

Kirkwood! It has been a while since we had a kirkwood patch. Some NAS
boxes seem to never die. Nice to see somebody still hacking on them.

> Signed-off-by: David Coles <coles.david@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
