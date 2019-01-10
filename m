Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A98C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:18:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04519214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UhU2/bKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04519214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v7vG2+JLIda5dq1S26lXdzYyc6QvIrRR9j3iOBt2W3s=; b=UhU2/bKv0LYY6t97FP+LdENg8
	Vi6yLNWxWX3OrSXIF4Iha45WMhTsJ5wMnkn13D/89NjgSmsNknClBVZ1Rr77bAaX7tv4CJvrQrSKf
	5wkQ+PWSukPhk42/P5Ol/qSpXbDVP6/yywxzvaVFC42/XLSZY5iZVzLH+ZKWh535HBuHox/mVS51L
	AJt1aou75/qv1KIUNsKeOAHfe4+BA44LCt0OyUui2ZHsq9yZcPxkQHPScPh20+ss94IOu2cipWf1B
	S2RqjJndyUa6J4Plco/na+S2m5dy4gYmgsjH7ui+BGZ8e5653vtkpqb4Ax29eNTuWG2MSkNnrXgFx
	VXKWlG/dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbAX-0002uh-Vy; Thu, 10 Jan 2019 14:18:50 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbAT-0002tw-3C; Thu, 10 Jan 2019 14:18:47 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: tomeu) with ESMTPSA id AF93F260641
Subject: Re: [PATCH v5 1/5] arm64: dts: rockchip: Add DT for NanoPC-T4
To: Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>
References: <cover.1546981251.git.robin.murphy@arm.com>
 <a92dd6f978b2b026557ca681610400c83ebf59b2.1546981251.git.robin.murphy@arm.com>
 <3242500.qteudgsQcv@phil> <b192edd9-7d08-3b7f-cae0-620e95a7bbce@arm.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <9978c094-d56f-51ca-77bf-023f69d160d5@collabora.com>
Date: Thu, 10 Jan 2019 15:18:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <b192edd9-7d08-3b7f-cae0-620e95a7bbce@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_061845_266213_1D344157 
X-CRM114-Status: GOOD (  13.28  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/10/19 2:42 PM, Robin Murphy wrote:
> On 10/01/2019 13:37, Heiko Stuebner wrote:
>> Am Dienstag, 8. Januar 2019, 22:57:23 CET schrieb Robin Murphy:
>>> From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>
>>> This adds a device tree for the NanoPC-T4 SBC, which is based on the
>>> Rockchip RK3399 SoC and marketed by FriendlyELEC.
>>>
>>> Known working:
>>>
>>> - Serial
>>> - Ethernet
>>> - HDMI
>>> - USB 2.0
>>>
>>> All of the interesting stuff is in a .dtsi because there are at least
>>> two other boards that share most of it: NanoPi M4 and NanoPi NEO4.
>>>
>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> [rm: various further cleanup]
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>> nobody complained, the binding was reviewed and all looks good
>> so I've gone forward and applied this one for 5.1 already.
> 
> Awesome, thanks!
> 
> I'll probably follow up with a v2 of the rest of the patches next week, 
> after I've had the chance to play some more over the weekend.

Thanks a lot for picking this up!

Have given the whole series a try and haven't found any issues. I have 
booted with nfsroot and have only run a few OpenGL apps with panfrost, 
using ARM's GPU driver.

In case there's time for it:

Tested-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Cheers,

Tomeu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
