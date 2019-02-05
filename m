Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E12C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:18:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284DD217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bGzhYaHV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyFrFIcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284DD217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:To:References:
	Message-ID:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=81BAIxH9ku1tozXpE2mAl9bVY8azLNj/hppKAI3SmyY=; b=bGzhYaHVxA2vtd
	hrVI5Da79SoGzebsFpPdNgD/pfMtG0Vt+Z983T/Dux7GRZeAHghwd31UNaWqRiV2Uf3bkrsWfhUdf
	gHaVc374AG9WcdnTqG6IdsBgJfc1zJ5LsN8ezHwHdHckzA6DlQQpIH4WsUKtIZ/6U4E/QrADB91FU
	TOyyVPTJf0Dhc6w59vcOF1wCXBnYtkPrOqxc/5h09AfrlEi9M6ysCnLTgR0nbdqDARxDNrFLvVnpo
	kiO02TNe0Spq0+UHFmSGHAFI9XPKrx3/vsJKUCWPziltoZgQfM+e7l+F/3fBf0k2zX0XALkOx2o/c
	iqFWqag3e5kSfpaHP+yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr92v-0003hB-DY; Tue, 05 Feb 2019 22:18:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr92s-0003gN-EW; Tue, 05 Feb 2019 22:18:23 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0AD1620823;
 Tue,  5 Feb 2019 22:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549405102;
 bh=1KxpbNDUtd9p0XTakha1cU6vHm25z1i9tDxWJUMCw7c=;
 h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
 b=oyFrFIcjMJYaAxzblv5l42Ewz9cWQvg6oEI2bptKXchFWFQCpUblc+uLViq4T3g+m
 3P+M0u3c6VkENXBTac+6SwKXxgtjOrtm1tuNlTOBleL9ol1BPl3gLnLfvbb8aaXaPl
 7dy9LFyEhAmmqtyt94msYQhGfs4WNHosJ6bS0uQE=
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] clk: meson: Add G12A AO Clock + Reset Controller
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940510132.169292.12584338453129084603@swboyd.mtv.corp.google.com>
References: <20190204091331.9298-1-narmstrong@baylibre.com>
 <20190204091331.9298-3-narmstrong@baylibre.com>
User-Agent: alot/0.8
To: Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
In-Reply-To: <20190204091331.9298-3-narmstrong@baylibre.com>
Date: Tue, 05 Feb 2019 14:18:21 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_141822_505289_EB82FA6F 
X-CRM114-Status: UNSURE (   6.66  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Neil Armstrong (2019-02-04 01:13:30)
> + * Register offsets from the data sheet must be multiplied by 4.
> + */
> +#define AO_RTI_STATUS_REG3     0x0C
> +#define AO_RTI_PWR_CNTL_REG0   0x10
> +#define AO_RTI_GEN_CNTL_REG0   0x40
> +#define AO_CLK_GATE0           0x4c
> +#define AO_CLK_GATE0_SP                0x50
> +#define AO_OSCIN_CNTL          0x58
> +#define AO_CEC_CLK_CNTL_REG0   0x74
> +#define AO_CEC_CLK_CNTL_REG1   0x78
> +#define AO_SAR_CLK             0x90
> +#define AO_RTC_ALT_CLK_CNTL0   0x94
> +#define AO_RTC_ALT_CLK_CNTL1   0x98
> +
> +#define AXG_AO_GATE(_name, _reg, _bit)                                 \
> +static struct clk_regmap g12a_aoclk_##_name = {                                \
> +       .data = &(struct clk_regmap_gate_data) {                        \
> +               .offset = (_reg),                                       \
> +               .bit_idx = (_bit),                                      \
> +       },                                                              \
> +       .hw.init = &(struct clk_init_data) {                            \
> +               .name =  "g12a_ao_" #_name,                             \
> +               .ops = &clk_regmap_gate_ops,                            \
> +               .parent_names = (const char *[]){ IN_PREFIX "mpeg-clk" }, \
> +               .num_parents = 1,                                       \
> +               .flags = CLK_IGNORE_UNUSED,                             \

Can you please add a comment explaining why CLK_IGNORE_UNUSED is here?
It will help future readers know what's going on with this special flag.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
