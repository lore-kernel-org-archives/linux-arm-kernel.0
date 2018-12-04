Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A921BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:52:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78294206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FQSg2oHL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="k3l9GEIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78294206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RHIR1oIeblM3t8NyrPqaX+ppa2BIQsseBj6XuqWQBF8=; b=FQSg2oHLmjlgZj
	dlRc1ow7MJxkpQLE++JAMMw6pMzRDCu9D8nFQxwT/L4Ao8qEt8BsHai5LwQZRXz0MM1tWbSESA/l+
	k0jgTL3pez759pv5bhIFFTNhpiBNBqGqIkFGf/KzSEb5+NzBF+BHHxkkMk5BeD07f6zFhlJmMW4/X
	SUapkmUcTY52iEchy5edrtuxfLcDTKTvi9eveziBcQ/G0Hh5LUbbZq/hqQwIA1/6Np1Kt16FNvjAR
	EugYZ4WK5mYxIDzrM9eKGAmfitkHUgdNu8KtpYTJVri7YPJHZhU/rkNp0LM75tw6gGKLP8m++921h
	LSFZJtghGX0swvcq4W9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHfx-0005jc-Bf; Tue, 04 Dec 2018 20:52:13 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHfr-0005hh-Ev
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:52:11 +0000
Received: by mail-qk1-x741.google.com with SMTP id r71so10523667qkr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 12:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hkWzP0yt40PfczAFgSa/UvNICUnu1M2oCe6p4pZO8eo=;
 b=k3l9GEIySt3MGOrquGqgmfT/0+NcY4IDChY1H6qYsuZ4h2maRvJu7pFEeCcTeoSXbW
 SxVR5H3p3ssA4Ek1Dg/Ykdbt8JnO+DYb2uLyVOYUlT5jXJHZMYe+5Us8rTCtHrgpwnfh
 gQ6JA2UPDSYn2WKKOCfeGIRlx/wrweI1K0IHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hkWzP0yt40PfczAFgSa/UvNICUnu1M2oCe6p4pZO8eo=;
 b=W/Y/mwtdHXuzElXR2o0DnbGxB6g85WFvvg6auzSdGfgpcOblDPNmFdukczgzdaUTgP
 S5n2jD8g3VeqNc3kZ8cYcSgfQIy0mSq9x4tPnNpbV0T58m09geh17LjyOliwxGuAk/p9
 /rTTBGihL5QF+6nwh7VBpoGM7DX+nEFQw1ApHJ1H8wOmfDvbLI6Dmp8u7ESP2qB7j8ak
 Ngq43lcVuqOH3L4fwOyZllxBvzUtJI/b5IoRC814s52O8vc2d9K7cnxYp3xEA7ghbReu
 tPlQtjMhQgfJvgayhU16eSQg2oL/HWZaY6MXU4IryUoSAypvRDtCjGdrm2q2eRQR7yA3
 mbgA==
X-Gm-Message-State: AA+aEWZQmJfZKrxipiZhd3Qjh9YNMgiJjlLA/s3szo66MuLIBHjfKu65
 r0brt18safhb3zoRYwX3wqF6xWKxtjlBzMoIs/4=
X-Google-Smtp-Source: AFSGD/UbjOiFHyzCLzEexEd2M7TrM3WrLMSZCQRRlUhHHx0Z5UG6DJ0/ahKSORJZ4bLzGd8iTIKiNWku6P8ESdgxISw=
X-Received: by 2002:a37:2b5b:: with SMTP id r88mr20793549qkh.336.1543956715762; 
 Tue, 04 Dec 2018 12:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20181204185054.24053-1-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20181204185054.24053-1-jae.hyun.yoo@linux.intel.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 5 Dec 2018 07:21:43 +1030
Message-ID: <CACPK8XcwMMoxG6vhDhUU8RYGABx7rtBoxJvp2yDhHeD-PemdqA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: aspeed: Mark lclk (LPC) and espiclk (eSPI) as
 critical
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_125207_505935_CFDC5607 
X-CRM114-Status: GOOD (  18.79  )
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
Cc: linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Michael Turquette <mturquette@baylibre.com>, chyishian.jiang@gmail.com,
 "# 3.4.x" <stable@vger.kernel.org>, linux-clk@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, vijaykhemka@fb.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jae,

On Wed, 5 Dec 2018 at 05:20, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> These interfaces are used by host to talk to BMC, and the clock
> source is from the host, usually from PCH. So this commit marks
> the lclk as critical to make it able to be enabled. Also, it marks
> espiclk too because eSPI is sharing the same interface with LPC.

While this is true on the platform you have in mind, on other
platforms this is not the case. They do not use eSPI, and LCLK is
enabled by the driver that is used to configure LPC
(drivers/misc/aspeed-lpc-ctrl.c):

 lpc_ctrl: lpc-ctrl@0 {
     compatible = "aspeed,ast2400-lpc-ctrl";
     reg = <0x0 0x80>;
     clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 }

I wonder if we need a device tree binding to describe which clocks are critical.

Stephen, please don't merge this patch yet.

Cheers,

Joel


>
> Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
> Cc: stable@vger.kernel.org
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/clk/clk-aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 596136793fc4..df9504427246 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -95,7 +95,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>         [ASPEED_CLK_GATE_DCLK] =        {  5, -1, "dclk-gate",          NULL,   CLK_IS_CRITICAL }, /* DAC */
>         [ASPEED_CLK_GATE_REFCLK] =      {  6, -1, "refclk-gate",        "clkin", CLK_IS_CRITICAL },
>         [ASPEED_CLK_GATE_USBPORT2CLK] = {  7,  3, "usb-port2-gate",     NULL,   0 }, /* USB2.0 Host port 2 */
> -       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   0 }, /* LPC */
> +       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   CLK_IS_CRITICAL }, /* LPC clock from host. No parent dependency */
>         [ASPEED_CLK_GATE_USBUHCICLK] =  {  9, 15, "usb-uhci-gate",      NULL,   0 }, /* USB1.1 (requires port 2 enabled) */
>         [ASPEED_CLK_GATE_D1CLK] =       { 10, 13, "d1clk-gate",         NULL,   0 }, /* GFX CRT */
>         [ASPEED_CLK_GATE_YCLK] =        { 13,  4, "yclk-gate",          NULL,   0 }, /* HAC */
> @@ -103,7 +103,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>         [ASPEED_CLK_GATE_UART1CLK] =    { 15, -1, "uart1clk-gate",      "uart", 0 }, /* UART1 */
>         [ASPEED_CLK_GATE_UART2CLK] =    { 16, -1, "uart2clk-gate",      "uart", 0 }, /* UART2 */
>         [ASPEED_CLK_GATE_UART5CLK] =    { 17, -1, "uart5clk-gate",      "uart", 0 }, /* UART5 */
> -       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",       NULL,   0 }, /* eSPI */
> +       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",       NULL,   CLK_IS_CRITICAL }, /* eSPI clock from host. No parent dependency */
>         [ASPEED_CLK_GATE_MAC1CLK] =     { 20, 11, "mac1clk-gate",       "mac",  0 }, /* MAC1 */
>         [ASPEED_CLK_GATE_MAC2CLK] =     { 21, 12, "mac2clk-gate",       "mac",  0 }, /* MAC2 */
>         [ASPEED_CLK_GATE_RSACLK] =      { 24, -1, "rsaclk-gate",        NULL,   0 }, /* RSA */
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
