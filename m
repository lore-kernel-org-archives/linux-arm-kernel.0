Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:11:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DD92081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pjBp330M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DD92081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NiT1sW/1j9iPyaLjUIwHaasHzcobp4uIxwMtNFwH52w=; b=pjBp330MBi7tvb
	V1GTUKWveK9IsK8jrJnnkN/3A/9SgHvuAjdPDY+r4SZrmuO8e0gDp5fs0HoqPzwjMXtfbLrwlwZAH
	x34/fKrQl6P0s7/GqyfhYEh+GOWXu8H4FstPcan7HtV6PZJPg7i9MmdgBX7vmclhve+Rdiml2kiuj
	Ng+nrY6oyku+7MKbOooBhlg3GJsS/dhEv/gilUVXt1et/DkfdsQw0bb0RqOYtIxkA9nuGRKffhHis
	VlWj2tNnJU9EcDlm3gYqGwdQoruOKGQqX9wlgvANDyBgYW+BeC6SIyG+lAH66dK1FpalO25DccY7m
	AwCSKyyF0KMMlzDWFwCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFAa-0004yF-6j; Tue, 04 Dec 2018 18:11:40 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFAX-0004xJ-8M
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:11:38 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 77EAE80FA;
 Tue,  4 Dec 2018 18:11:27 +0000 (UTC)
Date: Tue, 4 Dec 2018 10:11:21 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/4] ARM: dts: am437x: Move l4 child devices to probe
 them with ti-sysc
Message-ID: <20181204181121.GC6707@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-3-tony@atomide.com>
 <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_101137_344687_F5066B99 
X-CRM114-Status: GOOD (  11.72  )
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

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181204 12:22]:
> Hi Tony,
> 
> On 25/09/2018 3.05, Tony Lindgren wrote:
> > With l4 interconnect hierarchy and ti-sysc interconnect target module
> > data in place, we can simply move all the related child devices to
> > their proper location and enable probing using ti-sysc.
> > 
> > In general the first child device address range starts at range 0
> > from the ti-sysc interconnect target so the move involves adjusting
> > the child device reg properties for that.
> > 
> > In case of any regressions, problem devices can be reverted to probe
> > with legacy platform data as needed by moving them back and removing
> > the related interconnect target module node.
> > 
> > Note that we are not yet moving dss or wkup_m3, those will be moved
> > later after some related driver changes.
> 
> Exactly the same issue as with am335x after:
> ARM: dts: am335x: Move l4 child devices to probe them with ti-sysc
> 
> reverting this patch makes audio working:
> 
> Without revert the McASP FIFO would constantly underflow.
> 
> Memcpy test via dmatest works with EDMA

OK I should be able to debug it here with am437x-sk-evm then.

If it's not immediately obvious what's going on, let's just
do a revert here too and debug it more separately.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
