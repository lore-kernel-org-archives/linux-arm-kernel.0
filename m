Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A2C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:24:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C802086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eP9sinAP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOolYOnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C802086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tQ+8W2120Ms03H9ZuzaKEIGZXhXL7aZ1ZG1PkBPESkA=; b=eP9sinAPupj/Br
	zF5hnRA2r1QSZYUV+8lD8/zDARBZoegqaj/EGD+Xis/GMLQatgUu8WApT6wUjgsP20khqYBeNlnli
	PX9vVOlFXTtLOmter4DLTnJs9z/UVsoydp/UQJTQ9cT4jVpzl0Ii5IcmiSas0leGOnJ3y9dBS8BHO
	n72j7s93f72e3hn4CrCsuR7ckZXO4FiTFOuaJNIpzAJNzF8jH4ckrfV2iX2TL4264eab2unWw7cRx
	BjABr7WMDl6IV/0IXAOseXmglb4jrrJGHrFQcBwgvzgODZIJHDe4MOQvv7qqeHlHLWFxjQkNJT/cS
	muXpBRaMP82dZaPv8vOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govTk-00050y-Qs; Wed, 30 Jan 2019 19:24:56 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govTh-00050X-JX
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:24:54 +0000
Received: by mail-oi1-x241.google.com with SMTP id i6so617179oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DB9Ur11kSX9gf4aVWiZ+MxNkFhY4iXGj7VAg+rVnkq4=;
 b=NOolYOnbDvLKDWB4dxIkeE5RAhtxy5E+WjQxDZI/TxkPnSQyuprA40ycz7d9G5vF3e
 sQv0eInqR66mP8AyhsQvmemFS6KasmzVxCR2neg+fGq92ga5Pcu5NFNRO5iNcW9B6ACe
 qKHWVG4ze/MQnfRgtL6S1k95mpxnGL/Sch9i2Ta8xZ7AzNrqTeT9TZkCI+rgyEcpnAi2
 IDZf6gBIJhynRUO0X1zCsNZBfbnY3ovhy4I5BdOePGkPf3oDsoQJqY4CL+4qPIyhldMf
 tepCK9oId4ETMonw4ZzZ9Kak5ZIRF3YKtNYdxo3lvm2WkTu2rNqNy1WWdAv6CjFgItPX
 vEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DB9Ur11kSX9gf4aVWiZ+MxNkFhY4iXGj7VAg+rVnkq4=;
 b=p/jQdVb582CuBUbzB/r4IkGKkW6YQN6WXIwFdzYEArFUYZigVTYHKRbY3/u2R6gwTA
 AHUbl/3EMbfqtETEojCRjQaHQNa3962DqTbEAiTWGPjlwIRJ54qS8WYgU+g1zTLyJzRw
 w63rDRYegq4lzUxZGeIr5POD3e9XUra6HIal4Se81SyEZCOkpIi+o+uMKwkOmcUtv0Cp
 LztG08XGVTH3naTkK9XER/N1nr+vCP6IPBO+OGvgQJuUMNqsLS6D8z5HTGClCsojSUwN
 S1VCKimZoIntywKnQYOVMOVNktDPpAuOUNGvy18BjEUNiIr0f2X0B/bUTQcDLekK+y+U
 DXzw==
X-Gm-Message-State: AJcUukf5xgvMgsRFmyCSwcxUNOYRVvct3r7+VaeWbZ6VQ8pJf98DzpEm
 mBbwCugukdCxcJE1btVICWFbOZU3RHS9mvv7gtQ=
X-Google-Smtp-Source: ALg8bN6zRLGikFZr4DUOP4icLPTOypTiBXMPlpUzcBpW83exry0aHxiDsnhblaenGlX97MAaJnbt50oCJrToaus1viA=
X-Received: by 2002:aca:3092:: with SMTP id
 w140mr13506739oiw.237.1548876291701; 
 Wed, 30 Jan 2019 11:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20190130120511.11555-1-ccaione@baylibre.com>
 <20190130120511.11555-2-ccaione@baylibre.com>
In-Reply-To: <20190130120511.11555-2-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jan 2019 17:24:40 -0200
Message-ID: <CAOMZO5DqY-ofK6JDFGnN2MzqUGYTkDP+xU9xPQFprean2zxHug@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: imx8mq: Add QuadSPI controller
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_112453_654949_6411972A 
X-CRM114-Status: GOOD (  10.29  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:05 AM Carlo Caione <ccaione@baylibre.com> wrote:
>
> Add a node for the Freescale/NXP QuadSPI controller and extend the AIPS3
> memory range to accommodate the QuadSPI-memory region.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
