Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DF9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:00:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B733222ED
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xf34qlOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B733222ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xxffFmHIXS685bqw7jJ+JwXw48RWgMIULhagJyWjwCM=; b=Xf34qlODhkumMD7kslviS9Zs7
	Zk8ybbI/wOUXiE/Ux3XJnPtdpxYGNwTWVbl1Ph5YmK8UR/Gszos3mfl8O6FqsKZbmXAMYWRX21O3V
	PQA75XA0iAb6NkJ5IncMBAGgGr04r9y25SFnTu1Pp4MJOwdiYdgMhO5q5YnkFY4IlsLlTeUvQKRff
	DRa95GIi9VeST4tpHLJ+E56Gd7UKnMf2+tx4T/wmN5SKe06wyeJKydC0BdLAaPlTKeJrTbAu7gpFq
	DclZ/vI0wUSL6MODcEQ2VqaZiXjxS9Dg5SgcY5zi2A9AvjDeBcYhGIYGVUkG0SeORlBFaWYdP1aEi
	eASGrucOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvMzX-0007Tk-JL; Sun, 17 Feb 2019 14:00:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvMzU-0007TD-OW; Sun, 17 Feb 2019 14:00:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12FD380D;
 Sun, 17 Feb 2019 06:00:13 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8774F3F557;
 Sun, 17 Feb 2019 06:00:10 -0800 (PST)
Subject: Re: [PATCH 1/3] ARM: dts: rk3288 Tinker Board (S) sdcard changes
To: David Summers <beagleboard@davidjohnsummers.uk>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-2-beagleboard@davidjohnsummers.uk>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e83b0404-bd32-a5d5-2e32-e0f49b122b95@arm.com>
Date: Sun, 17 Feb 2019 14:00:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190217121513.22965-2-beagleboard@davidjohnsummers.uk>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_060020_802345_FB5E15C0 
X-CRM114-Status: GOOD (  29.80  )
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

Hi David,

On 2019-02-17 12:15 pm, David Summers wrote:
> This patch makes some minor changes to how the sd card is
> described in the device tree for the ASUS Tinker Board (S). In
> particular on the Tinker Board S, when booted from the eMMC, and with
> no card in the sd slot, and the log has endless messages about not
> being able to detect the card.
> 
> Several methods to remove this error have been tried, the only one
> that works is the broken-cd and so that is what is applied here.

I don't have a Tinker Board, but the symptom sounds instantly familiar 
from hacking on another RK3288 box; have you tried adding 
"regulator-always-on" to the vccio_sd regulator?

With the reference design (which I would assume the Tinker Board has no 
reason to deviate from in this area), the CD pin is either wired 
directly to the SoC with no external pull-up, or explicitly pulled up to 
VCCIO_SD. Either way, when the dwmmc driver probes and discovers there 
is no card present, it sets the currently-unnecessary vqmmc-supply as 
inactive, and thus the regulator core turns off VCCIO_SD entirely. 
Unfortunately, this removes the voltage from the entire I/O domain 
including the internal pull-up, which ends up leaving the CD pin 
floating and generating spurious events.

Robin.

> Alas the ASUS schematic is not clear enough to indicate if the card
> detect is wired up to the cpu, the schematic does not show internal
> wiring on the Tinker Board!
> 
> Now this error didn't show up on the Tinker Board, as that machine
> only boots where there is a sd card installed. However as the TB and
> TBS are so similar it is expected that the Tinker Board also doesn't
> have a functioning card detect. Hence the change here is made to the
> dtsi file, so it applies to both TB and TBS.
> 
> The disable-wp is also removed, it doesnt seem needed on the micro
> sdcard slots, and without thisn the card can still be written
> to. Hence this flag is also removed.
> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>   arch/arm/boot/dts/rk3288-tinker.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index 2b38075a2917..fceaeed44e34 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -432,9 +432,7 @@
>   	bus-width = <4>;
>   	cap-mmc-highspeed;
>   	cap-sd-highspeed;
> -	card-detect-delay = <200>;
> -	disable-wp;			/* wp not hooked up */
> +	broken-cd;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
>   	status = "okay";
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
