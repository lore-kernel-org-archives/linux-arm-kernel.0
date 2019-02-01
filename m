Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055DFC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:24:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC179218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ik3vqnv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC179218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XWdDfacvkHAxr2uRmJl4P2UvKo29M2yuosL8rJkn5Jw=; b=Ik3vqnv9sjTiY3W+qc3tgTSCTl
	8pujaytjLuy7yK3AJaQnuQaaYACO+DWagyniGRTKuUb2kM8qoMVAxitP0UT7cJjAUz6isAvqjWaKU
	nFzkGVu22xClmAB3/49UfP9dcHxFAosT8+RVXws/1OCS1QTAE//XYM5wpNyzr4vYznV1+sew4lv/q
	rN+Hd+kLcYTWZwTI7yaXdkUbaxU7vBOWm9Y0lLkuCVb6EG0GwGSmJZcFlgOIpPHeL1NlkRcvUUwjQ
	ndvfHqGmjXNP5ihswxNcB5H/z2ChZZCH7kRq0qnzTKBSZ5WmzLT6pEjB8rYzpa77G8Xu/pOIbQr5I
	xNyUiD4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpeQV-0003mf-Tu; Fri, 01 Feb 2019 19:24:35 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpeQP-0003kg-SI; Fri, 01 Feb 2019 19:24:31 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MvavG-1h6d0d0UgY-00sdwn; Fri, 01 Feb 2019 20:24:21 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: [GIT PULL 2/2] bcm2835-drivers-next-2019-02-01
Date: Fri,  1 Feb 2019 20:24:14 +0100
Message-Id: <1549049054-5460-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549049054-5460-1-git-send-email-stefan.wahren@i2se.com>
References: <1549049054-5460-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:Mv1akROEcQLLIC/psZSWykXnCjVfMVGx439DPVHG0QpUyjCMn5i
 u0qBRZI3fyCHk+Zg6D8GzKJWXKxUM+muuv0LY2gIx6J/fRksGOKm+DoIAzDaPtjwita4opI
 HKm8Zk2GqJD2hcLoRkArZGH6HkPEd0JJhB1K1eYdH/FTIcspnvjOr7tdXiWdHhlF3cRldLB
 N/BbJJJTSqaKn8fgh7ReQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J4lQDWa6V5Y=:3w+RmvfAAuIQimUcbZGp4w
 eSvCrMPPvPkrHkQ9Z9z9E6FLlyyqsEJ1YSfT08vyn9wasPfd4IiJBwD383Q6oTQn729PWHZkq
 qNJa5ITLQqT/FKKEhySOiaprO1j6Qb5EZpJf103SFqa92De0JvbTa3AWpjix0sgaqA9EPcBXs
 NpWyU5/JNh9E2xO2o/jyJSd0Ty2X+QiKMKcacNx3OS/XOEGTQTCfOTsvyuMNpMWUL56XGvrln
 Sabhhr/dyMZplmIKF5MX1Cq72jRExpeUv+ubtOouI3qnxaCJ5jVeG5SDarnSsl8mXPnu3ZwkE
 N2alyPfpWe9pimdrlVtR1x2G4r2lFc0wLlQrOfsPTp9S68SngGQLAd4j5CqtDIdWhkoJhngEp
 ji8AxhHzqw6i+LNPphlUzxO2pQS2kUC3SMQvubj2vBdTaQ82XenUB5avnOcQZPQc90FFZaFT7
 Fx+QWlKCFU1A3j6U3bLrgShtOEqGuiiFNHzjljBs5nZVbmEVeV0YXWiiL2cVj/uCby5grmXD8
 hAFDFHG/6/6sKdf5sm2OBMDvhpFbqLH92i+dorYcW1PCcUIJJoxt3xVM+4K1zprAm8MaPrOfh
 rn66tCaiybKVZBWr/QYgKKhbtugRzR0GgX9Vr4xKI5ysSn1ah6fYAu/UK+o6FuTax1VT25++T
 1FOSMtFldI5eWz/kKz3171zdSCe0jqV/QXAx8dfUI5tZiuLXuooO9fHz9gp01/VlIQVF+YfwL
 D5nhqEIvbczxGyponkVMiWlc67XDqxalI6XH3inwI0d8HHvUdigCFfrQsRg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_112430_247561_D5FEE6C8 
X-CRM114-Status: UNSURE (   9.96  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Florian,

The following changes since commit f494caa480f7089ff9bba16dd865e190cee7e545:

  soc: bcm: Make PM driver default for BCM2835 (2019-01-24 19:19:22 +0100)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-drivers-next-2019-02-01

for you to fetch changes up to e1dc2b2e1bef7237fd8fc055fe1ec2a6ff001f91:

  ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware. (2019-02-01 10:34:32 +0100)

----------------------------------------------------------------
This pull requests adds the missing devicetree parts for the
new BCM2835 PM driver which depends on the driver changes.

-------------------------------------------------

Eric Anholt (2):
      ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block. (v4)
      ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
