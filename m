Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEB3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:51:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE5B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lvn722gG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO1lAWQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE5B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iLmnZtmrZKiu4xsygcLyOWeyXiS/bnTkcBalSiW5X60=; b=lvn722gGxTZbJR
	t7FZJjCT0Rd4mLhDTnOsypdPBNzShpXy+5VewGB8mGzhGyd1o2V1Rc0H46Qb1Dr+pS2gKMoOfGaEU
	h6Ooq3etwd2TIu3hdHoB323OQxR2BLqH/njvmuyhsOSWW0WUW345MsKsn8Xqiwf+k2HX1RFY2lm9r
	2/tNJX3U9uVBLz2TmI+PYF34mwRrL0CA5G7wmvbM//y7Z+ZbiDYip/Dbrl9Iy6q/14aqh8yIAC7vl
	/LdTPQOBr+DxpWkVwirNhmIdCkCYe2dkOL90nPurFCmPYZYRTF50PYDzGNSv8nqm0aXl3j67zqchE
	bPl6mwq7SdkgbEu5QlfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHel-00056t-Mz; Tue, 04 Dec 2018 20:50:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHej-00056K-3U
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:50:58 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9E66D206B7;
 Tue,  4 Dec 2018 20:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543956646;
 bh=g+aiLKHkeZM364wFgITwqkLDVLGaFWqxe2ynn/FnpFs=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=eO1lAWQGNcwVZvJe36aqOwrbNTem0b/DUiOssSf8Vy4K2HwJml9eL4UknKA8cCd2Z
 koM7BA9/YbWeuNfUHYHz9vDrBZxii5fP2a25+UHIBs6GVSj9D5WbE3cENBYu5619Kf
 c4Y3GEUp7A6WJPkqnTYdAo5lQTgqX8lEsOb/xi1U=
MIME-Version: 1.0
To: Andrew Jeffery <andrew@aj.id.au>,
 Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, 
 Joel Stanley <joel@jms.id.au>, Michael Turquette <mturquette@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204185054.24053-1-jae.hyun.yoo@linux.intel.com>
References: <20181204185054.24053-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <154395664604.88331.16833135233042073777@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: aspeed: Mark lclk (LPC) and espiclk (eSPI) as
 critical
Date: Tue, 04 Dec 2018 12:50:46 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_125057_158710_8686D8CB 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, Samuel Jiang <chyishian.jiang@gmail.com>,
 stable@vger.kernel.org, linux-clk@vger.kernel.org,
 Vijay Khemka <vijaykhemka@fb.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jae Hyun Yoo (2018-12-04 10:50:53)
> These interfaces are used by host to talk to BMC, and the clock
> source is from the host, usually from PCH. So this commit marks
> the lclk as critical to make it able to be enabled. Also, it marks
> espiclk too because eSPI is sharing the same interface with LPC.
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

What does "No parent dependency" mean? I was hoping to see something
like the commit text, "lclk is used to talk to BMC which can happen at
anytime" or something like that.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
