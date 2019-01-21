Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F97C31D64
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5780121773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XOgzCVlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5780121773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=EEkBeEATbjyaumTRSI9qvoNcq4R0AwD3KBW9xVghFHQ=; b=XOg
	zCVlSaxlvHsryIgpSVvUFvOYSowNyP2kJaHalyxmfOJa3p0b79OoNyryRsIWPly0HdjgjPIsk+6Wl
	YW2jvHTwq/lCaECXHUwIF8J68VUGEjPvkU13+1k4knBjUOdSmHeq5RODk5nruaKy7x68YfMZaNwgi
	F8sHkGDaxRSddB6pZdCI7GnqAmH6Oz7DYaJQzZZUGIwSnT+rAPkezRpQb8OPsGtZwLV8zY3FbNfvz
	imK9DLJERlAah7rbdF0DXkl3RFLaJE0SOyIJgLY055Bzzk1iSF+psbbQedlXtXwQmbRcQCG11P1TR
	CfLkADSBaKBH4pj2VIWJDrww+6Xiojg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glTkf-000640-Lr; Mon, 21 Jan 2019 07:12:09 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glTkS-0005rS-1Q
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:11:57 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3KkM-1hCSmM3IJO-010K48; Mon, 21 Jan 2019 08:11:48 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH RFC V2 0/4] pinctrl: bcm2835: improve libgpiod output
Date: Mon, 21 Jan 2019 08:11:21 +0100
Message-Id: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:swD9O/FAdHMVQysSDS5xSlR1YwOTKjsrdf5PfNnbeJVCMhpu9XG
 j7/GJxA0UG2dOmahq61ljkHcUBrdAYaNbWc5bz9SCXoLh7BEVUIDaJhfOw3YE2DnXkdfPs1
 PtQSuPZopVt6+svAn/93157c/3sOpGxmx4gbztFyIJY53rtr7k3PJQS6Uqu1ywsD1SIxXua
 ywquXVW3HOoS5Bn81P5oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JXCZiFxWKBo=:il0QDtkEtMD6JNkFJkK+CZ
 mUO5ESq6gIr0czNYfANvJRI070nlXHH3GEL2kCDxQecUVzxUwJXgMnzrYYzCPM/49/VNuL0j3
 5ggHvTFSLb7oeJdHjXNcItvo2rZBwnIveYJKPKzyY8IFvmNaAyuAuOODLw5whwedG+n1XPlmI
 dhKZWJI/lHPGJbDisBOcbgYcCpdmy5LOPv7yIxZxu3W98OR+5KU8L+UTIq205qqpcvpRM+pEp
 9Mh8tOfk24AxqUwovu8gGDCJiHcicFRY7kknA53xABwg+CipKTd7k2GOw8YpgwZxFTekhaHPk
 9VpGfqy0wN67HRPbs0O/ZuHxNB9lvtwQ4HtHuJ0QXzqRimq4htbnEHWb2PjD5KeEx+3coefxB
 zFDeXsBFI1iNCCMDn8Wt0YYF3hNiPHITljHewYwFj5bFR0eRWDCLScSYyeNErjMLic+dsc1KM
 rx1hu4iVx6DjMTQymL2rT6dG+evRKXGQUWmUwhvIwCR0stLnyT9sT8R3Co6D1ZdaGIvRjpBHk
 hisqDKAmI7KxMoonLZfvUD9CEFTPQt8jpP9oeJkUqoxgxByLXYo5U28yvvNwD3MyFKlXiETpg
 OvujUU3aM/Stm8GA5rStfdHqH33NSnTGkohazbslHDUNHLinFpRjNs4LIpCuR8oTBQD4pCveu
 /Xlfi3fu3LfJnZMPOGQRs+s+YCeBFSDeUPbtaM/AfwpQIUTLswpQ34adWVMnolOopxQLcleyv
 bSMYCLUuUdbAP5g5iJjEt0EQFzstMa1qf0eZ8sbgdaaJKBk04aCDRhSdVm0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_231156_374923_38654B78 
X-CRM114-Status: UNSURE (   9.20  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-gpio@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Based on a recent discussion [1],[2] about the unexpected output of gpioinfo
this patch series tries to improve the situation. Patches 1-3 are specific
changes for bcm2835 while the last one is the intended improvement for gpiolib.

Changes in V2:
- take strict mode into account as suggested by Linus
- add bcm2835 specific changes

[1] - https://marc.info/?l=linux-gpio&m=154716249606544
[2] - https://marc.info/?l=linux-gpio&m=154747265118765

Stefan Wahren (4):
  pinctrl: bcm2835: declare pin config as generic
  pinctrl: bcm2835: Direct GPIO config changes to generic pinctrl
  pinctrl: bcm2835: activate strict mux mode
  gpiolib: Take MUX usage into account

 drivers/gpio/gpiolib.c                |  3 ++-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c |  5 ++++-
 drivers/pinctrl/core.c                | 23 +++++++++++++++++++++++
 drivers/pinctrl/pinmux.c              | 18 ++++++++++++++++++
 drivers/pinctrl/pinmux.h              |  7 +++++++
 include/linux/pinctrl/consumer.h      |  6 ++++++
 6 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
