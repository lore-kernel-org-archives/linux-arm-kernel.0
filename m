Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157BBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:03:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33942133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fCBLRpS0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HklAPDMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33942133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ulCdLxNVVSx+tHSyisyo/E051yzXEjH2AYlP+c5CO50=; b=fCBLRpS0Gt59HF
	gyVdVqNAgAGYsz4E9AMCa9TwaLy+RCNm0MaE2bqsNvISFnySk1ZrzZtLNp9ufmBQBfrXEOry/Zzdq
	7mIHJ388DhONXBQSL9yNArbMADnz0sSFsJxgiQIv4XD8SIjX4dMgLOhdYa1BtvaYQoNvXuACGSg6M
	nqnI+Mf+2iON51qZsT6JJhspQeLEYJU+BM/kbuqYtEPDzEGpsI09QHSJYYt/AiB5PZ1PV3A6wVUct
	p2vCpy5bb3V0TFz69Ey0WeLGPV1IYk3It5eDiEDrOeTUNI+woTjvdPzR0y5k40Axdf7N76irln5HP
	fz3d43Kmp95rjR+hnJ9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghwTL-0002Bw-4d; Fri, 11 Jan 2019 13:03:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghwTG-0002BC-Sk
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 13:03:36 +0000
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9EFB120836;
 Fri, 11 Jan 2019 13:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547211813;
 bh=+MFDpUnvmUE4o5fYOPQ9631AU8/c1rueM8t0nW5tBik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HklAPDMm1+D3aC1fRBuRXILLZjJ+tZKbbfFA3oRmWDySVfwa871rlVe2bkFT6s8sb
 PAvvFNxtRpSnlTU5GciEgI0ycF6BCdJhfLhT2ozviReoioHjWEOxpC7BWrWcAk9wX8
 a4KefboUxymEAPOKcy3P4T6qdTYDGL0Gh5kxnb+s=
Date: Fri, 11 Jan 2019 21:03:14 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible
 string for power domain
Message-ID: <20190111130311.GA3599@dragon>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
 <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
 <20190111090009.GG32649@dragon> <20190111090653.GH32649@dragon>
 <AM0PR04MB42119B411244F0B1BB829D9F80850@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM0PR04MB42119B411244F0B1BB829D9F80850@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_050334_963618_809F5096 
X-CRM114-Status: GOOD (  17.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 10:48:21AM +0000, Aisheng Dong wrote:
> Hi Shawn,
> 
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo@kernel.org]
> > Sent: Friday, January 11, 2019 5:07 PM
> > 
> > On Fri, Jan 11, 2019 at 05:00:11PM +0800, Shawn Guo wrote:
> > > On Tue, Dec 18, 2018 at 04:01:20PM +0000, Aisheng Dong wrote:
> > > > SCU power domain can be used in the same way by IMX8QXP and
> > IMX8QM SoCs.
> > > > Let's add a "fsl,scu-pd" fallback compatible string to allow other
> > > > SoCs to reuse the common part.
> > >
> > > This is not the practice we used to match devices with
> > > compatibilities, i.e. coding the compatible string with the SoC name
> > > that firstly introduces the device, and use the compatible as fallback for new
> > SoCs.
> > 
> 
> This is suggested by Rob that if the future SoCs are likely to be compatible.
> Then we can use a general fallback compatible string like "fsl,scu-pd".
> https://patchwork.kernel.org/patch/10644815/
> 
> From SCU HW protocol point of view, they're indeed compatible.
> Just varies a bit on the domains numbers. 
> That's why we introduce "fsl,scu-pd".
> But still keep SoC specific compatible string in case any special tricks
> to ensure the ABI stability.
> 
> How do you think?

Unless Rob is against the practice we have been used for long time on
i.MX, I would keep using it for i.MX8, i.e. instead of introducing a
generic compatible for fallback, simply falling on the compatible SoC
specified IP block.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
