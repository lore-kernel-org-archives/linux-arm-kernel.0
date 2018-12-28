Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF33C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:29:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D15206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RRuOIx2b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZq+/ehy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D15206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	References:Message-ID:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rDHXAMZgoe1/KIKss99uLXIweGESUH+gP8tCglW/8Jg=; b=RRuOIx2bBvDeOW
	1bIuqZsyZWUsUQ8yFKpZR3yZ0Qc3G+aDJFQebQRdEpoqvK+NWcP0agbqxozJwkvOhnqNyFMmHva82
	Jd9tKxM2hdfNGUxZFgYN0TvL0niZ+I8NofjCiFboeiZ7I9RBN6++rOs89dUBtI+OD7OHgMA26Sncl
	Cen56660wd9DQooxLBvWagOzk47SzE63/jh0uANHqD/B1UOytZapp6i3qawhKS8WdUsu3VOeEW9Kb
	f3kLKQdFR+WSTzK0PNUFZMbwYz4I+YD520YB68rF+nMLBkv6w8NpkBVo4P57nPPlnNaAFVdV69WLh
	EGOoVUP8mCkA1Yv4t2/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0cu-0007MS-28; Fri, 28 Dec 2018 22:29:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0cr-0007A2-En
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 22:29:06 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 15514206C0;
 Fri, 28 Dec 2018 22:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546036135;
 bh=1kcgDHXoWwOcoEu59RAjMuWloNe4Hvrfo/HlcHMda7Q=;
 h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
 b=QZq+/ehyWBGnP/IjA1vgv9Vam7EthRGHfk/tw7xoJBAIc8sGQP5hcMRsBt3cto4Qo
 LCAFa5PuoeDx8eXcIY/XMvTfGeE+bAKHJUeQcAyAeLCKuuqo/rD/Vgc1wMP1IOmZq8
 /8OcZbqf+DMI23wRyHE9VssoxO7kL831zchD8MHs=
MIME-Version: 1.0
To: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>
Message-ID: <154603613437.179992.1170701312259011363@swboyd.mtv.corp.google.com>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
 <20181218143503.GA32562@centauri.ideon.se>
 <72bc192f-b60a-1209-7818-78a2fed07831@linaro.org>
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <72bc192f-b60a-1209-7818-78a2fed07831@linaro.org>
Date: Fri, 28 Dec 2018 14:28:54 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_142905_535497_026E2A2D 
X-CRM114-Status: GOOD (  14.82  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, bjorn.andersson@linaro.org, david.brown@linaro.org,
 linux-clk@vger.kernel.org, jassisinghbrar@gmail.com, sibis@codeaurora.org,
 andy.gross@linaro.org, jagan@amarulasolutions.com, devicetree@vger.kernel.org,
 arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, vkoul@kernel.org, enric.balletbo@collabora.com,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jorge Ramirez (2018-12-26 01:20:07)
> On 12/18/18 15:35, Niklas Cassel wrote:
> > On Mon, Dec 17, 2018 at 03:37:43PM -0800, Stephen Boyd wrote:
> >> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
> >>> Allow accessing the parent clock names required for the driver
> >>> operation by using the device tree node.
> >>>
> >>> This permits extending the driver to other platforms without having to
> >>> modify its source code.
> >>>
> >>> For backwards compatibility leave previous values as default.
> >>
> >> Why do we need to maintain backwards compatibility? Isn't is required
> >> that the nodes have clocks properties?
> >>
> > 
> > Hello Stephen,
> > 
> > 
> > This is the existing DT nodes for msm8916:
> > 
> >                 a53pll: clock@b016000 {
> >                          compatible = "qcom,msm8916-a53pll";
> >                          reg = <0xb016000 0x40>;
> >                          #clock-cells = <0>;
> >                  };
> > 
> >                  apcs: mailbox@b011000 {
> >                          compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
> >                          reg = <0xb011000 0x1000>;
> >                          #mbox-cells = <1>;
> >                          clocks = <&a53pll>;
> >                          #clock-cells = <0>;
> >                  };
> > 
> > 
> > This is the (suggested) DT nodes for qcs404:
> > 
> >                  apcs_hfpll: clock-controller@0b016000 {
> >                          compatible = "qcom,hfpll";
> >                          reg = <0x0b016000 0x30>;
> >                          #clock-cells = <0>;
> >                          clock-output-names = "apcs_hfpll";
> >                          clocks = <&xo_board>;
> >                          clock-names = "xo";
> >                  };
> > 
> >                  apcs_glb: mailbox@b011000 {
> >                          compatible = "qcom,qcs404-apcs-apps-global", "syscon";
> >                          reg = <0x0b011000 0x1000>;
> >                          #mbox-cells = <1>;
> >                          clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
> >                          clock-names = "aux", "pll";
> >                          #clock-cells = <0>;
> >                  };
> > 
> > qcs404 specifies two clocks, with an accompanied clock-name for each clock.
> > 
> > msm8916 specifies a single clock, without an accompanied clock-name.
> > 
> > It is possible to append clock-names = "pll" for the existing clock,
> > as well as to define the aux clock in the apcs node in the msm8916 DT:
> > clocks = <&gcc GPLL0_VOTE>;
> > clock-names = "aux";
> > 
> > However, since the DT is treated as an ABI, the existing DT for msm8916 must
> > still work, so I don't think that it is possible to ignore having backwards
> > compability in the apcs clock driver.
> 
> 
> so where are we with this?
> 
> do we remove backwards compatibility (see below] for v2 or is the DT 
> really an ABI and therefore the patch under review is good as is?
> 

Breaking compatibility is up to the platform maintainers. If anything, I
would make the DTS and driver changes in parallel and then remove the
driver's backwards compatibility logic later on.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
