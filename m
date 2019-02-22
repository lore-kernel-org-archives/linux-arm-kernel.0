Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C728AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:57:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94980206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="THUfepF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94980206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RLih3S5PKd3v0iww1i9LNg6G0l12c2Fnd60+VuLqGCE=; b=THUfepF3BP+YLmUUGMVXwRRAR
	rRuhLXM0ZqdSgsD5tJ0o6u+n8iw4P7PYasWrVxTY1VW+xGCeePCBWiB6UOoK/mLnS9N6eSF54QmDD
	jWqU2KP2pQqZOupz/1+PfmdlxzWij6HmJdUN6hOsMhp0gMX4UQv8C/Oj+cdXJpKhN2RT0hSynHYKU
	OepulrIqinYqk+xOVkN+P3ZbBciWdv7VAZJFQiiSGlV5G34TpqoWrWBJaVFHgon28mOpefM/V9hc4
	nuHznZF/h5sW+wO2DAyX/vCWdoO/4mAR3ZTyFh2HdOx6DMK04qOg90lxkiOIH9NkL9A96Z+y4Q9By
	8BX6gB7Ww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxIpA-00056N-8W; Fri, 22 Feb 2019 21:57:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxIp7-00055a-US; Fri, 22 Feb 2019 21:57:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 038FD80D;
 Fri, 22 Feb 2019 13:57:35 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E08433F575;
 Fri, 22 Feb 2019 13:57:27 -0800 (PST)
Subject: Re: [PATCH 2/3] dt-bindings: net: btusb: add QCA6174A IDs
To: Brian Norris <briannorris@chromium.org>, Heiko Stuebner
 <heiko@sntech.de>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-2-briannorris@chromium.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5efc9f02-eeb8-78cc-0f11-13e0010efd46@arm.com>
Date: Fri, 22 Feb 2019 21:57:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222003403.128243-2-briannorris@chromium.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_135737_990341_FC975A71 
X-CRM114-Status: GOOD (  15.80  )
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
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rajat Jain <rajatja@google.com>, Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-02-22 12:34 am, Brian Norris wrote:
> There are two USB PID/VID variations I've seen for this chip, and I want
> to utilize the 'interrupts' property defined here already.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>   Documentation/devicetree/bindings/net/btusb.txt | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
> index 37d67926dd6d..43c96c3380a6 100644
> --- a/Documentation/devicetree/bindings/net/btusb.txt
> +++ b/Documentation/devicetree/bindings/net/btusb.txt
> @@ -9,6 +9,9 @@ Required properties:
>   		 (more may be added later) are:
>   
>   		  "usb1286,204e" (Marvell 8997)
> +		  "usb0cf3,e300" (Qualcomm QCA6174A)
> +		  "usb04ca,301a" (Qualcomm QCA6174A (Lite-On))

Nit: the USB device binding states that those leading zeroes in the VIDs 
should be suppressed.

Otherwise, thanks for the tip-off - I hadn't realised that OOB interrupt 
support was fully implemented already. I'll have to give this a go for 
the Realtek module in one of my TV boxes :)

Robin.

> +
>   
>   Also, vendors that use btusb may have device additional properties, e.g:
>   Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
