Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E84AC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:20:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B3D20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KJMzhdLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B3D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dAe2EhH0ShhboMOo5WzvYmifMW50NPgze6JCOfLZsQ4=; b=KJMzhdLXsWprjz
	P3TAqC5lZr64YQSmxLbh59S1sezMHYlit06+g8uKHr9zaQxIoFoJ5D/evPtrQ5B0bompgpEsW/cRi
	PiET6E4cEp4IJEE+Lpw8zcCJ0QUNz3MqeGXR2d4h4la4J9Thfmy0cJiGk3MPqR9TYM5sJJtwgddMS
	oNS+Qu6j7Z6Q6YSD+17aQzqP6ft+iNTO7lV/ZfjFMxPElV7SYZdiFnq7/nHWIHbK5k2VKjIZo3Jdu
	gbXhnoAQNCqWKvMDWkysj773UZ2eefUggftbFddGgcvK9BV4SIODdDrsCXthvyjeUZWCBEVFseDj9
	ygzSFJluDWfdx8UhJswQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXFfc-0002xA-3b; Thu, 13 Dec 2018 01:20:08 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXFfY-00021O-V2
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:20:06 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 92BE5809F;
 Thu, 13 Dec 2018 01:19:56 +0000 (UTC)
Date: Wed, 12 Dec 2018 17:19:50 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: dts: omap5: Add l4 interconnect hierarchy and
 ti-sysc data
Message-ID: <20181213011950.GM6707@atomide.com>
References: <20181115224546.61475-1-tony@atomide.com>
 <9b7e07ae-66f9-cedf-937d-b1c5c510e018@ti.com>
 <ebc7e271-8717-fe9d-d24f-ae406860b913@ti.com>
 <20181212171143.GG6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212171143.GG6707@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_172005_043873_7EC42D69 
X-CRM114-Status: GOOD (  11.35  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
 linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
 Faiz Abbas <faiz_abbas@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [181212 17:12]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [181212 02:44]:
> > On 12/12/2018 12.12, Peter Ujfalusi wrote:
> > > Reverting this patch in linux-next-20181210 will make the ethernet
> > > working again.
> > > 
> > > bootlog w/ revert: https://pastebin.com/dpRk1xWv
> > > bootlog w/o revert: https://pastebin.com/PWrBttxd
> > 
> > on omap5-uevm.
> 
> Thanks for testing. Looks like it works for me with
> loadable modules. And looks like changing just the phy to
> use CONFIG_NOP_USB_XCEIV=y in my .config is not enough to
> make it fail, I see it fail too with EHCI built-in.
> 
> It's probably some -EPROBE_DEFER type issues, but I need
> to debug more.

Yes there's an issue where nop_reset() for phy-generic is
not called by ehci-omap. I'll post a fix for that separately.

I also noticed that sata phy reg entries need fixing up
for omap5, will also post a patch for that.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
