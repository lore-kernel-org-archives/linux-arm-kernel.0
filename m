Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6E5C282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:41:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B08D20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ow2x5EQ2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjmSMrfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B08D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8rb7h2zMCQO52H0NsjIv2c+0Gh3gvKhcy2v9Q0/czYo=; b=ow2x5EQ2FZd1wT
	/iwMgJLZ0BEzyiGpsu7pescD1c2x/ptbPZz6u0bNoWdMuP7grR0i8IfLewPg46kauHifYw2zzUAdR
	pdvy/xTX0XlBc9l4i5tP/nyaqDEDYkRppzhWcVrymbSU81CnxQ72774tm6Zn4w+TiQK0EvuFGbSK0
	jEtCgkxgbulnxt51j2Ag7M49ztm0rhAggjQoHJRwH2dmhoIvUjAZYj0N4QQoKErrGRoVnXqLETdMV
	Ud+QYKjZCiIn2VD9Qhm8ygZnXUigVYRRtdAFJMBuahVyjfUoXC8Ea3r5K3ghF1MFg7PSOEbBYwF61
	t6+RGhbPc4WnbvR7wLWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glX1V-000689-UW; Mon, 21 Jan 2019 10:41:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glX1S-00067k-Te
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:41:44 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6524F20663;
 Mon, 21 Jan 2019 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548067302;
 bh=6iwYf6hcNTv39sTRXQs64i6Rh6fBxySBg+z9AcnULdE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sjmSMrfzlw+qFiqlrU64iahDZX3o3hyjg8L5Sic0IauWg7OwvCZjoS9PkIvDi2BSY
 iXwecyesSjWIyNyNRbW3+Vs/F6o5h+oqiWioNe56ZZ6iUgSRpNu9RkqjZB3RKp+2N/
 0u1K8sATnNzFBgctGcvKBSCblYlaK06dZOMLNTgs=
Date: Mon, 21 Jan 2019 11:41:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI
 area
Message-ID: <20190121104139.GA16002@kroah.com>
References: <20181221164503.5128-1-xypron.glpk@gmx.de>
 <874lagpycx.fsf@FE-laptop>
 <2c42946c-8bc1-d4cf-b6af-da54aba61c94@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c42946c-8bc1-d4cf-b6af-da54aba61c94@gmx.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_024142_976905_338616AA 
X-CRM114-Status: GOOD (  16.19  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Gregory CLEMENT <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 20, 2019 at 03:14:05PM +0100, Heinrich Schuchardt wrote:
> On 1/10/19 12:04 PM, Gregory CLEMENT wrote:
> > Hi Heinrich,
> >  =

> >  On ven., d=E9c. 21 2018, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
> > =

> >> The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware=
. Any
> >> attempt to access it from Linux leads to an immediate crash.
> >>
> >> So let's make the same memory reservation as the vendor kernel.
> >>
> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > =

> > =

> > Applied on mvebu/fixes
> > =

> > I added a comment about the use with a mainline /U-Boot
> > =

> > Thanks,
> > =

> > Gregory
> > =

> > =

> =

> =

> Hello Greg,
> =

> please, consider
> =

> arm64: dts: marvell: armada-ap806: reserve PSCI area
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?h=3Dv5.0-rc2&id=3D132ac39cffbcfed80ada38ef0fc6d34d95da7be6
> =

> for backporting to v4.19.
> =

> This patch is needed to run Linux on the MACCHIATObin and other boards.

Now queued up, thanks.

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
