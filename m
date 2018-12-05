Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E522FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:04:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB42206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q6UfAHjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB42206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qUBXuw7tn3ys4n26SaNm3+dBm0DGIpYFslB2Vt4V8o0=; b=q6UfAHjHEJRJfMl0M4E7EvnFl
	TuQaXyJyDyuea/p+R3ojm22SQSn+TwZIb7NEpEb8AZ/9OkGXR+dW2/fvfwHFuRze6vzmIUNXMvC2c
	6H+/y5/2eYQw5uXqM+t8sNsc7sNhHNX0QbEbB3c1zcf4YM4+M2wiOnwzdxcRuwvObSkgo/qzTdJXv
	uB4PWButuGjZ4C169o+jr3f9md4Fs4raMkFHlH5VH7NKIcW3ghOsZFYu9UoZVUGcehV91e5xwt2oW
	ZUh1DrRwv4IeDkUp/wRUFMBjYl7+hqY6RlSXHqzvJQSstxzjWtiek/pNlICosqSwq9wD4s9hWTDKK
	JqqhYlk7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYjM-0007yV-H1; Wed, 05 Dec 2018 15:04:52 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUYjE-0007kT-CH
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:04:48 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Dec 2018 07:04:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; d="scan'208";a="125312616"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.122.128.138])
 ([10.122.128.138])
 by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2018 07:04:33 -0800
Subject: Re: [PATCH v2] clk: aspeed: Mark lclk (LPC) and espiclk (eSPI) as
 critical
To: Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>
References: <20181204185054.24053-1-jae.hyun.yoo@linux.intel.com>
 <CACPK8XcwMMoxG6vhDhUU8RYGABx7rtBoxJvp2yDhHeD-PemdqA@mail.gmail.com>
 <154395687459.88331.13570416457347078441@swboyd.mtv.corp.google.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <697a184b-ef99-a46e-bf98-4d339b3aafd8@linux.intel.com>
Date: Wed, 5 Dec 2018 09:04:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154395687459.88331.13570416457347078441@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_070444_778513_507478F8 
X-CRM114-Status: GOOD (  18.24  )
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
 OpenBMC Maillist <openbmc@lists.ozlabs.org>, chyishian.jiang@gmail.com,
 "# 3.4.x" <stable@vger.kernel.org>, linux-clk@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michael Turquette <mturquette@baylibre.com>, vijaykhemka@fb.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/4/2018 2:54 PM, Stephen Boyd wrote:
> Quoting Joel Stanley (2018-12-04 12:51:43)
>> Hi Jae,
>>
>> On Wed, 5 Dec 2018 at 05:20, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>>
>>> These interfaces are used by host to talk to BMC, and the clock
>>> source is from the host, usually from PCH. So this commit marks
>>> the lclk as critical to make it able to be enabled. Also, it marks
>>> espiclk too because eSPI is sharing the same interface with LPC.
>>
>> While this is true on the platform you have in mind, on other
>> platforms this is not the case. They do not use eSPI, and LCLK is
>> enabled by the driver that is used to configure LPC
>> (drivers/misc/aspeed-lpc-ctrl.c):
>>
>>   lpc_ctrl: lpc-ctrl@0 {
>>       compatible = "aspeed,ast2400-lpc-ctrl";
>>       reg = <0x0 0x80>;
>>       clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>>   }
>>
>> I wonder if we need a device tree binding to describe which clocks are critical.
> 
> A binding to describe critical clks has been rejected in the past. I
> don't think we need to have it here either? More information on why
> things are being marked critical will be helpful to see if we need to
> re-open that discussion again.
> 
>>
>> Stephen, please don't merge this patch yet.
>>
> 
> Sure.
> 

Hi Stephen and Joel,

Thanks for blocking this patch. We checked that LCLK gate can be opened
by enabling lpc-ctrl node without using this change. Please drop this
patch.

Thanks,
Jae

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
