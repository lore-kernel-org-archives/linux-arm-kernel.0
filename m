Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40817C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:35:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1182720838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aZK7ZsiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1182720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t4jOtuM7rWu5daxemOfdFNRvuKyHED+Hw0KCrbkYJ8c=; b=aZK7ZsiJYEPFJ0
	//TZDJ05y+gdkylSQo3zDnBsaR1UC8LQe0MYeqhSYrTndmPVsCjU21HgwqCYzkK+QcYAvU8QEDsk4
	BBn+Kvl5SaGi7TdKOf1ocSWllXSNqRf3kSoQ82BCR+D6oWX0s/DI6ppgASPBvS9uGruWGikMrm5lF
	QwoTpX5LIaVcSqDI919aLDJFcrrnw8jlp6Oi6KChduFZGWPs51qmWFLJeEu7Oes55slfJLP+eb9Wn
	XSMW/C1S2AzftgFsc5DZGRAa7lKD9ydGQKqk4g7F1e52jxrt6JOxMuv1/tm7Y5EG/huYna7vmx4qu
	R1UuEn8K1UVDPtNzKK5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVCXE-0001bH-G4; Fri, 07 Dec 2018 09:35:00 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCS0-0003MR-Ck
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:30:50 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id CE57B13F8A2;
 Fri,  7 Dec 2018 10:29:06 +0100 (CET)
Subject: Re: WIP: UFS on apq8098
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: Evan Green <evgreen@chromium.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
 <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
 <ec633e12-b6c1-5de9-690c-a58b8ecdb2b8@free.fr>
 <48b1a7ce-afb7-18d3-6855-69196972d640@codeaurora.org>
 <a4c0c2e1-09d8-c48f-d434-6147c047c3a8@free.fr>
 <d99567c7-9c1c-6d7e-6dd1-2930b82db7d8@codeaurora.org>
 <0c189977-62dd-3539-3b5c-233773682e69@free.fr>
 <1dbb2f0b-0ad1-e622-a9c4-9ff7284dbee7@codeaurora.org>
 <7a7ccedd-c6b2-6789-c76e-ad2ddcd53e2a@codeaurora.org>
 <6b8898b9-a9cb-8a72-0c73-f8a956cf629e@free.fr>
 <CAE=gft7Pd5u4Axa1XNf+tSYC_awxT8VLNXfJg7820LA1z9RtZg@mail.gmail.com>
 <b1349dd8-ef6f-7506-888a-9204870d040f@free.fr>
Message-ID: <359a1d1b-ec40-7362-ca3b-1c0ee11fcb2b@free.fr>
Date: Fri, 7 Dec 2018 10:29:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b1349dd8-ef6f-7506-888a-9204870d040f@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_012937_774446_DA83FCCE 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: Jeffrey Hugo <jhugo@codeaurora.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 07/12/2018 09:57, Marc Gonzalez wrote:

> On 06/12/2018 17:45, Evan Green wrote:
> 
>> I'll throw my random thought into the hopper here. With one particular
>> brand of UFS part on SDM845 we needed to make sure we banged on the
>> ufs_reset pin before the device would re-initialize fully. My hunch
>> says this is not your issue, but it can't hurt to make sure this is
>> happening.
> 
> First of all, thanks for chiming in. I feel I'm close to making this work.
> 
> My UFSHC DT node defines:
> 
> 			resets = <&gcc GCC_UFS_BCR>;
> 			reset-names = "rst";
> 
> If I'm not mistaken, the uhfhc driver should tickle the reset register?
> Is the ufs_reset pin something different?

In fact, I based my UFS stuff on your UFS stuff.
[PATCH v5 0/5] arm64: dts: qcom: sdm845: Add UFS DT nodes

I read the comments in that series, including the fact that the "resets"
property is ignored by the ufshc driver.


Grepping for ufs_reset downstream, I see:

$ git grep -i ufs_reset vendor
vendor:arch/arm/boot/dts/qcom/msm8998-pinctrl.dtsi:                             pins = "ufs_reset";
vendor:arch/arm/boot/dts/qcom/msm8998-pinctrl.dtsi:                              * UFS_RESET driver strengths are having
vendor:arch/arm/boot/dts/qcom/msm8998-pinctrl.dtsi:                              * HDRV value | UFS_RESET | Typical GPIO
vendor:arch/arm/boot/dts/qcom/msm8998-pinctrl.dtsi:                              * POR value for UFS_RESET HDRV is 3 which means
vendor:arch/arm/boot/dts/qcom/msm8998-pinctrl.dtsi:                             pins = "ufs_reset";
vendor:arch/arm/boot/dts/qcom/msm8998-svr20-pinctrl.dtsi:                               pins = "ufs_reset";
vendor:arch/arm/boot/dts/qcom/msm8998-svr20-pinctrl.dtsi:                                * UFS_RESET driver strengths are having
vendor:arch/arm/boot/dts/qcom/msm8998-svr20-pinctrl.dtsi:                                * HDRV value | UFS_RESET | Typical GPIO
vendor:arch/arm/boot/dts/qcom/msm8998-svr20-pinctrl.dtsi:                                * POR value for UFS_RESET HDRV is 3 which means
vendor:arch/arm/boot/dts/qcom/msm8998-svr20-pinctrl.dtsi:                               pins = "ufs_reset";
vendor:drivers/phy/phy-qcom-ufs-qrbtc-v2.c:     writel_relaxed(0x15f, qrbtc_phy->u11_regs + U11_UFS_RESET_REG_OFFSET);
vendor:drivers/phy/phy-qcom-ufs-qrbtc-v2.c:     writel_relaxed(0x0, qrbtc_phy->u11_regs + U11_UFS_RESET_REG_OFFSET);
vendor:drivers/phy/phy-qcom-ufs-qrbtc-v2.h:#define U11_UFS_RESET_REG_OFFSET             PHY_USR(0x4)
vendor:drivers/pinctrl/qcom/pinctrl-msm8998.c:#define UFS_RESET(pg_name, offset)                                \
vendor:drivers/pinctrl/qcom/pinctrl-msm8998.c:  PINCTRL_PIN(153, "UFS_RESET"),
vendor:drivers/pinctrl/qcom/pinctrl-msm8998.c:static const unsigned int ufs_reset_pins[] = { 153 };
vendor:drivers/pinctrl/qcom/pinctrl-msm8998.c:  UFS_RESET(ufs_reset, 0x19d000),

Upstream:

$ git grep -i ufs_reset master
master:Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt:                    ufs_reset
master:Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt:                     ufs_reset
master:drivers/pinctrl/qcom/pinctrl-msm8998.c:#define UFS_RESET(pg_name, offset)                                \
master:drivers/pinctrl/qcom/pinctrl-msm8998.c:  PINCTRL_PIN(153, "UFS_RESET"),
master:drivers/pinctrl/qcom/pinctrl-msm8998.c:static const unsigned int ufs_reset_pins[] = { 153 };
master:drivers/pinctrl/qcom/pinctrl-msm8998.c:  UFS_RESET(ufs_reset, 0x19d000),
master:drivers/pinctrl/qcom/pinctrl-qcs404.c:#define UFS_RESET(pg_name, offset)                         \
master:drivers/pinctrl/qcom/pinctrl-sdm845.c:#define UFS_RESET(pg_name, offset)                         \
master:drivers/pinctrl/qcom/pinctrl-sdm845.c:   PINCTRL_PIN(153, "UFS_RESET"),
master:drivers/pinctrl/qcom/pinctrl-sdm845.c:static const unsigned int ufs_reset_pins[] = { 153 };
master:drivers/pinctrl/qcom/pinctrl-sdm845.c:   UFS_RESET(ufs_reset, 0x99f000),


I need to find the way to make Linux tickle/toggle the ufs_reset pin.

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
