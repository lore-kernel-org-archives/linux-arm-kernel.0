Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17868C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:23:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A8F205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="asfIKuXI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="XpVzRe3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A8F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jE+h8FhMjKkw7fUGpHATqGllQZTCNPdLX/HdUGDurRY=; b=asfIKuXIOPy3k5
	UvoA37ilYlQi2xwqx5qLHyfWDtlCLTwYkW+xx1hCF1s0Y3euLUk2fFC0akZFD80wx9K1PFj5/aPp2
	YhTyAZHurIUT/dvGbe9wiYzC2/JwxKeacgAxa0rLYE+Gyb/POyPbHnSOzJJK7HsnYF2Zxo3u4/QYw
	w3/bnZdK7Ruklp8KuXn0/i8/5yh0ff0/1yrBjQ51BJFDXHVREqKqjDsEPoWL0Do8PHqQdJTaIlTIJ
	NeLsxn0FdmW9JI/TcDErsAZEDIqSH4/BMieCmWZB3mNFMWApZyqi+Eq34Yf0gW2oa8z1djwaQdzh5
	dZg4EtQ7zr7DXggOLdaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk9Vr-0007tL-VV; Thu, 17 Jan 2019 15:23:23 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk9Vk-0007py-20
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 15:23:17 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 86DD225B760;
 Fri, 18 Jan 2019 02:23:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547738594; bh=auQ2NRBR4hn04VH61X7DcbjJAq/IliX1dcZSqqQeUnM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XpVzRe3Nxh5az1fTwLu8GW7EuNs+D83FoMq2+CX2aS3KsroNSF6c+SyWCLBxnuZrg
 /HhkM73oiV1T+Uv16e2m4eAbwGM8jQAMyMOXgA7k0PjVTKkfCbhY8FSNhHDDjYjjJP
 K3zSxgKNPTXc2QVF4qibjn36ELGVNaz/OY4jpcEE=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 80746940459; Thu, 17 Jan 2019 16:23:12 +0100 (CET)
Date: Thu, 17 Jan 2019 16:23:12 +0100
From: Simon Horman <horms@verge.net.au>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH repost] arm64: dts: renesas: r8a77990: ebisu: Enable
 HS400 of SDHI3
Message-ID: <20190117152312.slckgb3w3n4ysgfj@verge.net.au>
References: <20190117143829.6ubwnj5cyh74mjq3@verge.net.au>
 <20190117150126.gku7sr3dcujfx2rq@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117150126.gku7sr3dcujfx2rq@ninjato>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_072316_240653_C594D0A3 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 04:01:26PM +0100, Wolfram Sang wrote:
> On Thu, Jan 17, 2019 at 03:38:29PM +0100, Simon Horman wrote:
> > Add SDHI3 UHS pin control and use it when enabling HS200 support
> > for SDHI3.
> 
> HS400
> 
> > # dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> > 512+0 records in
> > 512+0 records out
> > 536870912 bytes (537 MB) copied, 9.02486 s, 59.5 MB/s
> > # dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> > 512+0 records in
> > 512+0 records out
> > 536870912 bytes (537 MB) copied, 7.36003 s, 72.9 MB/s
> > # dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> > 512+0 records in
> > 512+0 records out
> > 536870912 bytes (537 MB) copied, 11.0156 s, 48.7 MB/s
> 
> Hmmmm, quite some fluctuation and far away from the performances of M3N.

Perhaps the M3N measurements were taken without iflag=direct ?

In that case for E3 I see:

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 3.79686 s, 141 MB/s
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 3.77128 s, 142 MB/s
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 3.79916 s, 141 MB/s

> Marek, do you have an idea why? Did you note any E3 differences when
> coding support for U-Boot?
> 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > index 89383aa35d65..f2846c9eb83f 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > @@ -535,6 +535,12 @@
> >  		power-source = <1800>;
> >  	};
> >  
> > +	sdhi3_pins_uhs: sd3_uhs {
> > +		groups = "sdhi3_data8", "sdhi3_ctrl", "sdhi3_ds";
> > +		function = "sdhi3";
> > +		power-source = <1800>;
> > +	};
> > +
> 
> This is exactly the same as sdhi3_pins, so no need.

Yes, silly me.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
