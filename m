Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F06C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:41:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257DA20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gfc8LkyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257DA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qxWI3lXu/m+N+IjuOEsh3rwfekJJkjekP10CCUcVdbw=; b=Gfc8LkyR2Dar4pFms1tK/50Jr
	Kbun9ZVfKzKiNSTca4AIVuGkAUbpFRdGGRdi3uL3TT+dqBSuKijrSA69MXr/kQ6+DpX4oE4zP8JoT
	KvkEkACsk4m33nECQL5r3jcEwTofXrJURU8v771wBGmzpj5O3193B107Rn6O0WyTriM2iVM+Qo16p
	RxejrLZVJMglcW8r1tZQtrNJk54KI6g+zzNngDtprp86q/7qqEdeS0QStyMOJgt5UvXKQ1uqSLo7h
	ITpFVQm87GWEjHORSP1aM8zl/6XbmQke+N/ufc/biNb26GxyRG5a0/7YNEHjopnQYTDJthKSYgTgw
	qxQR9uDEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFdu-00011Z-32; Tue, 04 Dec 2018 18:41:58 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFdq-00010t-6r
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:41:55 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2018 10:41:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; d="scan'208";a="106960764"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.122.128.138])
 ([10.122.128.138])
 by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2018 10:41:42 -0800
Subject: Re: [PATCH] clk: aspeed: Mark lclk (LPC) and espiclk (eSPI) as
 critical
To: Stephen Boyd <sboyd@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, Michael Turquette <mturquette@baylibre.com>
References: <20181204172357.23665-1-jae.hyun.yoo@linux.intel.com>
 <154394694584.88331.12700815292714558990@swboyd.mtv.corp.google.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <823c0ad5-a03c-86ea-f089-556420e9878a@linux.intel.com>
Date: Tue, 4 Dec 2018 12:41:38 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154394694584.88331.12700815292714558990@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_104154_280350_5FC00F5C 
X-CRM114-Status: GOOD (  13.60  )
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
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 Samuel Jiang <chyishian.jiang@gmail.com>, stable@vger.kernel.org,
 linux-clk@vger.kernel.org, Vijay Khemka <vijaykhemka@fb.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/4/2018 12:09 PM, Stephen Boyd wrote:
> Quoting Jae Hyun Yoo (2018-12-04 09:23:57)
>> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
>> index 596136793fc4..01633ad85683 100644
>> --- a/drivers/clk/clk-aspeed.c
>> +++ b/drivers/clk/clk-aspeed.c
>> @@ -95,7 +95,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>>          [ASPEED_CLK_GATE_DCLK] =        {  5, -1, "dclk-gate",          NULL,   CLK_IS_CRITICAL }, /* DAC */
>>          [ASPEED_CLK_GATE_REFCLK] =      {  6, -1, "refclk-gate",        "clkin", CLK_IS_CRITICAL },
>>          [ASPEED_CLK_GATE_USBPORT2CLK] = {  7,  3, "usb-port2-gate",     NULL,   0 }, /* USB2.0 Host port 2 */
>> -       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   0 }, /* LPC */
>> +       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   CLK_IS_CRITICAL }, /* LPC */
>>          [ASPEED_CLK_GATE_USBUHCICLK] =  {  9, 15, "usb-uhci-gate",      NULL,   0 }, /* USB1.1 (requires port 2 enabled) */
>>          [ASPEED_CLK_GATE_D1CLK] =       { 10, 13, "d1clk-gate",         NULL,   0 }, /* GFX CRT */
>>          [ASPEED_CLK_GATE_YCLK] =        { 13,  4, "yclk-gate",          NULL,   0 }, /* HAC */
>> @@ -103,7 +103,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>>          [ASPEED_CLK_GATE_UART1CLK] =    { 15, -1, "uart1clk-gate",      "uart", 0 }, /* UART1 */
>>          [ASPEED_CLK_GATE_UART2CLK] =    { 16, -1, "uart2clk-gate",      "uart", 0 }, /* UART2 */
>>          [ASPEED_CLK_GATE_UART5CLK] =    { 17, -1, "uart5clk-gate",      "uart", 0 }, /* UART5 */
>> -       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",       NULL,   0 }, /* eSPI */
>> +       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",       NULL,   CLK_IS_CRITICAL }, /* eSPI */
> 
> Can you please add a comment in the code as well so that we can easily
> recall why such clks are marked critical a year from now without having
> to do git archaeology.
> 

Okay, I'll add a comment.

Thanks,
Jae

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
