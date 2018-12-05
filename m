Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DC9C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:18:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CEA2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rp1ulWVi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="m4WqA15r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CEA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HPoxDzdFDuIGB83zRJoILSm8X1NaigMrMucYfkB4Ni0=; b=rp1ulWViR4Sk7Y
	IL3WavvtnDJR6Xv7Is70YspseKgOB/eFbF28aAJe0OGughSgxn9YA2YQUx+oEiuHDyjJInfwdRolg
	hL37FeareB8xRCsMTOAxhcztc1khWSWFgfePE0eJ0FIuismILS7dcFfRulkcAJc+M75ehO+7L1sHV
	lcINbyn0qXPWwBb4jlNWbaP/vREBsRbWUSTnXGbtPX1q5D8PN63v/Xx7vXmv6LDtWVPK07jyb22Ub
	g5o8ocSvm9tv/zwS0rZjNb2G7A2BOx8rStZiBGJ8zkJ1HrcC7o91oCWwkWF6TvlV74nW+JZi3LFvi
	MzKovXoL5og5yT1T4QEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUX4l-0001Sy-UU; Wed, 05 Dec 2018 13:18:51 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUX4h-0001Qs-9G
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 13:18:49 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 15CB4404C5;
 Wed,  5 Dec 2018 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544015883; bh=LE+F8DG5N7ggnglERQ18UEhOa//1vtnU1AFmxWLnLVo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m4WqA15rAQ3jmdJTk63kRur1/vXnnUfLrxBeTNv9rOzySyRVXbX8JQtAXbCRIdawL
 gDk/YbwsgBZCgExY32vnddhNfsy9tvb95VIgPedbcWIFimjsa3ohXXrDokRImhV5iS
 9S3rqJmePqKn6d4OuHZ0AMK1Qyge7HansBfGnRckNEalF0eAs/veS4dr+bkxJ9T0+l
 +cPjdFdIq3jH8ReWvObv1HQt4zxIa+tLoJ+aZeTdkltXf/N/h09+Pv5yKk+m5Mndh5
 j/R8MTvoJ7hV0r9aCAJmUkydjbWHd99OVImacX8QxIuQh0267Ck86ol9RDd5p1h+xN
 MqFqknWDXpQ7g==
Date: Wed, 5 Dec 2018 13:18:02 +0000
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] drm/sun4i: hdmi: Improve compatibility with non-hotplug
 capable connectors
Message-ID: <20181205131801.h2ki7xj2fbegv5b2@plaes.org>
References: <20181116171830.23465-1-plaes@plaes.org>
 <20181119081934.ohjg36zjcb52nrrq@flea>
 <20181119102638.GZ30658@n2100.armlinux.org.uk>
 <20181120085841.bxgdoj7lncbu6ygz@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181120085841.bxgdoj7lncbu6ygz@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_051847_674772_03227329 
X-CRM114-Status: GOOD (  26.51  )
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
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Mats Lundberg <mats.lundberg@paf.com>, Priit Laes <priit.laes@paf.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 20, 2018 at 09:58:41AM +0100, Maxime Ripard wrote:
> On Mon, Nov 19, 2018 at 10:26:38AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 19, 2018 at 09:19:34AM +0100, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Fri, Nov 16, 2018 at 07:18:29PM +0200, Priit Laes wrote:
> > > > From: Priit Laes <priit.laes@paf.com>
> > > > 
> > > > Even though HDMI connector features hotplug detect pin (HPD), there are
> > > > devices that which do not support it.
> > > 
> > > Which devices?
> > > 
> > > > For these devices fall back to additional check on I2C bus. Of
> > > > course, there might be also devices that do not wire DDC pins too,
> > > > so we don't really know whether cable has been connected.
> > > 
> > > Again, which devices?
> > > 
> > > > 
> > > > Signed-off-by: Priit Laes <plaes@plaes.org>
> > > > Signed-off-by: Priit Laes <priit.laes@paf.com>
> > > 
> > > You only need one :)
> > > 
> > > > ---
> > > 
> > > You're doing basically two things in that patch, first adding the
> > > fallback to the DDC probe if the hotplug mechanism couldn't detect the
> > > display, and then returning a status unknown if both fail.
> > > 
> > > While I don't really have an opinion on the first one, it's mandatory
> > > for every HDMI device to be able to retrieve the EDID through the
> > > DDC. If a device was to disallow that, it would violate the HDMI, and
> > > I'm not sure we want to start supporting those devices.
> > 
> > There is also the problem that HDMI uses the HPD signal to indicate
> > that the source should re-read the EDID due to the EDID changing.
> > In HDMI, you don't necessarily have a fixed-for-all-time EDID, but
> > one which can change depending on what devices are in the HDMI path.
> > 
> > Consider, for example, an AV amplifier which needs to subsitute the
> > audio capabilities when it is turned on, but when in standby needs
> > to pass through the TVs audio capabilities.  It informs the source
> > by momentarily deasserting the HDMI HPD signal, which is the HDMI
> > way to inform the source that the EDID should be re-read.
> > 
> > If you're going to use "read EDID" as the hotplug method, I think
> > you need to keep track of when it changes so that EDID updates are
> > correctly handled.
> 
> I didn't think about that, thanks for bringing it up!

Well, currently this is broken anyway, becuse we are doing the polling
due to missing HPD interrupt. You can test by quickly switching between
two different monitors that both have proper HPD pin.

> 
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
