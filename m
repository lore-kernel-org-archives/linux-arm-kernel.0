Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78624C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:45:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BC920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TYJq+WEZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XpmGjPbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BC920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ejMn/aGbTo+sGmkkdX97cxaSS0ID2A0IiSZfTPti+XE=; b=TYJq+WEZ6EKOa+
	1LSuOWb3OPFbmeoPZxFu1nMB7lh46cGKbv4Qajr/b6hT/uOlmJlgtqNtJEGnkGbMMUTtvX/SMi5m4
	5dRK6M09mihGRfABStIO86aA9C7SHS0aYo/U9EBi6iNLfYFn+s9Rqx/YTrY9YncD7LJi5qWQzpX5R
	oSj3Ex3EjaWDsaaRb+V61n7tnbbr6wX2bBu6CN6Wqzx3T3vrlX15p3xiMrME+IhLV1HpxC3/Lz77c
	XQK6TuyLfSTREoDPsJYv5OIfT7bfwNxc8CtKLQMhO0VKi4sXIiCQ/ZIXtyBFy00upSEB9Dk94CXQ5
	V0sNO4LQVj4cVw/6MbpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVene-00043o-3R; Sat, 08 Dec 2018 15:45:50 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVena-000436-G4
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 15:45:48 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB8FjRJY086823;
 Sat, 8 Dec 2018 09:45:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544283927;
 bh=sNubEZmLX9GLtz40Y78ZtKImyP0i/MBR2DeoShL3eQI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=XpmGjPbnldQtVCaHJnt8JiSoEo6YW/Rnf8WFNwO3kDdyOpICEJehHZapj1UUOs6j8
 mYzqj+VB4FT4WFV9I3kkQtXPgg10dYgOx9S0cV/BMpwe/OxCrEa6fjiXxxw5JllLt5
 6/V+ZvF0Uj2EwDrNJ3b5gwAOv7DkahtfHLa4lgh0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB8FjRi8001191
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 8 Dec 2018 09:45:27 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 8
 Dec 2018 09:45:27 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 8 Dec 2018 09:45:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB8FjQRZ011911;
 Sat, 8 Dec 2018 09:45:26 -0600
Date: Sat, 8 Dec 2018 09:45:26 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am654: Add Support for MMC/SD
Message-ID: <20181208154526.ivbvwvcx6otg7lvh@akan>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-2-faiz_abbas@ti.com>
 <a6aacd53-e1c4-fce0-7712-f276c80bbffc@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6aacd53-e1c4-fce0-7712-f276c80bbffc@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_074546_658562_6A9EA653 
X-CRM114-Status: GOOD (  17.17  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, adrian.hunter@intel.com,
 t-kristo@ti.com, Faiz Abbas <faiz_abbas@ti.com>, kishon@ti.com,
 michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10:56-20181208, Vignesh R wrote:
> 
> 
> On 07/12/18 2:12 PM, Faiz Abbas wrote:
> > There are two MMC host controller instances present on the TI's
> > Am654 SOCs. Add device tree nodes for the same.
> > 
> > Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 28 ++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > index 916434839603..d07212f16a81 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > @@ -129,4 +129,32 @@
> >  		clocks = <&k3_clks 113 1>;
> >  		power-domains = <&k3_pds 113>;
> >  	};
> > +
> > +	sdhci0: sdhci@4f80000 {
> > +		compatible = "ti,am654-sdhci-5.1";
> > +		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
> > +		power-domains = <&k3_pds 47>;
> > +		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
> > +		clock-names = "clk_ahb", "clk_xin";
> > +		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> > +		sdhci-caps-mask = <0x80000007 0x0>;
> > +		mmc-ddr-1_8v;
> > +		ti,otap-del-sel = <0x2>;
> > +		ti,trm-icp = <0x8>;
> > +		status = "disabled";
> > +	};
> 
> Please drop "status=disabled" from dtsi. Can be disabled as required in
> the board dts.


yes - the standard in k3 is to disable the nodes that are'nt needed in
board.dtsi.

This is different from "disabled by default" approach in DRA7 or OMAP4
for example.

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
