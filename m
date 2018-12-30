Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92433C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:38:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6376D20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DvKrVfJL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="q1BmTV9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6376D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6gSIc21UmkxuojwJf1MGUhEdKwcIT8CXPFgu+v6I/kE=; b=DvKrVfJLimnh/3z8vIArB5N1qb
	aFVRStzQvk5jL4wel/XqzDfCn+P520To1wG+6AlkjqsFsQEqz8mfMHYnuyzuhmb20Me4+C1DnYBna
	FtNwFdw6l0oeYu929j42LdGHLF85WYQJWrtYYRVSMPUE26sKg7ME2oWWlK9uMpMXylY7UIGOiCeBC
	3ite6F78dukYuFXM07bNBMMDZBaUsPg9D13OQPPKz6ykagXLdK2H3F7iderFBc9Dy4itkFcdgWxtb
	LheNJ2CC2dpBfxMvA9Mzi+jeYsKiA6AnMVVlaUNm5sXlDCAFTKxD8hcbq0BjRYeu/vSwlNXBcv/b3
	Dvra5+kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdZQc-0001kq-5x; Sun, 30 Dec 2018 11:38:46 +0000
Received: from mout.web.de ([212.227.15.14])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdZQY-0001j6-Hj
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 11:38:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1546169894;
 bh=KXZfDwshm/FJGxu0rScN7SO1Em2NUsg9uBqnj5WMhyk=;
 h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
 b=q1BmTV9cWOxHkdOqhEgsas5LnJppa6rsnWVp8Be6BGogavKbkT8Xy+GPdDd1i/KwK
 ERRJk8mvF5nCR3qWI5bGQKiD4f4O1Ay132Bj3T1oIvm8CRizJjxne58DeS8d8FUwDh
 uYpolZS5gVu9kDI4WjdPxa0TTc09KkMBXqeCqdoM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.57.47]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M09z2-1hTBbV3YQG-00uEu1; Sun, 30
 Dec 2018 12:38:13 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Wei Xu <xuwei5@hisilicon.com>
From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] arm64: dts: hikey: Give wifi some time after power-on
Message-ID: <6ccac7db-3ab7-e396-90be-8681a8ee336b@web.de>
Date: Sun, 30 Dec 2018 12:38:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:un60TQF6vezWeQPfwPpE6ncRDplfXim5XjEifJSImVhG+OOJZWm
 J/drw4EU+b0NwRVG2NKNd8l7VKFnycpQXraoZqJogIDhovZrB0JM5MYxbXfGMc/MIxhXv5b
 UEXhqYGVfngD5dnGVl69rXEpYLHR5lEV3Yv8aKqrzm1iCM78XZzIO01DeEvse0m65i5zyg/
 DLJlDSTX2fosFaqQPsiLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l0OLpdLXsoE=:YFuKtvjd2x8LOTB2lDrwRi
 zITKbEjIDlDYgfyOnM1FpIclXjQuY/BwJ0or2pSPCMQUgG1R9rcuoEiIkK4ut+qx/EOpqDB8V
 1uC/nhIrJ5nsqRD5cyuM/R6xl/Lv/J9fhIELlOFjTSpxdyw/VvAlcrtEAesHTQZdIAtneTCqJ
 ln77a1tL4qGEiRwXll7XTQUGa5S6buPLe4+aSoYaZE97NRKsXZlvvon8RKOYk4NrW/JbIwbPR
 iZx7ACW9UjKuoO86LTkFVaArVKyH1I9CDVkXnfyN2Crp8WJZdQrOZ8+zGf46TGTB3WSxnGgXS
 CTIp8GJM5dx1JV1+Iq6A1tn2hOAHWXHRJ9k6hiv6ZbHQdYqmi8AKHYYYqtnGyS96d0RANMTLp
 dqIIByfg9A5g8oUkKgquVJVDsNq4VlR23YQ05SNxVHGe9aHTYKmJoJygfnhyzXamAv0oLk3wF
 sfBhQXulAUHKmp7zngF9hbb0BGCeWlBnkVEMt41dmpgedSw0PPJ27KzpGQBmpK3Ph7IKcmKaQ
 Lke68sCiJrpMxanu07rju7PNhs+9i78I0Rd3/UJ7WoPbpnv3vAKx0y+a4gs+afS2SE2/YTYoZ
 fW+6rk1+WdZGlxE03lDw8BGvCzenQsA/+Sx/8LD7NrUn+19vmvLdjDRgNF54GObPRrnMWU8mz
 kJ1VgQVnqHDg45t9+q2HYhIyUZaAilgRzmi6mITX1xT2q8jF3ZMVcQXzmYQZyzK+N3dFssAgn
 XdD0GKWyCTV/V7IOfX5T+oCeA6JODL5TOVS9+DgrAotFTxs7ojhZYF9ZggprT4el0YyeMeELK
 7p+9Tr0fx02RQ490l+Ntr1GAu3mx6bzYPLp7kbwcqN7XfWmFP0P71lZrnVU2sedsGImEc6LKy
 NUva2KEQ/n6B76pc7tTTOlbAqsc7WJU7TB54/Yze0qQUiwz2iZl0d4U640z3Yz
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_033842_924713_D646935D 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: linux-wireless@vger.kernel.org, "Reizer, Eyal" <eyalr@ti.com>,
 John Stultz <john.stultz@linaro.org>,
 Valentin Schneider <valentin.schneider@arm.com>, Ryan Grachek <ryan@edited.us>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Somewhere along recent changes to power control of the wl1835, power-on
became very unreliable on the hikey, failing like this:

wl1271_sdio: probe of mmc2:0001:1 failed with error -16
wl1271_sdio: probe of mmc2:0001:2 failed with error -16

After playing with some dt parameters and comparing to other users of
this chip, it turned out we need some power-on delay to make things
stable again. In contrast to those other users which define 200 ms, the
hikey is already very happy with 1 ms.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Tested with 4.19 and linus/master.

  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 +
  1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts 
b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index f4964bee6a1a..1e771bf201b9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -118,6 +118,7 @@
  		reset-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
  		clocks = <&pmic>;
  		clock-names = "ext_clock";
+		post-power-on-delay-ms = <1>;
  		power-off-delay-us = <10>;
  	};

-- 
2.16.4

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
