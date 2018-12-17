Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9CAC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:49:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E1E2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FRkaZOxP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="W442v1Mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E1E2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M6ATS4VnKwc+9xeLmd27LpgupQivL5MTXzagQxEDUFY=; b=FRkaZOxPftIv55
	iJskr3WplFJTaOfWnq/UvkIMAV8RrVNymxkhfF6vO/8yekc9Y7HEOC0Mo7uQ/tW/isixNyUM4nHqM
	U5a8b2NfGsYbutwrhkY/oqxYBVUqryQGcJCzUnnGSHz9hhlSdG2Nv9W1YH78siswNgQH2yw36ikpV
	wyCHFdB5rV35rWXlKBPUZHQZRrNnSOw3FcgOGi/a7F6ooJg1xUFYtZpu27LB94zFXUxp9wK6J+0ND
	ksaZYX6/fbplcmR0EW620N3sGA/oHpWDgbCjIuWgKBDzp6qjJrPom+kz2CXtUTFMwjMSPATSALIcc
	AkBRMZ2KjBjcrkVtMMqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYsLI-0001Vp-5u; Mon, 17 Dec 2018 12:49:52 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYsLE-0001VG-RR
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 12:49:50 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 4C64B25B781;
 Mon, 17 Dec 2018 23:49:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1545050977; bh=nSDLUVjN7fL8DOWA58mq3kxyOO42YOa5vrJZD2nMXUg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W442v1MzF/WXu4zVA8CsYsv2xZcEq6A86MB5OdKyXae1dGKJui6D6ebwFMKMd9rU7
 /GknooTuR4mKSdd3vKx3in2x+RbVqYxu3gfRGEtzs1paIRsax0iVBLeYdbNEzepQSH
 9JSo3+ES6M+qY0DlaX8uU0Y3ByruUGlbgd7YVqLc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id B539594048A; Mon, 17 Dec 2018 13:49:35 +0100 (CET)
Date: Mon, 17 Dec 2018 13:49:35 +0100
From: Simon Horman <horms@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] ARM: shmobile: Add missing dts files to MAINTAINERS
Message-ID: <20181217124935.m6nzgznb72eejx44@verge.net.au>
References: <20181212105435.28310-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212105435.28310-1-horms+renesas@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_044949_046067_0DE0BC8B 
X-CRM114-Status: GOOD (  14.45  )
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
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 11:54:35AM +0100, Simon Horman wrote:
> Add some more patterns to the ARM/SHMOBILE ARM ARCHITECTURE
> section of MAINTAINERS to complete the list of maintained dts files.
> 
> As of writing dts files covered are:
> * arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi
> * arch/arm/boot/dts/iwg20d-q7-common.dtsi
> * arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I would value a review of this.

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
>  Based on renesas-devel-20181210-v4.20-rc6
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c7a08740cb7..2d4b90ffb14f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2075,6 +2075,8 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
>  S:	Supported
>  F:	arch/arm/boot/dts/emev2*
> +F:	arch/arm/boot/dts/gr-peach*
> +F:	arch/arm/boot/dts/iwg20d-q7*
>  F:	arch/arm/boot/dts/r7s*
>  F:	arch/arm/boot/dts/r8a*
>  F:	arch/arm/boot/dts/r9a*
> -- 
> 2.11.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
