Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EE9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:28:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CCC20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hslv1WDx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="a2pmFH2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CCC20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K8HxvZMeqSm1zJ9OjV70Df1QwMLX0sNJwfubhYf/ym4=; b=hslv1WDxBfyPxv
	vUwiWpj3ksdIbq+AC53mwYzihqCy1cDN7f+6L4AEX7gdxbK3gdQGO3cnwVl5QlZBKjEInr4KMa0ax
	wGThJalZ59XT0XYpGMMGkh44vR/vyg0TJfEHOEev60q14Pcu7deA2lnjfdvE45j60xv3QRSkDwacU
	ovbOPs8LqCOgrZ7qHC/duz5mRgRkQIZ8dal/J9h4Ceb7vNHiaswEagjAEnsAy6x9vtduVP61nsleF
	O7d6W/R3LUlgNWshMz0ZM+vAVsGMltMB50/uuhxXCWcQU0Vz52qBelBY97FoheYvGtNcGIUh6sdIW
	jDqBHwFaPyQQ2AKzCEGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkV8Z-0008IS-Gu; Fri, 18 Jan 2019 14:28:47 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkV8V-0008Hg-Ds
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:28:45 +0000
Received: from zn.tnic (p200300EC2BCB1B00329C23FFFEA6A903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bcb:1b00:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C69761EC0573;
 Fri, 18 Jan 2019 15:28:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1547821717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=gbHNbKy+Xhm8EHzQUm+KhOvq1C3SEcIFrwN7KVnE3ck=;
 b=a2pmFH2c3OjQOEYgn1JYHJVyPQB6XpnE8P1QtoMAmHEp+Mc9yr/dKt5MW4WCSmmUZg1D2u
 trLHdxQ1UYKMgxhYqZ8BeIPCB+Y9V7wfurI4O+j1ffWv7+GEd9yNHNeLZfkVGj1HAC1Iyi
 oPSadCexi6CUmL8yFep/dCfUoMTvfpg=
Date: Fri, 18 Jan 2019 15:28:31 +0100
From: Borislav Petkov <bp@alien8.de>
To: Stefan Schaeckeler <schaecsn@gmx.net>
Subject: Re: [PATCH v2 0/2] Add support for the Aspeed AST2500 SoC EDAC driver
Message-ID: <20190118142831.GD622@zn.tnic>
References: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_062843_622530_02CD8FEB 
X-CRM114-Status: GOOD (  13.35  )
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
 linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Stefan M Schaeckeler <sschaeck@cisco.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 08:38:15AM -0800, Stefan Schaeckeler wrote:
> From: Stefan M Schaeckeler <sschaeck@cisco.com>
> 
> Add support for the Aspeed AST2500 SoC EDAC driver.
> 
> Changes since v1:
> - Addressed all cosmetic issues
> - Fixed (un-)recoverable address calculation in reg58 and reg5c
> - Removed status field from the example device tree binding
> - Added little more text to Kconfig
> 
> 
> Stefan M Schaeckeler (2):
>   EDAC: Add Aspeed AST2500 EDAC driver
>   dt-bindings: edac: Aspeed AST2500
> 
>  .../bindings/edac/aspeed-sdram-edac.txt       |  25 ++
>  MAINTAINERS                                   |   6 +
>  arch/arm/boot/dts/aspeed-g5.dtsi              |   7 +
>  drivers/edac/Kconfig                          |   8 +
>  drivers/edac/Makefile                         |   1 +
>  drivers/edac/aspeed_edac.c                    | 421 ++++++++++++++++++
>  6 files changed, 468 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
>  create mode 100644 drivers/edac/aspeed_edac.c
> 
> -- 

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
