Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE6AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:56:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C089206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p8XH9ZDB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfmS5C5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C089206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YPuvYHqPIlz/zSap+O/9ojoLO3imb8s1PHHmXRO5bN4=; b=p8XH9ZDBPT1TUE
	lz/eFqwh56c/YO8KzwmWuShri4RI+/p/QRYMoEvnfBMVg/3wBCttzNK6cJglSPEd9BNRhaidtJKkG
	zRF7I3aJeT+7WKVczCSnCkMFN0KsT+gjXaXsJ1m+3uXKA8LJWKdvfDAYiOsvcB4ylEbePXKC3wohA
	6MJ4klovh5giaTuVIzHd/ak2HKtUK8WPCl5bPeqUjExMQS1Sq8t3iw2Sc/2H9N/AUkyLLt2CZmkvW
	quka4eneqHKv7LtQpD1zVQsn0iOKIAVS7ZfiB9Rc+EBBI5a2ZbhsFWqxnLPan4NwAAV3Rkh/0zgcL
	r7/iGLd7DTVogsAM5XEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjis2-0000ug-Om; Wed, 16 Jan 2019 10:56:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjirz-0000uI-F7
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:56:28 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 17462206C2;
 Wed, 16 Jan 2019 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547636187;
 bh=EmVv4PRqc59GVua72fpWk4YU37fiYG4eLvUoBNf6s/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tfmS5C5RNv1FdUMRVbW5SdxFFa7l37bl6Ve10XPriQ026BXh1iY8Kvw97Gc14+d0v
 GiEgeDom+xK0L+DRZgJVlQi5U+jefFnWVDPvWJ+zA2BPfysxFOdj8414V4s1/jQp3k
 NPf1xkD8uJNdTX8ZpgWYXSpgQIBHgZPl7WUWX8r8=
Date: Wed, 16 Jan 2019 18:56:01 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2 platforms
Message-ID: <20190116105559.GM15808@dragon>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
 <20190112024725.GO32649@dragon>
 <VI1PR0402MB2800E8F9F1884EB0669EE9F0E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB2800E8F9F1884EB0669EE9F0E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_025627_523490_6D909D74 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 10:02:01AM +0000, Ioana Ciornei wrote:
> > Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
> > platforms
> > 
> > On Fri, Dec 21, 2018 at 03:31:09PM +0000, Ioana Ciornei wrote:
> > > Add the dpaa2-console device tree node for the following
> > > DPAA2 based platforms: LS1088A, LS2080A and LS2088A.
> > >
> > > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > 
> > DTS patch generally goes to the last in a series.
> 
> Should I resend this with the DTS patch the last?

You do not have to resend the series only for this.  It's pretty much a
suggestion for future posting.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
