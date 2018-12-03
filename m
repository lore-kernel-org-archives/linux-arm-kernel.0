Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4CEC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:23:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABE320661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y5mP98nL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABE320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+KYlIEzjXomaHcOMGennVrSQSxkuh8BvgjnPc8fTjjs=; b=Y5mP98nL6h1Xuu
	ul/yjjTXhzhhIXStF5uuX65zeOAHQrYlm4Jgrh3ItXwkVZs5YH1eaIzPAbWYNXllK+LR94hnyxRlu
	Rr6pZ56eVc4xDWvG77Yp5auqNumxdnQqRiUup8MNNI9+Z9684mz5nKgcocjhnEikiiql7k4Q99u2R
	v6w+Yvy1hIKzbDAUYIhnAz8L0JyqaMScLQuYTWhWheqrEQH6+xFKFd/S3NfkXdA8/YXO3cCB09Voz
	j0qbxom/vuAVndUblX8RfF46eNbo/5VP58aMEJCMhKvFstqamKMathNImo9D6wqRHTQDwJXmjbVA6
	SyMbNH3Mm2up9p407djw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTr0A-00022D-3v; Mon, 03 Dec 2018 16:23:18 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTr06-00021T-Ap
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:23:15 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 08F2613F8BA;
 Mon,  3 Dec 2018 17:22:43 +0100 (CET)
Subject: Re: WIP: UFS on apq8098
To: Jeffrey Hugo <jhugo@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross
 <andy.gross@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <de223e7a-3b60-0566-997f-b607bbc15007@codeaurora.org>
 <7d588806-5699-2d87-e95e-f1388de01a74@codeaurora.org>
 <8b697e3b-6cb5-41ea-cd56-94c54082c58b@free.fr>
 <e1b8ed92-c310-97ed-c1bd-5b90af76b3a0@codeaurora.org>
 <0dd4dfa9-5c54-702a-c830-a9f4eba2bcc9@free.fr>
 <7ca7d95d-87a3-1704-c14d-6d6c78bd4f73@codeaurora.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <0276ecdc-98cf-7342-4b12-ddcaec4aa21c@free.fr>
Date: Mon, 3 Dec 2018 17:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7ca7d95d-87a3-1704-c14d-6d6c78bd4f73@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_082314_529426_02B38CC1 
X-CRM114-Status: UNSURE (   8.67  )
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 03/12/2018 17:18, Jeffrey Hugo wrote:

> Ok.  Then its non-obvious to me why you are getting the ref clock error.

Sorry for being unclear, the issue was resolved with
(as specified in Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 10e7b8a55b8a..b5b2b05bc782 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -745,12 +745,8 @@
                        #address-cells = <1>;
                        #size-cells = <1>;
                        ranges;
-                       clock-names =
-                               "ref_clk_src",
-                               "ref_clk",
-                               "ref_aux_clk";
+                       clock-names = "ref", "ref_aux";
                        clocks =
-                               <&rpmcc 0>,
                                <&gcc GCC_UFS_CLKREF_CLK>,
                                <&gcc GCC_UFS_PHY_AUX_CLK>;
 


PHY init seems to work now:

[    1.000150] qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.15
[    1.000256] qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.16
[    1.000882] qcom-qmp-phy 1da7000.phy: Registered Qcom-QMP phy

Moving on to MAC init errors :-)

[    2.314303] ufshcd-qcom 1da4000.ufshc: ufshcd_get_vreg: vdd-hba get failed, err=-517
[    2.314530] ufshcd-qcom 1da4000.ufshc: Initialization failed
[    2.376216] ufshcd-qcom 1da4000.ufshc: ufshcd_pltfrm_init() failed -517

(I do note that sdm845 does not define the vdd-hba-supply prop.)

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
