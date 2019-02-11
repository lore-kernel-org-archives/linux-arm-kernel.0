Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18682C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:49:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAEB206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cgomyxUo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kgpo5xLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAEB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iHH1zy581FHDPxuOJJN2RpyA2G81hrqMsKtUWIx6zaM=; b=cgomyxUohS4zkp
	gkuVZIM8NOEeDVMaD4SJ+0DBdEnWSsED7/ZvlOaUVUuqzF+Nvk+Fl4mG704lmDOjlYrHXVEIsFce4
	ziqyOwSSi/cOyN/iU1LznwQ3QGJFGuvEbH4DRV0fIqKrkllvn+Jpki+hj6/Qp2MKkF2MaPGrJHe9U
	89WOD/4Jhu05tKlh8b6HkI0V3ivRQOD/PTqdkiPxnaJzuUiIVhOU5t97yOUEC9nggFLIY/Z0B02ui
	VXA/B4QclaBEvaROLpW4eTaG3g1qY9EVsCt3/1igPvOx+MMPN+cdAM8r3+J9/lLNc2+UrUYRvJwrE
	8WCTNSYDlwk59nj+B7rQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8De-0003Vi-Kg; Mon, 11 Feb 2019 09:49:42 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8Da-0003VI-5y
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:49:40 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id E3E5D25BE79;
 Mon, 11 Feb 2019 20:49:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549878573; bh=FdvD1a3plAOg0Gnv3jDZMJGnODnBVLLPb0XxfxGVMjA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kgpo5xLaOh4av7g+hFyTQLpGMUGZpgPjt0v3Aexp7juAwCBzm90sTyDLqd2jO0PcC
 gPzsjdB0tOWr+cFodTo/oSZwDUKgG5AroR2OZ0Ritpn2tLHxPFEtW4yIereeUBL55Z
 sOC9um50QvIoveiHzUURSSpNKDTbG7J5VDnD1ytM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 05341940362; Mon, 11 Feb 2019 10:49:30 +0100 (CET)
Date: Mon, 11 Feb 2019 10:49:30 +0100
From: Simon Horman <horms@verge.net.au>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [PATCH 08/12] arm64: dts: renesas: r8a774c0: Add OPPs table for
 cpu devices
Message-ID: <20190211094927.5bs32a6q7ecvqq5t@verge.net.au>
References: <cover.1549623801.git.horms+renesas@verge.net.au>
 <231d8908a66fa98f09553d31ad8cd5f382b29959.1549623801.git.horms+renesas@verge.net.au>
 <7d60ebf5-c245-f48d-47db-ce63f4f3690b@cogentembedded.com>
 <TY1PR01MB1770FAE6E7C26615134B8E0AC0690@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1770FAE6E7C26615134B8E0AC0690@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_014938_858346_507D9D37 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 08, 2019 at 03:26:49PM +0000, Fabrizio Castro wrote:
> Hello Sergei,
> 
> Thank you for your feedback!
> 
> > -----Original Message-----
> > From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Sent: 08 February 2019 12:53
> > To: Simon Horman <horms+renesas@verge.net.au>; linux-renesas-soc@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org; Magnus Damm <magnus.damm@gmail.com>; Fabrizio Castro
> > <fabrizio.castro@bp.renesas.com>
> > Subject: Re: [PATCH 08/12] arm64: dts: renesas: r8a774c0: Add OPPs table for cpu devices
> >
> > Hello!
> >
> > On 02/08/2019 02:13 PM, Simon Horman wrote:
> >
> > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >
> > > This patch defines OOP tables for all CPUs, similarly to
> > > what done by Takeshi Kihara and Yoshihiro Kaneko for the
> > > R8A77990.
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > [...]
> > > @@ -55,6 +76,8 @@
> > >  power-domains = <&sysc R8A774C0_PD_CA53_CPU0>;
> > >  next-level-cache = <&L2_CA53>;
> > >  enable-method = "psci";
> > > +clocks =<&cpg CPG_CORE R8A774C0_CLK_Z2>;
> >
> >    Need space after =...
> 
> Doh! Simon, do you want me to send another version to fix both spacing issues?

Likewise, sorry I didn't notice that earlier.

I'd rather not re-send this pull request just to resolve whitespace issues.
So please send an incremental patch for now.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
