Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:34:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C2920868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O88eJiVO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wcsMxz1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C2920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q9xArkHRILDRo8kLGzdw7BKrFnjFK8lWytlKnQKqHeA=; b=O88eJiVO2GVDqT
	ghaojpZk8JH1IYvU6u7PzfsjPfIB9ghcZsQzqNLGHJVQ4296cz/oLXs1PpxRvnK4RkPSoYyIBWpv0
	xUz3tvPU5clahCfLjiFK5eYjzAKJYYJ7Pq5bLTe/+IkPQk/ovJovFFjMVE7zAX0/q7r02hmVqjM37
	uKqpYaJaIafi2WJA9wQNKC+Ac3A3ykoW5Sulr+kF1YXr9811gAsGjrDQfV+7KCw6Str/9BV64hLZG
	GEZ0Sru75Qi7QBnPw/A9L9SeRrjdIZ89pL0buh2NJlt+zeXyxPlBuLIHQFB7p829/h7MVUVgqxpHS
	Pi50e77ND5LVLMBSEqgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPnU-0001PA-Ff; Tue, 15 Jan 2019 14:34:32 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPnQ-0001On-FL
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:34:29 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FEYSDZ086174;
 Tue, 15 Jan 2019 08:34:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547562868;
 bh=IM0bAxIqmKRNdlzbIQJ8o4e884NUCCww8PVfDByTQ9U=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wcsMxz1ft252TxeaKeu2mU0kpp56lr7dawB8/isj+IDfzK1VQDKRZpslYpoA+stY5
 Gv4iEj8mx0Fm8adMUUqKywHhCVVu9kik9+gOwJ1caiCRZzfpmdW7C3ucQrbMwuVEJw
 hUkqloZ2aSaUwduM4pYOaJo+G8Zfbkyz7pf/uaw0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FEYRiJ030284
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Jan 2019 08:34:27 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:34:27 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:34:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FEYRd2001282;
 Tue, 15 Jan 2019 08:34:27 -0600
Date: Tue, 15 Jan 2019 08:33:55 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: am654: Add Main System Control
 Module node
Message-ID: <20190115143355.immsdfkyulx5j6o7@kahuna>
References: <1547200861-17795-1-git-send-email-rogerq@ti.com>
 <1547200861-17795-2-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547200861-17795-2-git-send-email-rogerq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_063428_552112_1D6C4EE4 
X-CRM114-Status: GOOD (  17.61  )
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
Cc: devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, t-kristo@ti.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12:00-20190111, Roger Quadros wrote:
> From: Jyri Sarha <jsarha@ti.com>
> 
> Main System control module support is added to the device tree to allow
> driver to access to their control module registers.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 272cf8f..8b55108 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -191,4 +191,12 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  	};
> +
> +	scm_conf: scm_conf@100000 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0 0x00100000 0 0x1c000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x00100000 0x1c000>;

Who handles the MMR region unlock?

> +	};
>  };
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
