Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02000C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:13:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFBF820657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WcRPmPzw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QP/tzos8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBF820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ce0cX5jgFrbmekcIQc7POqMnJvDmLHyfQSSm74hkV0Q=; b=WcRPmPzw+5+oul
	x2HHSy58+Qc3zOY4SBS7JNIn+l4V94frW/2eX8XckXyrNeg5iSmt1PZl9wGMfLT7L2PSO/6Sv1le4
	p0WpvasvUyZkydPF/JTEx+PkhRCj4fb2bZSoGQ8z9NV+zJ9eCHoNiOI6QFDVsYN0/sWFRvbR4W32Q
	oRoWtSKNSFlJzdE1UIlisNHm7Jiq9Vt1/xG7SN+5ln3wNYEDf7EVCFttX6zh5zzVkDPbuVK07AdDn
	bjQ2f2KJO3qkf+Zdd+rT08ccvLb7eYyDgLUQB1DxCOi4cDKXZysPuomZehi2ttTYf1UcSOTX0shFR
	sxQzjtiDGIc9QYOaV9Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkD6n-0003zV-V0; Thu, 17 Jan 2019 19:13:45 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkD6k-0003yp-AL
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 19:13:44 +0000
Received: by mail-pf1-x444.google.com with SMTP id b85so5286327pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 11:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=cwGXchQq9VSMeTDEdusJMMV+0chk4tV4Pl851aWw+oM=;
 b=QP/tzos8z2PCiZaEbY9P1CTcXgp6xLc4IdpJz6lvzxXUrosESQzEKuLGaB5lzckWLA
 ojojarq9uswLxGCXbv2SjaQDMPfkFP6PhdJOI+G40GUp1Prrka2WiZYiSGd/VMBc4Ina
 KzY0OoSxmunAwmoDDicbZ3eW0KzOR95ccejwcCmC5oikXjqm0BNfHsiM5BX2+5ObJjka
 Uv9dx5khSo1qQS8EKxR9a6J2+SpFa7+RFPW2wWRS99tDYIU5bBL1Q7FU/MSVoLiRBtVA
 ZpbIH/e5oGSq60pCkkAeWxfSHnWUT/MhGPBV49W+wqA/0HnPDc7XHTynrdpjnTs/cK3J
 Mx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=cwGXchQq9VSMeTDEdusJMMV+0chk4tV4Pl851aWw+oM=;
 b=jFcGwXG6uHSxzQNa1AkQ3vjOEST1TC8e+1e/ETtIfE5IkYlwWfdpE4M+oQmIWK9Xp5
 PjpJjH5HNJ0JM+SJtNdHsWCJAEMW6w1bDlOVzXlbBZH8ZjQwYFBMQPYp76K7P3kJvYJl
 g+pXlh+O01HhMxWQ4lvNu4oygERnd+2zXFTig+EnJfo/PA3oFjm5tJuOupGUQOS8s0/H
 t9qowTzGbMzpdmuAB5K3mCCYIwLNvMy96BEQ0q1sSAmZGnCDvHQ87n8UJruUp14dGq5l
 Fyd8eKa5d5srYPozPAh8qmPrOW1SlmIr+hG6eb5zesKxvXy7LMNn7PkEq+J+lkZOZeHM
 lEcQ==
X-Gm-Message-State: AJcUukc2UW0S0BGsvI/sX6muEo3pkxWv6NfMpzeig1/H8PqktFXp7ALD
 NoR64eggQB3FGcQD7svQhkw0kQ==
X-Google-Smtp-Source: ALg8bN62QUmUITJOFcU4VmunTRjQDbFtBfadZOcH8G1b/YGRxo5JQXNgchUgt7x6RQ8Ir1j95Irl4Q==
X-Received: by 2002:a62:824c:: with SMTP id w73mr5604118pfd.150.1547752420924; 
 Thu, 17 Jan 2019 11:13:40 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
 by smtp.googlemail.com with ESMTPSA id b27sm3753961pfh.113.2019.01.17.11.13.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 11:13:40 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
 Maxime Jourdan <mjourdan@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson-gx: Add canvas provider node to the vpu
In-Reply-To: <c7502035-0986-5d7d-b2b9-a35056146310@baylibre.com>
References: <20190114162229.5412-1-mjourdan@baylibre.com>
 <c7502035-0986-5d7d-b2b9-a35056146310@baylibre.com>
Date: Thu, 17 Jan 2019 11:13:39 -0800
Message-ID: <7ho98fcd24.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_111342_352959_A8295CA7 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 14/01/2019 17:22, Maxime Jourdan wrote:
>> Allows the vpu driver to optionally use a canvas provider node.
>> 
>> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index 44c5c51ff1fa..9b0ac183ee0c 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -510,6 +510,7 @@
>>  			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>> +			amlogic,canvas = <&canvas>;
>>  
>>  			/* CVBS VDAC output port */
>>  			cvbs_vdac_port: port@0 {
>> 
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.1 (brancH: v5.1/dt64)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
