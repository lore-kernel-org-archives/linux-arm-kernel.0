Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:49:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164342081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="shb9Nc7G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjvzESE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164342081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=smIlJ1DZHO6qcbJQxjvd97pH+hhaT2v8Lewcz7tLTtc=; b=shb9Nc7GDhHOuZ
	BbT3Sds3Ymnsk0KcAMOnoMr4JWqhH0w605mHY/8QlN6Y3WRB3YDYnghzlTGyC0FP5xIan8wnzSG8N
	POQXz0LVKilymdREq/puvNWDc9637ak9iJOkcud+hSPwmiVFOpnLY+tnC5UgabeaKO8vK2PETL923
	r9DQ+cebDkypVCsIq78sLvuZi7b+7uLAnPqZC6WUn2kuT2V0/mrhj7ECfIxj6aqyAY3ub41rOnbDd
	QjhwByh2NiNt4t1JgbBTxeL/MBT3GfwEbSs3h2CYtSgRxJKYjICXfEqth3n2jwIEGaTmkDmBf9jhr
	pchTTELPRm4vj0mr8X9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdE3e-00087E-36; Sat, 29 Dec 2018 12:49:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdE3b-00085c-0i; Sat, 29 Dec 2018 12:49:36 +0000
Received: from localhost (83-68-17-109.ip.xs4all.nl [83.68.17.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 879D42081B;
 Sat, 29 Dec 2018 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546087764;
 bh=K5tHIdGxD5w9c0Sx/kxQmPHSmItASLtP1uBdx5nzfRo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tjvzESE6CL4QcJGlKulO0+63qOHs9wGcaff+WFcOpeMkSruNjBj6TPBtkM2U5/M3M
 WB49wDfnQnoSKEqpbyHyYgnahPAGieK+omVP3SjA4jM4TRLIZgGhuza0v9tt8tRXwC
 vUY3GpktIKxQnSGIx4mtUS4cl85otqKYuFhm0Hh4=
Date: Sat, 29 Dec 2018 13:49:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH] usb: devio: update max count of DPs per interval for ISOC
Message-ID: <20181229124921.GA5959@kroah.com>
References: <1545992864-9530-1-git-send-email-chunfeng.yun@mediatek.com>
 <20181228105148.GA22073@kroah.com>
 <1546051720.32173.139.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546051720.32173.139.camel@mhfsdcap03>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_044935_083110_A763678C 
X-CRM114-Status: GOOD (  22.21  )
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
Cc: devicetree@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 29, 2018 at 10:48:40AM +0800, Chunfeng Yun wrote:
> Hi,
> On Fri, 2018-12-28 at 11:51 +0100, Greg Kroah-Hartman wrote:
> > On Fri, Dec 28, 2018 at 06:27:44PM +0800, Chunfeng Yun wrote:
> > > The host shall be able to accept and send up to 96 DPs for
> > > devices operating at Gen 2 speed.
> > 
> > Why?  What is this keeping from working properly today?
> 
> The failure happened when I tried to send up to 96DPs per an interval
> for SSP ISOC transations by libusb, this is used to verify SSP ISOC
> function of USB3 GEN2 controller. Maybe for normal scenarios they
> needn't transfer greater than 48 DPs in an ISOC interval.
> (refer usb3.1r1.0 section 8.12.6 Isochronous Transactions)

Ok, please add this information in the changelog text please.

> > 
> > I need a much better changelog text here in order to be able to accept
> > this patch.
> I'll make the change in next version
> > 
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >  drivers/usb/core/devio.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > > index a75bc0b8a50f..82c16210e34c 100644
> > > --- a/drivers/usb/core/devio.c
> > > +++ b/drivers/usb/core/devio.c
> > > @@ -1564,12 +1564,10 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
> > >  		}
> > >  		for (totlen = u = 0; u < number_of_packets; u++) {
> > >  			/*
> > > -			 * arbitrary limit need for USB 3.0
> > > -			 * bMaxBurst (0~15 allowed, 1~16 packets)
> > > -			 * bmAttributes (bit 1:0, mult 0~2, 1~3 packets)
> > > -			 * sizemax: 1024 * 16 * 3 = 49152
> > > +			 * arbitrary limit need for USB 3.1 Gen2
> > > +			 * sizemax: 96 DPs at SSP, 96 * 1024 = 98304
> > >  			 */
> > > -			if (isopkt[u].length > 49152) {
> > > +			if (isopkt[u].length > 98304) {
> > 
> > Are we going to have to keep bumping this up as speeds get faster and
> > faster?
> Or remove the check of data length? I'm not sure which way is better

No, we added that check for a good reason, please see the git log for
the details :)

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
