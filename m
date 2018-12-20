Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EC1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:35:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA7A2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k8BWEXzJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="CvYi/G36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA7A2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CNA/qHStAhYTq1gF1t0YaoTzBHYLvSR5v+bnTa1Zdu4=; b=k8BWEXzJi73PQx
	NZA75gw50HISLSqauQ/qfBfAAZ0CfVDApLg4AqF6sjJBCX9GBd4haBd4NCfx2eHtg1urYkzCG8Dqm
	xA8HZTHdkaEdtA0t84HApBOhL6QjXZ0gx69bMoqtWcoTszZ2sxsueijq+HSENgHkOWLVs6fGnZz44
	nmzxyXBkO7i2g56Y1qgwVJKm06vjf8m1PjQDyBV0TuK9ZwGaOsNQ8zfusgq/5e4iTTdwAHa3XqJNk
	2jpb2Z4GAQiSDi/kuXOgBDSLobkz6CPaR6ypyjfv8DJZAzyclfQYwWYXztTBkgdr3aSJymn4Wfqme
	fii43uTGFSYuSDcDHWaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZqzH-0006qy-LJ; Thu, 20 Dec 2018 05:35:11 +0000
Received: from ni.piap.pl ([195.187.100.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZqzD-0005ba-Dg
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 05:35:09 +0000
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ni.piap.pl (Postfix) with ESMTPSA id D5080442F7C;
 Thu, 20 Dec 2018 06:34:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl D5080442F7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
 t=1545284089; bh=N7tvcnoULoVNvBLqrSbdjREdcuShrGpRsI190dhIuFM=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=CvYi/G36FxTXpBeGAxuYSsFe5McrqxCmRFZFNUojB1hAoHX1Wsw2hhL60lsTXs99v
 ST/rZV3nl1NnkEHtgDHPt4kg85g3QowNsiAimi96cUP6wbb0aholjuhCPIxiwGNBwx
 P0pTFhvrcFhpM2y2Fn+w48qxc0a0Q59BIy2XRi/Y=
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Koen Vandeputte <koen.vandeputte@ncentric.com>
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
Date: Thu, 20 Dec 2018 06:34:48 +0100
In-Reply-To: <20181218111743.25566-1-koen.vandeputte@ncentric.com> (Koen
 Vandeputte's message of "Tue, 18 Dec 2018 12:17:43 +0100")
Message-ID: <m3ftushibr.fsf@t19.piap.pl>
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 133095 [Dec 20 2018]
X-KLMS-AntiSpam-Version: 5.8.3.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 231 231
 9dea0b25c41088d21916a1c47656a2cb8fde7ab6, {Tracking_DKIM, one},
 {Tracking_ sender_matches_from}, {Tracking_subj_double_letters},
 {Tracking_weird_subj_double_letters}, {Tracking_text_let_digits},
 Auth:dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2018/12/18 12:58:45
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server,
 version 8.0.1.721, bases: 2018/12/19 20:50:00 #9216466
X-KLMS-AntiVirus-Status: Clean, skipped
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_213507_817819_75A2D8F1 
X-CRM114-Status: UNSURE (   9.74  )
X-CRM114-Notice: Please train this message.
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
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>, Russell King <linux@armlinux.org.uk>,
 stable@vger.kernel.org, Robin Leblon <robin.leblon@ncentric.com>,
 Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Koen Vandeputte <koen.vandeputte@ncentric.com> writes:

> --- a/arch/arm/mach-cns3xxx/pcie.c
> +++ b/arch/arm/mach-cns3xxx/pcie.c
> @@ -83,7 +83,7 @@ static void __iomem *cns3xxx_pci_map_bus(struct pci_bus *bus,
>  	} else /* remote PCI bus */
>  		base = cnspci->cfg1_regs + ((busno & 0xf) << 20);
>  
> -	return base + (where & 0xffc) + (devfn << 12);
> +	return base + where + (devfn << 12);
>  }
>  
>  static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,

Acked-by: Krzysztof Halasa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
