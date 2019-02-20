Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E88C10F07
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:39:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE04218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dpfqhXkT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="as4Yp+ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE04218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oViKQuFCfplnmzbQ//XbD+oOkAekNUP3XrCkdbGEOLI=; b=dpfqhXkT0loCMI
	Gnen481qQq5sh1HvEPfiGyF1Dde+3akn3L3zsZoWBltVrCTJ26Pmxa/MM0psLkbbabqnuRelRL5zX
	NLIH/RQZkfEDHvZSB0+NUgAEZtNan3g2KwvzAJNXBXavZVh6JF3tVymbS4hlVYXjfm4S2iOjnMhCr
	YNC/wDZDyU1EsijZlhl1vDJGnxjF+GSbaJcaFMV05NbQV+3lDR2CATzfyyYwZtanV/VPGsD54IiX9
	pn6dRhPM2TYKStJraDKL23KoyaUUsG3syViiXtPxDUxga9+P3sDHo/0G3C5L/v2/sdq4hWVWjYd0a
	xDiEi0CxyjBXp16jrysA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwXij-0000IP-1k; Wed, 20 Feb 2019 19:39:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwXif-0000Hv-8Q
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 19:39:50 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD5C321841;
 Wed, 20 Feb 2019 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550691589;
 bh=gNmgl0sPPT06uTyj0gtld9JGOJ+KPfUjkDUka38IMig=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=as4Yp+owvdXJZcOZ6PqnsZo9m/Bo/VLMQ/zq2TLNoP6TPGId0cyyrMmFzFWyfOg9C
 R2nyJB6+A1zKONDKnLYi3zoFRE73ts5sdEHyWSri0yrmpvw0k0Gi4+BR9utwGAwqxa
 zJ+u2WusPBGA4W2skEDD6kwS3frtuQjVKaBQb7sM=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Message-ID: <155069158817.77512.2569138453972131411@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
 <23696765-c2c7-0df8-1bfd-2dfd96f65e9d@microchip.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <23696765-c2c7-0df8-1bfd-2dfd96f65e9d@microchip.com>
To: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Date: Wed, 20 Feb 2019 11:39:48 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_113949_318404_0AE15355 
X-CRM114-Status: GOOD (  12.23  )
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
Cc: mturquette@baylibre.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Nicolas.Ferre@microchip.com (2019-02-20 03:18:40)
> On 19/02/2019 at 17:51, Alexandre Belloni wrote:
> > nck() looks at the last id in an array and unfortunately,
> > at91sam9x35_periphck has a sentinel, hence the id is 0 and the calculated
> > number of peripheral clocks is 1 instead of a maximum of 31.
> > 
> > Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: <stable@vger.kernel.org> # v4.20+
> 
> It would be nice to queue it as a fix the soonest, as it impacts 5.0 but 
> not 4.20 due to a switch from one DT binding to another (read: a real 
> regression)... But I know it's a bit late in the cycle...
> 

Ok. Let's send it off tomorrow.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
