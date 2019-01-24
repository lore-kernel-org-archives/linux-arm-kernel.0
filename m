Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B5DC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:54:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC3F2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o3nwVCjo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WlF8/SST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC3F2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Y/x2Q4R+dAuQr6ODcUf6BufYxzeIl9Fc+xQgZcEomAo=; b=o3nwVCjoLBWdlf
	znte0KhNnSqMUiHeQthZggeiLRCbei1r0AJA7ViEhZ3ViNmS+SgjSGHsNu1AGmjpx2U+XQyQvfGDE
	6Q+XbREbnBLXcsNHRxY2pccNloQNucF/QzZHbPK0Qbb9lgztgnHot4aXSzbgtO34oXK3EzRoYtU7I
	Xh0TfYCCHQW+4lKFyK2WoVhAfZIEl9LNLCaQPM/hHno2UGi8OSJvT+R/hlpamgAACjZ6/vNEpXUdo
	hcmqodaQKU0O+DhwdfCoQedulS6HViEAVo1Y7vyLWgTuG0g+CaTkbeirywf1C9kebbcoRu6dWpE7R
	zW56KATaFEXehvrX5Q6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmZqU-00054P-SJ; Thu, 24 Jan 2019 07:54:42 +0000
Received: from mout.web.de ([212.227.15.14])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmZqR-000543-Q2
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 07:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1548316461;
 bh=Dv4ZwO8L8U1FGc4j1RQ51QfvFFkYO8rw6uipT9+UUAA=;
 h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
 b=WlF8/SSTGsZQUwSCow9pjsv9HqWE4A68uGPb/3MdESou62jRxDS3QbJzdg2eeyv7x
 n2sPeAksRttJNbLKSXMQV0F5QgBG0BALKt0QCqSCPyKeFe7x6/jkw6+Elopd0Scgxy
 F4hYrLFY2iemAvJSb9eLynBm0akNk95/yKbHUbQU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.57.47]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3Spk-1h4FHY3GN6-00qwiz; Thu, 24
 Jan 2019 08:54:20 +0100
From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] arm64: dts: zcu100-revC: Give wifi some time after power-on
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5eace97d-1b6f-60eb-98da-588a485fce18@web.de>
Date: Thu, 24 Jan 2019 08:54:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:uacCtbOIByhj7998d9jrhut9SYPLXGRUtoBT+E0E5J0t/eZHAvY
 Mx3uwBtvNe4hLLV/PQaE5JvLaZhpyDAtmTWEtGWDJuqqomN1n7sF/5azKUDypIp5V3FmplB
 7DNk4+GTiOA9sL6BBCOG+lOtdNIfaJ9OCXep4hGBVYA2OkvZRCk0TLEcTcUiDj48nnOAqoU
 4aNO8yrzaGvZntugYByMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u55lFuGdA5E=:JHN/ujzzN3qIoqmtSGoWH1
 0kTCntwqpfKB0zIeXmab0H/Fs9ztUlwXXNmp9VKP3vUtlPf6TCE0h6YVOK386gbPO4wZeU1JE
 mg6gMNbHDatL1X+71MhCDBV2f/Q3o6pUjYeDrgqQfqIKRxPMCcb+4jOZS3LnGuYRP8Zs3hKwT
 ZgZqJe5sEaVLYtqAEqZOGerGzUcV10eIYZVk+rgD/UgkplaLFF4HpwZQ06+GciVYW0K/wWrfO
 9SVxuW1t+zONW7OFdCFhzVp0mDSCDbYlGKSWRcJ7xHocKZb1nnItYPfqRqI6oFrxqlLIvMVKg
 7txlt0iDR6/kTq4x4VvqqNkqTMmuGBOoDNJdnOZKSlczZqEJkMH7gTR3C7ySC3fhaiw2JgRYO
 QMp6wkWpykNUUKxptJ2D7OSa9kDAabyBaZ9S2SC1DkeNVd3+CMYJQYHG4mH4k7ncq4Xj18igf
 RfRAtWCkEfbxOOpoTvNhNFAfk4uMJbG92MZu1G2whVmOMsSQCA4ulnoD76nNokYj3HiRK35LO
 al6KfbzmXcRzT3fsRxK5F3cRQryf8tn4G3s20bx0nlMkezo9QqgIT3HMjbXmcn8w0KVuzrytv
 FEEkK9bbXurFZeIHnUh4Uo71pP5eai5TFsy67BLKh8QOHuwWMXWkDwFM6zMi20HPdn5DisOSS
 uz6QwSjHM/psZqz4Z0Faw4dRBcAMlNei59OFflZKXsbCuHbpu9P8FsUS+N2tforFrlPtuebWj
 ttKpyLhsZEqKCdMoylLeSTlem8sRpVyhmYNAv04IiznXp5BA7UyCftcYvedXcz+/yvQf3K2ID
 aOt8LoAKo8W/+k4F52LM6ZH4M7iZoG4FpZ1biSiZ9XgZaKqOKN9M72P6T4Oymi2qFTClDAP6Q
 FmwjaPLLBCdoOMU+22Pw5+vYWiXECRqBN8nKg1FPqLqA7AdqY2SdQkTuLoLHrCv2lGEshCSdv
 LSkdQXf3o/w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_235440_145102_64FF0EB3 
X-CRM114-Status: UNSURE (   9.80  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ryan Grachek <ryan@edited.us>,
 Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org,
 Michal Simek <michal.simek@xilinx.com>, "Reizer, Eyal" <eyalr@ti.com>,
 John Stultz <john.stultz@linaro.org>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Somewhere along recent changes to power control of the wl1835, power-on
became very unreliable on the hikey, failing like this:

wl1271_sdio: probe of mmc2:0001:1 failed with error -16
wl1271_sdio: probe of mmc2:0001:2 failed with error -16

After playing with some dt parameters and comparing to other users of
this chip, it turned out we need some power-on delay to make things
stable again. In contrast to those other users which define 200 ms,
Ultra96 is already happy with 10 ms.

Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 13a0a028df98..e5699d0d91e4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -101,6 +101,7 @@
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
+		post-power-on-delay-ms = <10>;
 	};
 };

--
2.16.4

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
