Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0775C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:30:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F592063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EZ4MDFsM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hnjvYWC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F592063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W/RAApu0GXLRdENFRzeKZdS6LJhaHmYpft1lDdN09wE=; b=EZ4MDFsMS80OAE
	zfIomLRW+khD34+/AA+nquYjh09vq5GQol0aSqMpzT2X1wwAhOVcDY/RJg4m/Dh8h7X3epnFKojUQ
	/CGKxqVfuf3CDAOd/v3VpQ3mfjizH63kH4nWkmE4xW+6zOtpLa0PagGFXdBPyvJuNK0bxVkoowWIA
	2ecLv043kzI7iHtmkVQqQ9lBFb65rkQ6usGFgkUKQ2WeDash/Fuslq6wpEJr0cQ9Whp7javgrUCxz
	4FLvIFTpSVb3DBbmC0K8+5LDj21vgpVqlGtQ9ESipxeJU+OsdwuO/c9NjcsaQvmjwzf32XNz0TjLf
	xtFYEtEQhf5puLlCKH8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPjY-0000fE-4R; Tue, 15 Jan 2019 14:30:28 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPjU-0000el-GG
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:30:25 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FEULhW107461;
 Tue, 15 Jan 2019 08:30:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547562621;
 bh=u+0A9ra6HbEV0+gtRGluL/UpmwxpXHi6otB4YmdSGGc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=hnjvYWC4fvAGSuWvX21msCTRFH9MrWGQ0az/sxZCaZej7dyMiwsbZaOlPljSN3flj
 frEEN7QIRYHdufMRajQ+5aFmggMrVXjOWgEPCNidVSUaC6OukcxI8X2Z7TdUUhfbKK
 Qf4AoH7FU6ExO66yC7LhMoOWb2Ae0BZkz6vdmmnY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FEULer113773
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Jan 2019 08:30:21 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:30:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:30:20 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FEUKGI029469;
 Tue, 15 Jan 2019 08:30:20 -0600
Date: Tue, 15 Jan 2019 08:29:48 -0600
From: Nishanth Menon <nm@ti.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 0/2] Support for eMMC in AM65x-evm
Message-ID: <20190115142948.3fq2i6vav7jn4ulq@kahuna>
References: <20190110073355.3382-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110073355.3382-1-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_063024_589642_CDD74471 
X-CRM114-Status: GOOD (  15.58  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13:03-20190110, Faiz Abbas wrote:
> The following patches add eMMC support on TI's AM65x-evm.
> 
> v2:
>  1. The SD card node is under debug for some usecases.
>     Only upstreaming eMMC support for now.
>  2. Rebased to latest mainline.
>  3. Removed status = "disabled" from dtsi patch
>  4. Fixed node name to not include '_'s
> 
> Faiz Abbas (2):
>   arm64: dts: ti: k3-am654: Add Support for MMC/SD
>   arm64: dts: ti: k3-am654-base-board: Add MMC/SD support

Once the $subject changes in the above two patches (should be emmc
instead of MMC/SD):

Acked-by: Nishanth Menon <nm@ti.com>

> 
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 13 ++++++++++
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> -- 
> 2.19.2
> 

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
