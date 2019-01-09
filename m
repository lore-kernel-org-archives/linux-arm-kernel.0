Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B1EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:02:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE42206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l0z//zIN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNNv1zEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE42206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6EqiVCK5dxGB9kK79ZvVP6x9sasnsJkWaG/UdqmggPs=; b=l0z//zINgJtQtv
	T9UXI4dsyna1sC6oX9hw2qw9xIpFfpFVv108Onc/dgTqpe8jqh4D9WhHzVMqbNx4S2jblqWdJW31y
	xNzkOJOm8nbsWTY36WSK5ZLCYZVPNp1OYNxG8DVm28quWSkeZXYgefYcrK10QZaH0a+FKB7b3mcMx
	wEL8TJtmsmH593CsKgjA3ygHhI4sEC0pZow3G6vfabjFbpWEpCUS6quFQK75ExtPNhoL1sWjX2Eyl
	E+O0gNeOYNPNO4YXgpf8k1OXUeLFinFVJPwsM0663Ki6h1kyrirfNUn0wAby9shz4swuEJ4CdKKUJ
	iq1lOgVENkUVkHnj2uBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghCYm-0002Vo-HP; Wed, 09 Jan 2019 12:02:12 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghCYe-0002VL-R7
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 12:02:10 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so7397145wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 04:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tbjNS7GqTZk7ZoP+3UmQlPWvbkXrNwlmwvUJX3Vz3xc=;
 b=cNNv1zEULjB4v4Wy0+JMOya1Oro64MK+SqlXs/FrQ54Z98WvVrxhC2ZpB6dY/NnxAw
 A8ftbJ9h72/nAjCTc/fbr5h7myHh5kOIeNmmgLwcbEh4YJZwi9b3xKnntb+Uf1ZiZRY1
 HiGRhD/JKPmX5OLVfcdJE00jATRoekjqkiMIeM7fGc9efglvZ6JNFO3FXKuA4n1Q03gw
 157s35QSAxPHVn7VtF+uIiZkP7ZVuRtAn+RvxxIYX5yeQzbDuAiTiNvPruviLORzx+9N
 DMN2HE0/jQ86Vb3QSMHMhp3XxrK/b+N2CjXU/2Hy2bwPnzEj3FgDJxMqiRytY4QiC6ko
 3o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tbjNS7GqTZk7ZoP+3UmQlPWvbkXrNwlmwvUJX3Vz3xc=;
 b=Da5z8K0rT3QEdkf+1rCQadKycTL2H4T1+2IS5i93kPv03GoqBIU/fxiEEX4bXyuQuR
 lMtWzyp6wOdjye+eljb5vn1W6318yq0ZaOFChT8GbZ88QjugAc7EgI29nz1WaOaGbb9C
 JggJjBxmbu3hq4jXRkJE2oWMvLGpfnI3IYyTw+QYIVaFDLvxge8R6SISrmrqaNLP0Rwf
 K4GkEz8nYW4C8dXmWo0KjqJVB8aG8JYJE6cHqBtDlUKoKF/wXaQj1ucAq03tIYrAfulo
 48iJttJsZsal1Xrnlz/PAyLlUyFtmn0cKebTyozPGjMGI5KZxKPcewzGRJyCgGyoF5vP
 726A==
X-Gm-Message-State: AJcUukd99EmRce6frKDoQWP5sCo+TxyV+bNS5kMxQJS5mwcgyPDfBBtt
 YIakfFo0C3ffzG0EE+sfGGQqwEpJ
X-Google-Smtp-Source: ALg8bN56r/10gCk8urIKRA/O65t9SxaXxjuPaP1eZR8z+7kZo810AfM0Gwz/O0GaLN+RlkqUmDRL/Q==
X-Received: by 2002:a5d:6244:: with SMTP id m4mr4707233wrv.314.1547035322276; 
 Wed, 09 Jan 2019 04:02:02 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz.
 [86.49.110.70])
 by smtp.gmail.com with ESMTPSA id s1sm83815101wro.9.2019.01.09.04.02.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 04:02:01 -0800 (PST)
Subject: Re: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
To: Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
 <20190109104922.z6g772vgncdqqbqt@verge.net.au>
 <20190109105754.vvqx6uvsktvxeq7a@ninjato>
From: Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <34cd1769-f0c9-0c2b-8947-4fceca9a9fb2@gmail.com>
Date: Wed, 9 Jan 2019 13:02:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190109105754.vvqx6uvsktvxeq7a@ninjato>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_040204_903066_BEAE7F09 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: devicetree@vger.kernel.org, Takeshi Kihara <takeshi.kihara.df@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/9/19 11:57 AM, Wolfram Sang wrote:
>> [    3.373714] renesas_sdhi_internal_dmac ee100000.sd: mmc0 base at 0xee100000 max clock rate 200 MHz
>> [    3.456829] renesas_sdhi_internal_dmac ee120000.sd: mmc1 base at 0xee120000 max clock rate 200 MHz
> 
> No mmc2 initialized. That should work regardless of eMMC. Probably
> something wrong in the DT somewhere.

Weird, it worked in next-20181102 with these patches, I just rechecked:

7818a9f06df1 mmc: renesas_sdhi: Whitelist R8A77990 SDHI
a05a906776f8 pinctrl: sh-pfc: r8a77990: Add voltage switch operations
for SDHI
2cc9d3a293e9 pinctrl: sh-pfc: r8a77990: Add SDHI pins, groups and functions
6b8d151613b7 pinctrl: sh-pfc: r8a77990: Add Audio SSI pins, groups and
functions
9167b22938f7 pinctrl: sh-pfc: r8a77990: Add Audio clock pins, groups and
functions
000cc50fc942 arm64: dts: r8a77990-ebisu: Enable HS200 of SDHI3
d3f59bbbf7ce arm64: dts: r8a77990-ebisu: Enable eMMC of SDHI3
5928c59bff8d arm64: dts: r8a77990-ebisu: Enable UHS-I of SDHI0 and SDHI1
dae32a3172b8 arm64: dts: r8a77990-ebisu: Enable SD card of SDHI0 and SDHI1
8feef039c6c6 arm64: dts: r8a77990: Add SDHI device nodes
25e9471b6a27 (tag: next-20181102) Add linux-next specific files for 20181102

I'll let you know once I figure it out.

-- 
Best regards,
Marek Vasut

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
