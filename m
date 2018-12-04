Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B887CC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:18:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8388C2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uKXtQ+ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8388C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0jhU+PaQYdK4w5KcGhh2Wa1pjL8e0mexveUQ1587ny8=; b=uKXtQ+uaW/6reA
	bU+Zcd7JCBbZFuolaWCXNNHdspvV9ogPil5wQWlAHSeiylYsy5QPveWFBO+XrW22I0oN7bM+GNalo
	Av5uixE9Dltkxf8j+C9H1hJ2UZXKOzkvedImpMNh9mVcTGrvRH/Fou05r7a7rZ/HeGtnghSeCHWyI
	+lw+1zYb4bhvP4IfZKzzEON0qRla67dOKNMKvQ5lpKVhEImET8kyOMNBDmsP/Ko+EtS6+lpE6N7el
	KHIZVnTGcSQ08ICn/s/tP393KpEafH1KiyJCFR6QJ72E8XhWkDZ1L/LjknxYnIoxBsfUbqIXa7puC
	WCpRsXtfuoXrZfdXHvlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUJxs-0006wR-6Z; Tue, 04 Dec 2018 23:18:52 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUJxo-0006vf-9N
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 23:18:50 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 04FF080FA;
 Tue,  4 Dec 2018 23:18:38 +0000 (UTC)
Date: Tue, 4 Dec 2018 15:18:33 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/4] ARM: dts: am437x: Move l4 child devices to probe
 them with ti-sysc
Message-ID: <20181204231833.GF6707@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-3-tony@atomide.com>
 <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
 <20181204181121.GC6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204181121.GC6707@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_151848_368105_5C4F9E74 
X-CRM114-Status: GOOD (  14.37  )
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

* Tony Lindgren <tony@atomide.com> [181204 18:11]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [181204 12:22]:
> > Hi Tony,
> > 
> > On 25/09/2018 3.05, Tony Lindgren wrote:
> > > With l4 interconnect hierarchy and ti-sysc interconnect target module
> > > data in place, we can simply move all the related child devices to
> > > their proper location and enable probing using ti-sysc.
> > > 
> > > In general the first child device address range starts at range 0
> > > from the ti-sysc interconnect target so the move involves adjusting
> > > the child device reg properties for that.
> > > 
> > > In case of any regressions, problem devices can be reverted to probe
> > > with legacy platform data as needed by moving them back and removing
> > > the related interconnect target module node.
> > > 
> > > Note that we are not yet moving dss or wkup_m3, those will be moved
> > > later after some related driver changes.
> > 
> > Exactly the same issue as with am335x after:
> > ARM: dts: am335x: Move l4 child devices to probe them with ti-sysc
> > 
> > reverting this patch makes audio working:
> > 
> > Without revert the McASP FIFO would constantly underflow.
> > 
> > Memcpy test via dmatest works with EDMA
> 
> OK I should be able to debug it here with am437x-sk-evm then.
> 
> If it's not immediately obvious what's going on, let's just
> do a revert here too and debug it more separately.

I did not have any luck getting mcasp working on am437x-sk-evm.

After applying " drm/omap: fix bus_flags for panel-dpi" LCD
works again. But modprobe of snd-soc-davinci-mcasp and
snd-soc-tlv320aic3x still does not show anything with aplay -l.

Do I need some other patch or codec driver?

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
