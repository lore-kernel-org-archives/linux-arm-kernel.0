Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EC8C282D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:20:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711C821848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JFCbXY48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711C821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nb66T5ruC6k4mnT1wV4OhneRh9ZTtsQ94FJVaDnPrGQ=; b=JFCbXY48oCUjhV
	FrSFfNoRCH/x4RYar2ihB8jD8/kJ4sRL/j1nny6/JP4VKKG50WyFkR59tXtRX1YBJ3gQl/L1bjM40
	xnmdYdV52hiLipEZFTbIsKBCmRXjRTIQyQkN5Rr2qmNFdmc8oejN0E14wBHCENEpDPDM+9iXaYSQ9
	zqIIIPHHxpndXWeqk538qF8ldbmYIXre+Eqj0odB4ywfBmPB+8jsu97KkYZ6WizhPYo0CmH9hZmgH
	+k3PgegRfyiC20KbrGe5mV1CyE6VfeB+i+DCpbc8HZR4BHaf/XcK7QARbq2l0PChrA+UPGlz1Lwi4
	Iv/nhDbqyt9/iz4mO+kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTJT-0002fg-5q; Tue, 29 Jan 2019 13:20:27 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTJP-0002f2-L1
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:20:25 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2019 05:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; d="scan'208";a="120377237"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
 by fmsmga008.fm.intel.com with ESMTP; 29 Jan 2019 05:20:18 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
 id 9F217205C8; Tue, 29 Jan 2019 15:20:15 +0200 (EET)
Date: Tue, 29 Jan 2019 15:20:15 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: devicetree: media: Documentation of Bt.656 Bus DT bindings
Message-ID: <20190129132015.tvtzycrzr46kotbt@paasikivi.fi.intel.com>
References: <CAPo_4QDW0r22ZTqtS_NDFWB3NFLBx9YEGgWKb-P9A3t_TBAFMQ@mail.gmail.com>
 <c4d68627-b26a-6402-daf4-5cd103ec9fd0@xs4all.nl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c4d68627-b26a-6402-daf4-5cd103ec9fd0@xs4all.nl>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_052023_744949_945DE62F 
X-CRM114-Status: GOOD (  23.74  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, maxime.ripard@bootlin.com,
 linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com,
 Nate Drude <nate.drude@ohmlinxelectronics.com>, wens@csie.org,
 robh+dt@kernel.org, Ken Sloat <ken.sloat@ohmlinxelectronics.com>,
 yong.deng@magewell.com, jean-michel.hautbois@vodalys.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ken, Hans,

On Mon, Jan 28, 2019 at 02:11:54PM +0100, Hans Verkuil wrote:
> +Sakari

Thanks for cc'ing me!

> 
> On 1/24/19 3:53 AM, Ken Sloat wrote:
> > There are a number of v4l2 subdevices in the kernel that support a
> > Bt.656 bus also known as "embedded sync." Previously in older versions
> > of the kernel (and in the current 4.14 LTS kernel), the standard way
> > to enable this in device tree on a parallel bus was to simply omit all
> > hysync and vsync flags.
> > 
> > During some other kernel development I was doing, it was brought to my
> > attention that there is now a standard defined binding in
> > "video-interfaces.txt" called "bus-type" that should be used in order
> > to enable Bt.656 mode. While omitting the flags still appears to work
> > because of other assumptions made in v4l2-fwnode driver, this method
> > is now outdated and improper.
> > 
> > However, I have noticed that several dt binding docs have not been
> > updated to reflect this change and still reference the old method:
> > 
> > Documentation/devicetree/bindings/media/sun6i-csi.txt
> > /* If hsync-active/vsync-active are missing,
> >    embedded BT.656 sync is used */
> > 
> > Documentation/devicetree/bindings/media/i2c/tvp5150.txt
> > "If none of hsync-active, vsync-active and field-even-active is specified,
> > the endpoint is assumed to use embedded BT.656 synchronization."
> > 
> > Documentation/devicetree/bindings/media/i2c/adv7604.txt
> > "If none of hsync-active, vsync-active and pclk-sample is specified the
> >   endpoint will use embedded BT.656 synchronization."
> > 
> > and amazingly even
> > Documentation/devicetree/bindings/media/video-interfaces.txt in one of
> > the code snippets
> > /* If hsync-active/vsync-active are missing,
> >    embedded BT.656 sync is used */

Yeah, these are the old bindings indeed.

> > 
> > In order to avoid future confusion in the matter and ensure that the
> > proper bindings are used, I am proposing submitting patches to update
> > these docs to at minimum remove these statements and maybe even adding
> > additional comments specifying the optional property and value for
> > Bt.656 where missing. I wanted to open a discussion here first before
> > doing this though. Thoughts?

I agree. If a device supports different busses on the same port, then the
bus-type property is needed. This is often the case for Bt.656 and parallel
(Bt.601?) interfaces.

This should be documented so that new devices would use the bus type. The
existing bindings still need to be supported in drivers though.

I cc'd the devicetree list as well.

> > 
> > Thanks,
> > Ken Sloat
> > 
> 
> I certainly agree that this should be updated to make it all consistent.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
