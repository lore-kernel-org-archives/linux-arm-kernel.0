Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E25C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:57:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225B420823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a9SUZkCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225B420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZG7IH7dqVLi70SG3iq2QqhrjT8u1rGcnQrULKkNIDgQ=; b=a9SUZkCUCmSewi
	orv04Vf6ejcthnPSz642JJfBbTeLHBv8NSiHvE/kYRnXLB8lxBvSi+YNDetT/jxwe2UWN5JLP3xCF
	Fii6v3qPmM+GKbVjn0hsFW7ij15iGC/PHyATUAMYhijJLESU7XLNoi8h473p3SkGEAPSMzs2NWlE1
	v318XTZ2ZgMMIAQnAYvpeDpKExFpQSyXNOxCMwBofZeaqvelLfv+pysgYlf9DKPWo+yY82niUv197
	qBhtuu+A1ghfVwKoncpxzP7aG6OsgVTSjCR0wtYvi8TykYg+JToIAlCHJ7aUKGMtho1BtMXChAe2T
	osVFVIM5S5kA3+8OTWOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkRq6-0007Sf-Td; Fri, 18 Jan 2019 10:57:30 +0000
Received: from coyote.holtmann.net ([212.227.132.17] helo=mail.holtmann.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkRq0-0007IW-Se
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 10:57:27 +0000
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de
 [79.249.253.96])
 by mail.holtmann.org (Postfix) with ESMTPSA id 3BAFCCEE14;
 Fri, 18 Jan 2019 12:05:04 +0100 (CET)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCHv2] Patch to add the realtek bluetooth device tree refs to
 the code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190103163538.6575-2-beagleboard@davidjohnsummers.uk>
Date: Fri, 18 Jan 2019 11:57:17 +0100
Message-Id: <510BE8B9-76BD-4A64-86C2-ACA1D50819DF@holtmann.org>
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-2-beagleboard@davidjohnsummers.uk>
To: David Summers <beagleboard@davidjohnsummers.uk>
X-Mailer: Apple Mail (2.3445.102.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_025725_677687_402344F5 
X-CRM114-Status: GOOD (  15.63  )
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
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi David,

> This patch adds the necessary device tree hooks to the realtek
> bluetooth driver for serial connections.
> 
> The realtek devices that are listed btrtl.c are searched on the
> realtek web site for the version that have serial connections.
> 
> Most of these devices also have wi-fi connected via sdio, that is not
> covered by the bluetooth driver - but as that interface will also be
> needed in the device tree, the hocks here have "-bluetooth" added. The
> exception to this is the rtl8761atv, which only has a serial
> bluetooth.
> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
> drivers/bluetooth/hci_h5.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..2fec7ff2ce7c 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -925,6 +925,22 @@ static struct h5_vnd rtl_vnd = {
> };
> #endif
> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id h5_of_match[] = {
> +#ifdef CONFIG_BT_HCIUART_RTL
> +       { .compatible = "realtek,rtl8723as-bluetooth"},
> +       { .compatible = "realtek,rtl8723bs-bluetooth"},
> +       { .compatible = "realtek,rtl8723ds-bluetooth"},
> +       { .compatible = "realtek,rtl8761atv"},
> +       { .compatible = "realtek,rtl8821as-bluetooth"},
> +       { .compatible = "realtek,rtl8821cs-bluetooth"},
> +       { .compatible = "realtek,rtl8822bs-bluetooth"},
> +#endif

I really need an Ack from Rob on the naming here.

Regards

Marcel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
