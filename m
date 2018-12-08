Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07FAC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:15:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB182082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KUYriBxO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlGbXZti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB182082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0CEEvchwgWQhJTtY55Q14A5owQgUkzUvGYlyGGbIQJA=; b=KUYriBxOxwUHFG
	7ZgAZu7+Zqi5tkyt6u/HJdXfuT/iJmSS2VOWzWobd8e7RmKtemrC8GagPTuIZbdqddZRZ7Fz13mjp
	XNIiw2Xm+7OFLhHHLEtc5DpX+Tv9B6h28yiAlPrCOOjQP5pRyL+NNcZDeD+FGjaHUv1YiuzbZPEaD
	XrPbh0DB61aai44HIfsr+JdW0/KTk7b0wzdycF1K4ma2Kc2QNXrM75ke8cksSa3IM6kCMPTL04iUu
	OPM2v1Cos691l5mFUE6XKzgNi4sFQjC2N2P6zQx1eLp8RKZR9pbVN1tCYNh6EJB5PisIxy7F60mBF
	mMmueRalOCoCTPUzL7Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVS94-000440-MJ; Sat, 08 Dec 2018 02:15:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVS90-0003fH-Lo
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 02:15:04 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 62B8A2082D;
 Sat,  8 Dec 2018 02:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544235292;
 bh=hZUVUcnZx9Cp0Eb1BzCv0+BgACGXDw+7CONC2A/Ako4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FlGbXZti57Ch61tTH17efGnMdDjp0iBamKibIVsYolnMqwSG/v76JOVCgLPlKlx71
 vW+yYxZEa2gRDU2Be4PwGsPNVtIdKHWhsoHK4+KNwoF3APpa8QsNCqlMbqb1Gy81Am
 YyKSw7OcH8YwtbueDwM5mwU0WueePsN+ZRG/9T28=
Date: Sat, 8 Dec 2018 10:14:08 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: Add compatible string for LS1028A-QDS
Message-ID: <20181208021407.GN3987@dragon>
References: <1542156591-3224-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20181128024149.GC20643@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128024149.GC20643@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_181502_835756_47E90538 
X-CRM114-Status: GOOD (  11.21  )
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
 Sudhanshu Gupta <sudhanshu.gupta@nxp.com>,
 Harninder Rai <harninder.rai@nxp.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>,
 Leo Li <leoyang.li@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 10:41:50AM +0800, Shawn Guo wrote:
> On Wed, Nov 14, 2018 at 05:30:50AM +0000, Bhaskar Upadhaya wrote:
> > Signed-off-by: Sudhanshu Gupta <sudhanshu.gupta@nxp.com>
> > Signed-off-by: Rai Harninder <harninder.rai@nxp.com>
> > Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> > Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  changes in v3:
> >   no change
> > 
> >  Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> Applied both, thanks.

I dropped this patch from my 4.21 queue for now, as Rob is moving the
bindings to json-schema during this development cycle.  I will add the
compatible back using json-schema format after 4.21-rc1 is available.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
