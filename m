Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74976C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:08:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E61321104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jKyQ71TW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E61321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=se3yFtkmv+XHXZ7ToZyqr20UCNFUGP5V8sm12nl14MQ=; b=jKyQ71TWF/yRcr
	xTr3pqtSrNEOO/f7fEqusDktgbAzlFNg8TnDrvHmGnneWe/9vB9/DhT3ASpvMn7vSvOg/biBQ/ogA
	X40eJ6ZvuJvs1gUxasWTAORSiY0AKLSHZCGqX6G4rcTWOc0XFNGUGaecYfZPkAxr0EnVgJDq7NpS3
	xWoE9+Yxx5/knZ7MqTrumvuhSqTSGGX9ktq07FPm7B6uSnLATUB2BDUG2SXMjxs0v0e+WI1UYr0A5
	h5CUgKPAyAxblR4DBOsB6fn7LghEpbKrEqRvb63ABNyfoHU0XHjr/ssL0WyWitOcZBPyitXBFlLUM
	Tgn8NG8/AfKg0HxOzaVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSRfa-0001kd-R1; Thu, 29 Nov 2018 19:08:14 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSRfX-0001k9-RA
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 19:08:13 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 465C080EA;
 Thu, 29 Nov 2018 19:08:03 +0000 (UTC)
Date: Thu, 29 Nov 2018 11:07:58 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/4] ARM: dts: am335x: Move l4 child devices to probe
 them with ti-sysc
Message-ID: <20181129190758.GW53235@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-5-tony@atomide.com>
 <612b09a4-5007-39bf-becb-66fdca9d6d41@ti.com>
 <20181127161625.GR53235@atomide.com>
 <e1f4e272-32aa-1a28-6919-fd8a92f80ce8@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1f4e272-32aa-1a28-6919-fd8a92f80ce8@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_110811_919465_C755A0D7 
X-CRM114-Status: GOOD (  11.30  )
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
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
 Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
 =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181128 12:50]:
> 
> 
> On 27/11/2018 18.16, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [181127 13:01]:
> >> Reverting this patch in linux-next makes audio working again on am335x
> >> (bb white + audio cape) :o
> >>
> >> Without revert the McASP FIFO would constantly underflow.
> > 
> > Thanks for testing. Hmm the dts change looks right. And
> > am3_l3s_clkctrl_regs[] has CLKF_SW_SUP for the mcasp fcks.
> > And there are no opt clocks to enable according to the TRM.
> > 
> >> Memcpy test via dmatest works with EDMA
> > 
> > OK. Can you please test if the following partial revert
> > also works or is there maybe a dependency to some other
> > device?
> 
> It works, thanks:
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

OK aplying into omap-for-v4.21/dt-ti-sysc.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
