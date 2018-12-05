Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF3C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:00:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9950A20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PGFDaMl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9950A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tUSdhQa5UV7n1+W3wGlqfBUwuMrLZgCgpJFkrNHjCzg=; b=PGFDaMl3ki72q1
	+lrmymd8WcQZ8U9rs+W+olJyccTocIzE/0nsXwx3iantlg7gI+eiaBMcQ7uOrZuWBQLoGAtBSbV47
	DKjL7dFM+kqJbV7O0oHdLjn3u0XYXFuZg0V/JO//8qNAxutPjSVbLg1wfZDM/IDpo4kJaZKRXnsNG
	5OaUFrGtXgUS48YkJt7icU5jAjq/00paj318cYD8kQ6O2b/llm1E02vZUJw+qP4QEFM/5xa01ytuZ
	p5vcShhVSBwu78Kro7K9BmW0Vpj6IZMgvqpQk275HJZX73j3tE29LK9Vxa5PJSJmAx9mIreWbss0S
	HhCB2565JWw6rQ5Vloag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUcPa-0006zH-Ui; Wed, 05 Dec 2018 19:00:42 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUcPX-0006xg-Vk
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 19:00:41 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 253AD803A;
 Wed,  5 Dec 2018 19:00:25 +0000 (UTC)
Date: Wed, 5 Dec 2018 11:00:19 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/4] ARM: dts: am437x: Move l4 child devices to probe
 them with ti-sysc
Message-ID: <20181205190019.GG6707@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-3-tony@atomide.com>
 <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
 <20181204181121.GC6707@atomide.com>
 <20181204231833.GF6707@atomide.com>
 <3feb7078-5690-abf6-2a9d-a65807ee701a@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3feb7078-5690-abf6-2a9d-a65807ee701a@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_110040_060218_25D32515 
X-CRM114-Status: UNSURE (   8.83  )
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
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
 Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
 =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181205 06:12]:
> On 05/12/2018 1.18, Tony Lindgren wrote:
> > After applying " drm/omap: fix bus_flags for panel-dpi" LCD
> > works again. But modprobe of snd-soc-davinci-mcasp and
> > snd-soc-tlv320aic3x still does not show anything with aplay -l.
> 
> Hrm, why they are not loaded automatically?

Hmm I guess I'm missing some piece of software I've
removed from my system years ago already? :)

> > Do I need some other patch or codec driver?
> 
> snd-soc-edma
> snd-soc-davinci-mcasp
> snd-soc-tlv320aic3x
> snd-soc-simple-card

Oh I thought I tried that but maybe I tried with graph card.
Got it working now thanks.

I think we're missing the top level ranges for mcasp l3 port
and the translation goes wrong there, I'll fix it hopefully
today.

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
