Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FBDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:35:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C3F2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eStqMol7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C3F2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CPf8jEAUwfDV6s7pwek/b5jYy6JzNrOEArAnRFHbAcg=; b=eStqMol7ewrJ3P
	3iW5k/Hw2mIoAs63eeL1qQqYlTf+zgb3FcA6+n0fCellQvh+zfj+GbGB5txoYLqpDdm5J/Obdlkut
	MoEHoTY7Kp0pB3Q8iYBqpS4bK/FiQMORwWU9FHOm+SEks1rjGI+Xn3AwnxaPjj+jpWKz99FT84hTk
	MMJEvHwJzxmiK0+hSsf1AIeOc9Aj8Fxo2pkPNl3PpCiqHNmaIX1ivzIb6CrGNSUX0wF+f0as66xbj
	a8lTo00hhAQMlLDDS04pOWTV6zlcFD+VBEq1z9yTp1A8kuo7ICOP/3MlvSDNnoCSnXtNXTKbPrEzG
	sd/a1mU1VyjTspq9SfHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjNwi-0008RX-Bk; Tue, 15 Jan 2019 12:35:56 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNwe-0008Qo-LN
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 12:35:54 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id A092AFB03;
 Tue, 15 Jan 2019 13:35:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KdgBn52VqAcX; Tue, 15 Jan 2019 13:35:49 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 7008247345; Tue, 15 Jan 2019 13:35:48 +0100 (CET)
Date: Tue, 15 Jan 2019 13:35:48 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add system reset controller
Message-ID: <20190115123548.GA16131@bogon.m.sigxcpu.org>
References: <20190115114641.GA15870@bogon.m.sigxcpu.org>
 <1547553117.4339.8.camel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547553117.4339.8.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_043552_874619_2F220337 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,
On Tue, Jan 15, 2019 at 12:51:57PM +0100, Lucas Stach wrote:
> Am Dienstag, den 15.01.2019, 12:46 +0100 schrieb Guido G=FCnther:
> > We can reuse the src from fsl,imx51-src as with other imx SOCs.
> =

> That's not true. The SRC is significantly different from the i.MX51
> one. See series "[PATCH v4 0/3] Reset controller support for i.MX8MQ".
> =

> We generally don't add the DT nodes until at least the binding, better
> yet the full driver, is upstream.

I guess I got carried away by the parts I needed working and mostly
requiring the syscon part. So let's hold that off, thanks for the quick
reply.

Cheers,
 -- Guido

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
