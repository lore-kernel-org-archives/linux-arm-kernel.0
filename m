Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8699C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:52:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA25E217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ESyWTQkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA25E217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=O2KJ9R2gPSrFH0WpWgCL/wPp81lt0opYj0mMb54Zq3I=; b=ESyWTQkc9UsVFH
	uFOe8IwQ/nSUC8tYVL+hsYSI3Qkg1H80AU9+i+3ugQxHiA5ynhIPl9SbRahEWgxsAu5QjsINJ5okw
	LCi0TNMD1TLJHpavxoJZ4Qwa/4I+rfzxqkQbVChiJQr7LN6YsQJAebBWUfYyl19WKcBDjHzDapRHT
	oIxib13IDVIlU4izwxm+u5B0n/JOG0w3Iw8Cv0/3rQHddiatsJ02agvo2wTgafJw4EqAr3f9hHRy4
	pSj3rJd64QMUWOKMzYnbVPm3W+gByR/aePlU0XMOnkUEdVlP/qb3BUXPmSIMoZviae15tZoMdULM9
	QQO9A9kZLGXU5+QW9Ahw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbIR-0008Ru-8u; Tue, 12 Feb 2019 16:52:35 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbIN-0008RB-N8
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 16:52:33 +0000
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr
 [109.213.164.40])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0090C200007;
 Tue, 12 Feb 2019 16:52:21 +0000 (UTC)
Date: Tue, 12 Feb 2019 17:52:21 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Vladimir Zapolskiy <vz@mleia.com>
Subject: LPC3250 periph clock at 13MHz instead of 10.4MHz
Message-ID: <20190212165221.GA10129@piout.net>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_085231_909189_817AF36C 
X-CRM114-Status: UNSURE (   9.84  )
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
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

I've been observing a mismatch between the reported periph clock
frequency and the actuall periph clock frequency on a custom board.

clk_summary gives:

 xtal                                 1        1        1    13000000          0     0  50000
    osc                               2        2        1    13000000          0     0  50000
       sys                            1        1        0    13000000          0     0  50000
          hclk_pll                    3        3        0   208000000          0     0  50000
             hclk_div_periph          1        1        0    10400000          0     0  50000
                sysclk_periph_mux       1        1        0    10400000          0     0  50000
                   pclk               4        4        0    10400000          0     0  50000
                      uart5           1        1        0    10400000          0     0  50000
                      timer0          1        1        0    10400000          0     0  50000
                      timer1          1        1        0    10400000          0     0  50000


And this seems quite right when reading the registers using devmem.

But, I observed that the input clock for UART5 seems to be 13MHz. At
9600 bauds, the calculated UnDLM:UnDLL is 68 (which would give
10400000/(16*68) = 9558 bauds) but at the oscilloscope, I see that the
UARt is running close to 12kHz. Forcing the frequency to 13MHz, gives a
divisor of 85 and solves the issue.

Note that this issue will not be seen right away at 115200 bauds because
the divisor is then quite close (6 for 10.4MHz and 7 for 13MHz).

Similarily using an i2c RTC, I can see that the timer is quite off:

# hwclock; sleep 10; hwclock
Tue Feb 12 16:53:09 2019  0.000000 seconds
Tue Feb 12 16:53:17 2019  0.000000 seconds

This is what is expected if the 13MHz input clock is mistaken as 10.4MHz
as 10*10.4/13 = 8s.

This leads me to think that pclk is actually running at 13MHz.

PWR_CTRL is set to 0x16 so the pclk parent should be hclk_div and not
sysclk.

Am I missing something?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
