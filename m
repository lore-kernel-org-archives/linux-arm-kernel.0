Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BDEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:21:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1963E2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sUVvHqyE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxh6dvBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1963E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dQB0FO155wm6a+NwFr1hE+6/SIX60kvCbLDfhK/cB0A=; b=sUVvHqyEL/j8mx
	Fqo2DPTMXLCO+424nDi5CIihAbB3oXX9cyvX/Luotlak19wjIsFLOqnOKTANZi+23Puyrf2aEG7kW
	Crz+Rf7o/zuOME+jGpUS7MmopmIBemm65skGsOEDSK34Pswbh6OjPNmkAmSjXV1Rt1AZpRBAOwf7l
	/uj4e2rdjlZ8YSWc9I2+AB0/4WJRDlkZIoR7uAyoEIwmHzZ+3LA5aYO4qywdkkjSE3BXGGWp5RCAJ
	6bXJuHLUy2icHgwgcI8TTCmKN5pljbYzK0lJz4g5LCVgV8aXkZIRiRQj8XaabOTAIPeGtIy63TPCk
	pvX2dNc6JNzG+uexZrpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFKH-0001Jg-8C; Tue, 04 Dec 2018 18:21:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFK0-00013z-TE
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:21:26 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4309A2081B;
 Tue,  4 Dec 2018 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543947674;
 bh=ji3ydNM9SAxkRfwU4F7pz7IU3OSBPHbSsD5+rB3CtjE=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=Mxh6dvBeoILkGY7JQWm9eHVEtdIGzc31l5mDVHjU33+gY0nmzB8039rMp/3c8DFIP
 IenYO7tNM5siEPvUG5ja6mDDge9vLVLoulcaGATqqDTEgpISHfrIxt48SMXeO+Dj05
 8O/w11s2m6SBxBKixpmDT43w9VJjjt5Bs8rTxpiI=
MIME-Version: 1.0
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204071315.GA31204@localhost.localdomain>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
 <154388011043.88331.6461709079501929390@swboyd.mtv.corp.google.com>
 <20181204071315.GA31204@localhost.localdomain>
Message-ID: <154394767367.88331.17679291261207728780@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Date: Tue, 04 Dec 2018 10:21:13 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_102124_974952_AFC3DAD5 
X-CRM114-Status: GOOD (  19.35  )
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
Cc: linux-doc@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Daniel Kurtz <djkurtz@chromium.org>, Sebastian Reichel <sre@kernel.org>,
 David Brown <david.brown@linaro.org>, linux-clk@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Andy Gross <andy.gross@linaro.org>,
 Huang Shijie <sjhuang@iluvatar.ai>, Guenter Roeck <linux@roeck-us.net>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Akshu Agrawal <akshu.agrawal@amd.com>, mazziesaccount@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matti Vaittinen (2018-12-03 23:13:15)
> On Mon, Dec 03, 2018 at 03:35:10PM -0800, Stephen Boyd wrote:
> 
> > If the DT doesn't have the #clock-cells property in the node being
> > registered then calling clk_get() will fail for any consumer devices
> > that point to the node with a phandle and clock specifier. I don't
> > expect us to get very far into development if that's the case.
> 
> Makes sense. So only potential thing to break is if someone out there
> has broken DT/driver - where they currently see this failure. Eg. they
> use node w/o #clock-cells as provider and where they try and fail
> controlling this clock - but ignore the error (and system just "works"
> with HW defaults). After this change they may actually succeed in
> controlling - but do control wrong clock.
> 
> Not likely scenario (sure happens somewhere) - and it involves already
> broken design. So I agree with you. Besides, you are the maintainer for
> clk framework and thus get the most of the rain if **** hits the fan =D

Yes, exactly.

> 
> > Of course, we don't fail in of_clk_add_provider() if there isn't a
> > #clock-cells property in the node, we just happily add the node to the
> > provider list and carry on. I doubt anyone is failing to specify the DT
> > property, but maybe they are, in which case we could keep not failing
> > and just add the node of whatever we're called with originally if
> > neither the parent or the passed node have the #clock-cells property. I
> > wouldn't try to go any higher than one node above the current node and
> > look for a #clock-cells though.
> 
> I think we should use parent device's node, not the paren node in DT,
> right? But I agree, we should only look "one level up in the chain".

Are these two things different? I'm suggesting looking at
device_node::parent and trying to find a #clock-cells property.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
