Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED1C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:16:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EF0222B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rTP/Kzo6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iqNyJ8LB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ERt/4jnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EF0222B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kx7OG6DkCeo2VGrSj/dVrMkkfdz6fJkZTrS38s6oVGw=; b=rTP/Kzo6zMWbu5
	r+AWhzPuv/RCCBTxzGTI8UilqNHfJK6YvS1QCHYl9QJKKQ6BidHm3BIJrM300lY4157mM0K+a1ZZD
	UO3CdNR2nPEhR+xnNnEygKcTJdS5Bpa53q4nj+oTnwDOeZbCbJaWjOJ7sjC5qxPaZ7MsAdiFu/cwH
	K2sqV2cIpdJNLE+kimjnGiWO474kw1c85Mu6B9vgWQkCId59X9wkt6NQ8OaYd2FzL4lc4/MkncTjw
	BfOw+J5Ew0sztcWY8LA1gE6D8BPzCCK5wYhmSBNrqfiGJ+7ScFsKaUKvo2e6/C+0WT7Nsy8h9IRIp
	VNZ2l5dhwpje6vG6RvVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtz4k-0001F0-0Z; Wed, 13 Feb 2019 18:16:02 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtz4i-0001Es-Nd
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 18:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EcJk791Pq66UPF57+dabzkxCJr2L7yCBI4Jmdyzryts=; b=iqNyJ8LBjZr+2vKn8ycL4AkBu
 zYlVmfccF7H9YOD+IaG7jWzg1eWDtcHAXq90CfyLabnjPUUAxgG0LL67Npi+DOH/iIVbRAo1ip+mp
 1ol7xgZoRcmEDqaQ48WN1py+B92C1cZhAkLlz6c0BL7q7UWH5zX5rGy5B1CHBdwN7arU3mLiGZHt1
 wIGEAdOTsTMHTF4DuXr/y9eedhJIvDx7p6Ykuhnjfb0kx8ePW+3JOl7W3yPZnc6ZyZB7z2PgTcofo
 k+bCmQ/gsqaQ4L+Lt0r81CeNUt/bgPPcSUH2UDDBEgQuN974af9PdA9tSqNah7x/CePON/IZBmzLV
 /WTieq/yQ==;
Received: from vps0.lunn.ch ([185.16.172.187])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtz4g-0004Jc-E2
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EcJk791Pq66UPF57+dabzkxCJr2L7yCBI4Jmdyzryts=; b=ERt/4jnwdZwUeb8tqNXoDYXy9F
 XEMa/sxn8mkSNPi0ArGYF4vHPzewy4M+K47B5vyf59+6Cz0szcyVicUaZQfVEPRTV6ZoyR+SlEcRw
 wWcX3NiwNW1XdOmGAbsKPR5tPVbpZp/p6Hk1y/bYSWUEXJ6wfRkuyVSiwHqCWGEQ7mgk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gtz4c-0000mH-OA; Wed, 13 Feb 2019 19:15:54 +0100
Date: Wed, 13 Feb 2019 19:15:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Subject: Re: [PATCH net-next 2/3] arm64: dts: fsl: ls1028a-rdb: Add ENETC
 external eth ports for the LS1028A RDB board
Message-ID: <20190213181554.GB708@lunn.ch>
References: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
 <1550055743-15542-3-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550055743-15542-3-git-send-email-claudiu.manoil@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_131558_610186_6D9733D9 
X-CRM114-Status: GOOD (  15.31  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 alexandru.marginean@nxp.com, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 01:02:22PM +0200, Claudiu Manoil wrote:
> The LS1028A RDB board features an Atheros PHY connected over
> SGMII to the ENETC PF0 (or Port0).  ENETC Port1 (PF1) has no
> external connection on this board, so it can be disabled for now.
> 
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index fdeb417..c8487893 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -71,3 +71,18 @@
>  &duart1 {
>  	status = "okay";
>  };
> +
> +&enetc_port0 {
> +	phy-handle = <&sgmii_phy0>;
> +	phy-connection-type = "sgmii";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	sgmii_phy0: ethernet-phy@2 {
> +		reg = <0x2>;
> +	};
> +};
> +

Hi Claudiu

It is better to use:

&enetc_port0 {
	phy-handle = <&sgmii_phy0>;
	phy-connection-type = "sgmii";
	#address-cells = <1>;
	#size-cells = <0>;

	mdio {
		sgmii_phy0: ethernet-phy@2 {
			reg = <0x2>;
		};
	};
};

	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
