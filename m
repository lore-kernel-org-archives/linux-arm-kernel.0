Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D54C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:29:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705842186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VfIpxSsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705842186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aXiHxTEv+G3GbdTeNhlD8AmRxTa9C85dMn/ROiTx2LE=; b=VfIpxSsAMgoQUu
	5IURg0Xbt0mKVVaFDJV0Cjt0WdX8L9wDmmsJQLrr4gvA7qlPebCdRlie6rgGoiVAP+xOHswV8TScg
	908qbCqAMSbSzDeWkOkwR4GpZ0ir6z+kthCCSN9HUCALeKeMQyVdjbWGZHeGgzWddp3ndqBaaSakJ
	Mnz8rKVg5YfoldtUdmJT0jeaeycN66xIvHxVXtdqLgSjNvLWkBCjbvk1aexcrQMDu3B0YqGvcWZjg
	/aB52MVCqlOq/2u4dc6ESQt0rZhaPizU+1WE1p6JaYhMeddzKDFaNdDcZKcJ/NBRYh6y9rQEhR7im
	HBRyllKILkx9Mz1Or7qQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvT4D-0005gl-JH; Sun, 17 Feb 2019 20:29:37 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvT49-0005fu-2T; Sun, 17 Feb 2019 20:29:35 +0000
Received: from oxbaltgw66.schlund.de ([172.19.246.153]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MUGmL-1gVJUj1mJH-00RG9i; Sun, 17 Feb 2019 21:29:26 +0100
Date: Sun, 17 Feb 2019 21:29:25 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: David Summers <beagleboard@davidjohnsummers.uk>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
Message-ID: <1660942499.343639.1550435365757@email.ionos.de>
In-Reply-To: <20190217121513.22965-2-beagleboard@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-2-beagleboard@davidjohnsummers.uk>
Subject: Re: [PATCH 1/3] ARM: dts: rk3288 Tinker Board (S) sdcard changes
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:yyp8ugeQKaJkarL5nQL8c6OBqtL22rEdvwJ/45AkpBVm0YaVfer
 zt8ONq9m3aLKdscGUBTFD9/wvd3dKcYztW42/ITVBtjjlSzZiSaKhzPtH1nAu6TXZqw7DIZ
 DqGW1jdoOfjecrcPLuOD3b+suamnAUH7rZ1PE8kdL9NZkA2gt0zTNIRB8tLPkgKyWp+s2mu
 GTKsHs2iHQsKxRzDXcmGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cab5vj1xGsA=:Mj12h2BuybJdyquoNDc5/n
 PQa8g4D9rcqeNdL8KWy2jsI5m2KVPSDRPGczELDa/l+KRmO8ckjbDB1B8wZy/tf218mRDWfSk
 X2rIOXYcAoH9aL3dLUamSbwuAV8fTkhd0cOJJSDOjduTQOdicqhmWDJMdyvuILRFIlnRda9ed
 UTVuk68cG0yaDn31o9wTIZfr2p+u/aTG0m/dWCqqDsVCbCxK+2NfADPXOBjuBNfrej6VVeiBN
 MIf6L3ukyzATuir9rAGO9GjWX3b6/QBnTpAVTRXdv2X7BAFoMpF0sZXzO7Z3sYtX7C8QJfdmD
 1kKLFwVjsDY+s2/kJ9bi6QyEzEsTtc/KMM9P/Y534xyOjVRnWUcynIKGBP+hN+xxfxl0qRbll
 FZPEd0l8GzwqvdKKjxeCU+ykheyR92dVhTErYG7olnJmMW5m/A2V/59/osAiemZ60jKLlbwNY
 Tlyy788stEH9oQHSbngNjZYmODaahR+qPv3dNTOGRes49TXI0jsOnRX1I4vwxcSxQnvYV6hM4
 9hpI3TRljr8ZL+Mm9gnk59h9xTOS392q/wmqFPWGO47TlaRSI/inpi2FPrtl9DWPZAJE2Ci56
 nGHZtIh8UiYj6fquZQQabWGBdVjqFo1e019KNf43xe+mzWOeaRU4qg+/1ioJKo60f7mZeina0
 JoyxAy9kL4gJLB+ZsdhUVFRPYYsNlDqIYgKFA0IT/C98ny1vC7Ob/225RYuejYmYt7oP2M4IB
 aHyYSi5upwmkP0stR22E3gWV9vt2jUd/6u36B8/MPil17+ZsXHCQ2C1U3FE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_122933_414819_83D20225 
X-CRM114-Status: GOOD (  27.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi David,

we need a better patch subject here e.g.

ARM: dts: rk3288-tinker: Fix SD card detection

plus a Fixes tag for the commit we want to fix.

> David Summers <beagleboard@davidjohnsummers.uk> hat am 17. Februar 2019 um 13:15 geschrieben:
> 
> 
> This patch makes some minor changes to how the sd card is
> described in the device tree for the ASUS Tinker Board (S). In
> particular on the Tinker Board S, when booted from the eMMC, and with
> no card in the sd slot, and the log has endless messages about not
> being able to detect the card.
> 
> Several methods to remove this error have been tried, the only one
> that works is the broken-cd and so that is what is applied here.
> 
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
>  arch/arm/boot/dts/rk3288-tinker.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index 2b38075a2917..fceaeed44e34 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -432,9 +432,7 @@
>  	bus-width = <4>;
>  	cap-mmc-highspeed;
>  	cap-sd-highspeed;
> -	card-detect-delay = <200>;
> -	disable-wp;			/* wp not hooked up */

I think we should keep as long as it doesn't hurt.

> +	broken-cd;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
>  	status = "okay";
> -- 
> beagleboard@davidjohnsummers.uk
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
