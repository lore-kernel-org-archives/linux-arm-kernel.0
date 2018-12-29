Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66721C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:09:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2490820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z22cUdt5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cHtQglq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2490820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=muoC9ewA/YRPyHqWnBi/lz55aMl7IjMWq3s3p6KJJDE=; b=Z22cUdt5H54h3/
	Q9/wH074USlVfwLnZ71/xUi5WIommXnltpfQLo9g5Z8HC8uWc+RTs6q1z6frn8BVwCs4WeKtKJ0XN
	ArpWJj9ADZbLfNj+wQLvneBrPQBicPzUpeIyGvYg3KKl9eDg3aJOPI1FzQsGRIOXHUmNHzdiZf/vT
	/7FFh8E8cWC0z1O44pf+XwsAOju2lwtiz6NSbLdevo1DzZLO/aIaXL5r6vYpiG83ZkbM8819G6LH6
	YtEfDQd8Cc5VZkmex9ZFwWAZytM8eL6mjh+8QccIHNOs7hGyDixrSGbLEK+CuSPVkhmPssPhF6hh/
	3GBl3BEwZNwX5cR/MFDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd2Bh-0003em-TE; Sat, 29 Dec 2018 00:09:09 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd2Bb-0003dF-Gk; Sat, 29 Dec 2018 00:09:05 +0000
Received: by mail-wm1-x342.google.com with SMTP id t200so8799801wmt.0;
 Fri, 28 Dec 2018 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h3edaX4wyMbrYE7r0apmKbA/nQOmneme80hZKJKOv7M=;
 b=cHtQglq872JWG+//GLzPKWmI/yZFH4ums72ISaehwqhmIwOdh/2BMtyEYmcO3R0QjP
 Fp1scW8NEAlyjRw8ueL8c5HuuCAXidAr3DB3XcYsJscc1OMQhu8ZPIpA8rkCScqbnaA7
 rH0z7g2LlJ2RcODLCO8fBAOuHlSwuyOnZPAyzdQT7IyG+Mrgcx48rTa7A2JNPWtNkqV/
 0FL5SSTfkNgBAtScw9JvfsCIwK29dAdB+unnyurHARxmyxq4P8X59oMJAWA3yY694F+Y
 SHAS07QfFcpgj42+E6Z5HExqsDQxKZUahx869rgDq2Ujm5A1C3tFLYX49gbLgijQ7hPf
 6l8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h3edaX4wyMbrYE7r0apmKbA/nQOmneme80hZKJKOv7M=;
 b=SWXc2ILB2CEuA23BZBAvYUo4quWFQzjWvPi15qgnKooogB/sfn0gbUYbm57COkBSnl
 p4y0X3x2M0F0fXZcNi/xfImBSVopqLnr4z1GuyPnmilKtRvAYn/OfBfzYCGmhUH4lI5K
 MJV/1DZZ73QWbgWUc9jOTPsg4UxDnJgc0gEfAlltXIsytPLxYMgn68tE7biZoYkC5tJb
 Cv9dFjSQ/qKjBwhV4QX3DYm9WYB6yC1CaFtn0X2kzipeLiN2NMpyhFeweBw6V6L2Gsaw
 aSWTSGzeGITMr8C6uaEb5sGx+pLh3k+KV+aDJPCmq1SlMlRd/H0qNTHoPXemAkIilI4v
 tZXw==
X-Gm-Message-State: AJcUukfWc+fSROkeRIX7NdZKtaDanRj2KiZeyynY4vJf6/5NXod8EJLK
 0ruHm/ytLgDN2uuncuJZeVQ=
X-Google-Smtp-Source: AFSGD/UKuU7V7yYzp2yKMH0U5RU8skBJKQhFBo82EC3l2ajkDUR2QSGq9iM1EgHkyD5oUsLxv9McPw==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr24498450wmd.79.1546042131071; 
 Fri, 28 Dec 2018 16:08:51 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7294600658C35E37AF585B6.dip0.t-ipconnect.de.
 [2003:dc:d729:4600:658c:35e3:7af5:85b6])
 by smtp.googlemail.com with ESMTPSA id f18sm24420570wrs.92.2018.12.28.16.08.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 16:08:50 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jianxin.pan@amlogic.com, linux-amlogic@lists.infradead.org,
 khilman@baylibre.com, ingrassia@epigenesys.com
Subject: [PATCH v2 0/1] Meson8b RGMII Ethernet pin cleanup
Date: Sat, 29 Dec 2018 01:08:28 +0100
Message-Id: <20181229000829.16571-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_160903_582426_FDDA50F9 
X-CRM114-Status: GOOD (  10.46  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linus.luessing@c0d3.blue, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Emiliano, Hi Linus, Hi Jianxin,

could you please test the patch from this series on your Odroid-C1?
I tested it on mine and Ethernet seems to be improve Ethernet transmit
speeds greatly (at the cost of a small drop in receive performance).

Jianxin, can you please give us the description for pin mux register 7
(PERIPHS_PIN_MUX_7) bits 22 and 23 on Meson8b (S805). The public
datasheet doesn't mention them so we're missing the name of the function
and the pin(s) which are controlled by each bit.


Changes since v1 at [0]:
- rebased so it applies on top of "ARM: dts: meson: meson8b: add the CPU
  OPP tables" which will be part of v4.20-rc1 once the arm-soc tree is
  merged into mainline
- updated patch description with more details


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-May/007274.html


Martin Blumenstingl (1):
  ARM: dts: meson8b: drop eth_txd0_1 and eth_txd1_1 from eth_rgmii_pins

 arch/arm/boot/dts/meson8b.dtsi | 2 --
 1 file changed, 2 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
