Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5BC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:11:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4706E21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n1/DlO9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4706E21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tGYOUE2bvASP+bwPkOJr1pslzHrtxON6v8CQrfFUelw=; b=n1/DlO9B0zTkpA
	7W5SgNJlAITlI3QYk9cWi5OMHiLl0VRmWTc5LuK9vWPPg+nyC3EEyI5XI485OeZnMi/aKuoWYWdtZ
	f3eSoniuddNmn8b28HEFA5Uk+puRpJK3iDUt5ly/AZg6al9GRT9fo7HMgWjhcWxpaFkwnyqtYHCFR
	GZCN5iF/TSwiUxd4XoIowUPtNMU+mf77O1I669FUPN89Z7ElnkGT0NXEA6MB6t37LQLsb/d1HgWJg
	Mj/qQI+ql3ytYbjG4M7EV1aKHXJa2+apXnav++v209xaXuzlkj4kR4cuIMqXr2dXiRM/RAOAAp3IU
	0PpIDc5vszkGT+MuEZ5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbyM-0001tL-9I; Thu, 24 Jan 2019 10:10:58 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbyI-0001sy-AC
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 10:10:55 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1gmby8-0007Ex-1K; Thu, 24 Jan 2019 11:10:44 +0100
Message-ID: <1548324643.6014.8.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/3] firmware: xilinx: Add reset API's
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne
 <nava.manne@xilinx.com>, robh+dt@kernel.org, mark.rutland@arm.com, 
 rajanv@xilinx.com, jollys@xilinx.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 chinnikishore369@gmail.com
Date: Thu, 24 Jan 2019 11:10:43 +0100
In-Reply-To: <e0f6e1d3-e443-040e-8c07-79359e2af37a@xilinx.com>
References: <20190125074654.10950-1-nava.manne@xilinx.com>
 <20190125074654.10950-2-nava.manne@xilinx.com>
 <1548322989.6014.4.camel@pengutronix.de>
 <e0f6e1d3-e443-040e-8c07-79359e2af37a@xilinx.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_021054_511443_D274414A 
X-CRM114-Status: GOOD (  12.44  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-24 at 10:49 +0100, Michal Simek wrote:
> On 24. 01. 19 10:43, Philipp Zabel wrote:
> > On Fri, 2019-01-25 at 13:16 +0530, Nava kishore Manne wrote:
> > > This Patch Adds reset API's to support release, assert
> > > and status functionalities by using firmware interface.
> > > 
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > 
> > Michal, Should I merge this through the reset tree together with the
> > reset driver?
> 
> It would be better if this goes via my tree. There is at least one
> series which also touches the same parts in these files that's why there
> will be collisions.
> 
> If you can review that I will take it via my tree and arm-soc guys to
> mainline.

Ok, thanks. Feel free to add my

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to to reset patches and pick them up together into your tree.

regards
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
