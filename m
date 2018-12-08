Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2CAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:54:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A222082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qBrvBS4o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qz0Pa6xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A222082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xm1+sDzvr1Img6+xl0wHHKcVjNPRdg0IovDUEGl65VI=; b=qBrvBS4oKv8Zum
	IPmAjKXgxuGKIptXxXh+OFD1fvrqOId8YRvKMQLFmmPQx/8AK1MPP6wpDZ65KIcbmYwZiTLolpIGs
	6iKFF22Rx0IlagG+D0qiZ0tMK7OjJUfOIGD1Iw0sJ8E+nuV/nplmMTIdocXVxBdHHiI01pF5imPom
	IxVUOJ2PITVnFNn/4ztF2w6IkYpWKhAqqIBufIMlLyyNbSzPBw2vT5aUJ9nJXseRLRa42nBpWGtGU
	QcUxZDO8UmAe7A+S6U5uOF2qiIx30dsB41twL1ZRh1/uMAY31Imgkbr/+bJuV0lyEc96BB4e6dV/Z
	dxveaxDmcTRbmepAUJmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVewN-0005qp-Bx; Sat, 08 Dec 2018 15:54:51 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVewK-0005qH-FF
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 15:54:50 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB8FsRbS024393;
 Sat, 8 Dec 2018 09:54:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544284467;
 bh=IK03sP+Dmfhbg9UpgUqQ66hnrHYA6YH0bs5Gw6heFu4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qz0Pa6xuMMSk9bDRbZn3QD4hc5ITtcbSSuKaLXF7RyFHx9NHFmT5ffroo5t6eZSYq
 Rs4jDvthIvuEhK1McTv6/k221ZUjkLijEoLrMXeTrYv68lkGypaCFeVI+Vd1TRR5lN
 99ntTr/sbNWUZTSYs7uKmo1WGQ7f9czAoo82cZE4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB8FsRCV112156
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 8 Dec 2018 09:54:27 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 8
 Dec 2018 09:54:27 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 8 Dec 2018 09:54:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB8FsQUv024248;
 Sat, 8 Dec 2018 09:54:27 -0600
Date: Sat, 8 Dec 2018 09:54:27 -0600
From: Nishanth Menon <nm@ti.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
Message-ID: <20181208155427.jmidz4vsw4k4qj36@akan>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207084233.13700-3-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_075448_597723_264982AD 
X-CRM114-Status: GOOD (  12.38  )
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
 linux-kernel@vger.kernel.org, kishon@ti.com, t-kristo@ti.com,
 robh+dt@kernel.org, adrian.hunter@intel.com, michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14:12-20181207, Faiz Abbas wrote:

> +
> +&sdhci0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc0_pins_default>;
> +	bus-width = <8>;
> +	non-removable;
> +	ti,driver-strength-ohm = <50>;

^^

> +};
> +
> +&sdhci1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc1_pins_default>;
> +	ti,driver-strength-ohm = <50>;

NAK.

$ git checkout next-20181207
$ git grep ti,driver-strength-ohm Documentation
$

Nada.. And.. I think "new phy binding" probably introduces this.
[1] https://patchwork.kernel.org/project/linux-mmc/list/?series=53185

If your patches are'nt really ready, please send them as RFC, I am not
really in a mood to track the status of every single driver subsystem.

If your binding is not in linux next at the baremin, as far as I am
concerned, this is not ready, and should be RFC.

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
