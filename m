Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E3CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:01:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1282173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dGxReJO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1282173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WzttW+zNdr51mNBMRurlrlLO/auJv7etR1rJpF4BYXU=; b=dGxReJO29005CT
	TPt+4tX/iqkm8JLZlqdxPC9HDAq39tksqPqMs13QAT/2iCQ1dTMfyL0OFhq4jUeSa7WUYUqHg3CoG
	mmQuN2+Qtja1mwQjY+MUY4vIS6SKPMBv6EYTTQ7r0k8Um4ymtBBatSqwOluTKUuPdLsoTsFBL+U4Q
	7cVr1JcYNvsDdkoRtJ9PGHIpNXV9vJPfoQ9YJhAQujNgm7N1chPu4aHY3ih91X6En2l/PJ2LyXP0f
	KTbnt6t4Z1akkGkLZd0X49nq5517CtjAGTCkvkMe0KekXR18uAf9QoGvV40kNIFLfxMpriFDIsLU3
	JwD3FAFOFIwpIsrlyLXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyYcU-0006UI-Jf; Tue, 26 Feb 2019 09:01:46 +0000
Received: from coyote.holtmann.net ([212.227.132.17] helo=mail.holtmann.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyYcR-0006TM-Go; Tue, 26 Feb 2019 09:01:45 +0000
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de
 [79.249.243.97])
 by mail.holtmann.org (Postfix) with ESMTPSA id AEDF4CF2A3;
 Tue, 26 Feb 2019 10:09:29 +0100 (CET)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 1/3] Bluetooth: btusb: add QCA6174A compatible
 properties
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190222225345.69084-1-briannorris@chromium.org>
Date: Tue, 26 Feb 2019 10:01:34 +0100
Message-Id: <49653AC5-5800-4319-B3C0-0CCA6A920E2C@holtmann.org>
References: <20190222225345.69084-1-briannorris@chromium.org>
To: Brian Norris <briannorris@chromium.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_010143_706677_3A5A544D 
X-CRM114-Status: GOOD (  11.56  )
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
Cc: devicetree <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rajat Jain <rajatja@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Brian,

> We may need to specify a GPIO wake pin for this device, so add a
> compatible property for it.
> 
> There are at least to USB PID/VID variations of this chip: one with a
> Lite-On ID and one with an Atheros ID.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> v2:
> * drop leading zeroes from VID, per documented binding
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 470ee68555d9..54cb5f583b1d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2862,6 +2862,8 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
> 
> static const struct of_device_id btusb_match_table[] = {
> 	{ .compatible = "usb1286,204e" },
> +	{ .compatible = "usbcf3,e300" }, /* QCA6174A */
> +	{ .compatible = "usb4ca,301a" }, /* QCA6174A (Lite-On) */

are these really proper .compatible USB VID?PID strings. I think they are one letter short.

Regards

Marcel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
