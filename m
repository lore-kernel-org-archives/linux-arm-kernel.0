Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC516C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:32:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7B02173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bU/8QgW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7B02173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+bKEDvYD6fzX7r0KnYz0mMpERYolxeNF1NeebA0W6HQ=; b=bU/8QgW3y+kgANaEttrk1JczC
	q7qP7A8yHqbFQvVF+dlX3yh5U1HFENXcOVCTu7MdPdA1vHIa++5sPqMFWQVEGNWFLGb/t+gBthK/v
	nTyuLF1U1zMFlW5Qq7dfxUQp897ie/smSbe/AOW6k4CQbl9YqRrlBR5Dhq5E754VkDX5p2eklagEg
	PPe8gLHenyHefsZPkjtgRCednNEBsOmhOchbLt3vAaXmsYVFWbTqAMLkKG5KzXoHZKEkMYCnyX8Q9
	Pf6vI/UBPI+gmHzaQodO0WP7F7DKIGj1I2/95+D11FX0w/imER+C/LKLveSMckBXa25K/Uz1fXIDq
	j9+C94keg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycpy-0004rP-VD; Tue, 26 Feb 2019 13:31:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycpv-0004qU-Od; Tue, 26 Feb 2019 13:31:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B102780D;
 Tue, 26 Feb 2019 05:31:52 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EFB23F703;
 Tue, 26 Feb 2019 05:31:50 -0800 (PST)
Subject: Re: [PATCH v2 1/3] Bluetooth: btusb: add QCA6174A compatible
 properties
To: Marcel Holtmann <marcel@holtmann.org>,
 Brian Norris <briannorris@chromium.org>
References: <20190222225345.69084-1-briannorris@chromium.org>
 <49653AC5-5800-4319-B3C0-0CCA6A920E2C@holtmann.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a23b9467-1c41-e399-f011-8ca183be585d@arm.com>
Date: Tue, 26 Feb 2019 13:31:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <49653AC5-5800-4319-B3C0-0CCA6A920E2C@holtmann.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_053155_812534_036A09A2 
X-CRM114-Status: GOOD (  16.79  )
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
 Rajat Jain <rajatja@google.com>, Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 26/02/2019 09:01, Marcel Holtmann wrote:
> Hi Brian,
> 
>> We may need to specify a GPIO wake pin for this device, so add a
>> compatible property for it.
>>
>> There are at least to USB PID/VID variations of this chip: one with a
>> Lite-On ID and one with an Atheros ID.
>>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>> v2:
>> * drop leading zeroes from VID, per documented binding
>> ---
>> drivers/bluetooth/btusb.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 470ee68555d9..54cb5f583b1d 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -2862,6 +2862,8 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
>>
>> static const struct of_device_id btusb_match_table[] = {
>> 	{ .compatible = "usb1286,204e" },
>> +	{ .compatible = "usbcf3,e300" }, /* QCA6174A */
>> +	{ .compatible = "usb4ca,301a" }, /* QCA6174A (Lite-On) */
> 
> are these really proper .compatible USB VID?PID strings. I think they are one letter short.

Yup - however weird it may end up looking, the usb-device binding says 
"...with leading zeros suppressed". Blame Open Firmware, I guess ;)

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
