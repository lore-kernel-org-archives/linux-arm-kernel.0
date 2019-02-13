Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF980C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:21:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAB02086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nqy/TMMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAB02086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FPWpi1j2NFlNV8gEE2oaBkliT3r6ZVYoHUwBbAHsTkE=; b=nqy/TMMfAgrP0g
	eAVQLtlwVnvtqZvH5xm0HVNOflJ5BzKqfNxJPv55EYf9Gkgza1/e7T1rVYS/IWCJj9aP3rkZziimg
	MVvTqFFhmTjwzoSVi79J8OZHGLx3aMqQap550ewlRnCOHc+ioh8SsOqftWNQZPzlhCqN1wGLYWgJs
	oinGbFk/WUduYXMdDcv0cCJj2DEaOmHBpiCBVQYBd1LloRECsv5oCW+a3x/am/UPS3Ai9wJJD+c/F
	TX/Gtf6XmU7bWRRmnBiPQb048p4pQeD4u/eED+9RfKCTl7W5M6rhqzlHcwQCXbBX66+Og3bOYNrde
	fzu3pk4suFpIT1UDvgaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyEL-0005bV-Rh; Wed, 13 Feb 2019 17:21:53 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtyEH-0005b3-PM
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:21:51 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id A756A4509A1;
 Wed, 13 Feb 2019 17:21:45 +0000 (GMT)
Subject: Re: LPC3250 periph clock at 13MHz instead of 10.4MHz
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20190212165221.GA10129@piout.net>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <aa8416ba-c81d-d857-e2b7-4b555455e500@mleia.com>
Date: Wed, 13 Feb 2019 19:21:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190212165221.GA10129@piout.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190213_172145_716584_8F3222A3 
X-CRM114-Status: GOOD (  19.75  )
/bin/ln: failed to access
 'reaver_cache/texts/20190213_172145_716584_8F3222A3': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_172145_716584_8F3222A3 
X-CRM114-Status: GOOD (  23.45  )
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
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Alexandre,

On 02/12/2019 06:52 PM, Alexandre Belloni wrote:
> Hi,
> 
> I've been observing a mismatch between the reported periph clock
> frequency and the actuall periph clock frequency on a custom board.
> 
> clk_summary gives:
> 
>  xtal                                 1        1        1    13000000          0     0  50000
>     osc                               2        2        1    13000000          0     0  50000
>        sys                            1        1        0    13000000          0     0  50000
>           hclk_pll                    3        3        0   208000000          0     0  50000
>              hclk_div_periph          1        1        0    10400000          0     0  50000
>                 sysclk_periph_mux       1        1        0    10400000          0     0  50000
>                    pclk               4        4        0    10400000          0     0  50000
>                       uart5           1        1        0    10400000          0     0  50000
>                       timer0          1        1        0    10400000          0     0  50000
>                       timer1          1        1        0    10400000          0     0  50000
> 
> 
> And this seems quite right when reading the registers using devmem.
> 
> But, I observed that the input clock for UART5 seems to be 13MHz. At
> 9600 bauds, the calculated UnDLM:UnDLL is 68 (which would give
> 10400000/(16*68) = 9558 bauds) but at the oscilloscope, I see that the
> UARt is running close to 12kHz. Forcing the frequency to 13MHz, gives a
> divisor of 85 and solves the issue.
> 
> Note that this issue will not be seen right away at 115200 bauds because
> the divisor is then quite close (6 for 10.4MHz and 7 for 13MHz).
> 
> Similarily using an i2c RTC, I can see that the timer is quite off:
> 
> # hwclock; sleep 10; hwclock
> Tue Feb 12 16:53:09 2019  0.000000 seconds
> Tue Feb 12 16:53:17 2019  0.000000 seconds
> 
> This is what is expected if the 13MHz input clock is mistaken as 10.4MHz
> as 10*10.4/13 = 8s.
> 
> This leads me to think that pclk is actually running at 13MHz.
> 
> PWR_CTRL is set to 0x16 so the pclk parent should be hclk_div and not
> sysclk.
> 
> Am I missing something?
> 

I think I encountered quite a similar issue previously, but under another
circumstances, when I begin to modify HCLK PLL clock rate, can you check
my comment at https://lore.kernel.org/linux-clk/56D685F6.5060400@mleia.com/
and verify if it's about the same problem?

Since the problem hits you also, I plan to spend some time on this weekend
to capture more details, fortunately there is a known workaround to pin
UART input clock rate to 13MHz, it might be desired to carve it in the code.

Thank you for report.

--
Best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
