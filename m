Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C76AC5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:43:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2ECB20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AUOHJSyv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Nj0hvXct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ECB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/jQw75Y76ekTG/QD7EPWT2jvJnezeF+nhY0H4kAEjj8=; b=AUOHJSyv4jEkwD
	VaN1PJeeUh9/CpHxuR9tJaYFYNflETEc67H4id0yIynRTOddu7E6Zht3XC3mpDWs2/viUkgaXI3S+
	fn92CUSXKV1UbOqfsdrHQbX+EOjVE96n+By2fAiX5dW8QCmPl5/zLjb5n5TvhC/ynIoSg+KWT6j4Z
	jBmMmPi333BBxibHSnW253ASYNBmEDMEDHiNyPWh1tKEuz/75cIYor2pieeZ5iAT4FfmIXxrbceyv
	1uBLxp5PzAfOKyV6dwyyRszYMoFwkdkXSgMz5eU6LlLRcavtvxHpaE0hD+ma7ApDw3Jrv9FNRlgS1
	vOEAimo6DHg6LhVYYSLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkdnl-0004u9-JI; Fri, 18 Jan 2019 23:43:53 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkdnh-0004sT-Al; Fri, 18 Jan 2019 23:43:50 +0000
Received: by mail-wr1-x442.google.com with SMTP id t27so17052313wra.6;
 Fri, 18 Jan 2019 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n5cr0JQQx+k6H3hLbyZqc4ntkq2OhwQVeP+zfLqqTw8=;
 b=Nj0hvXct8bvi6Jr4n2cwN/R+AebCvtPLOyp6z6dXoNUMlAc2P6jznbjgJbZEP/D2uN
 Ip2ZW2WWI7hNV/G+GpiBkrGD4DebjigEw/2j5jCYGm2aw8xuTUKz8d+hs/qYOpFHTvQF
 hdjP8nmV2Upp+R5m/NFdlYfTYRr5GW+2oEPGrGHPV9dwGOGDmhx85OVSAHKHW8iD+qx7
 IXhqW4aZ3t6C/tn1GowA7jcPEQTgcRGcd/6UyraiSb9Zw7Xpm492bEYkMgvJWUaf2uCI
 ADiYH29BDzPaIV7ti+mPRopLpnBf6FEuBCTEO1M7Qw8kKyg9mKz05OS0g0J02irB5cji
 RARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n5cr0JQQx+k6H3hLbyZqc4ntkq2OhwQVeP+zfLqqTw8=;
 b=IMJwNgWO0/0wZKWb7aNEEMah4Qf5AAeT+0Yg6SJuhmj4J0uSMsLh+QwSMv6b5korY2
 H+oEqCkSmcjBuYou0E5xib+k4HYGKpgSgXNBXuGKwHPmowDtX+F4RVpt5RyTU+UTGhii
 hN+eBEZ/VweiZKVLYHgQMDqtZeh4r3e1xPfoEyUyxQyHVpIM5aeMq8z2NrFlkPS9ls9b
 xt5cFIuFcZVbj0wJoYPBZhdVAVEfc33yEtJ8reaNxAx2E97q/e3qYURVWH6eSU1bsKi+
 StXqsgtEwGB4kfYHFhDJ01Oe5qYphqdmHLyIAGbW0VnuHyt752TgoPW1xf3RPIbhK7Uq
 V/MA==
X-Gm-Message-State: AJcUukfAbUh8mVqT6Mqzx7NsAJhE8J0s8YddM9pAxKOJPXnsfaePLM6B
 57E42Nw+JBGDjNovB9Mz1UiIKDl4
X-Google-Smtp-Source: ALg8bN4UxRWQ+4bOB7olbpWXPYI5xh1CP1WH80LY2M8YlFh2yx5YG/I4Aid4xxw7Cq5lVzpAxq5D4g==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr19878153wru.245.1547855026947; 
 Fri, 18 Jan 2019 15:43:46 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A810039E290CB771389D7.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:39e2:90cb:7713:89d7])
 by smtp.googlemail.com with ESMTPSA id j8sm108970024wmd.0.2019.01.18.15.43.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 15:43:46 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 0/3] ARM: dts: meson8b: ec100: improvements
Date: Sat, 19 Jan 2019 00:43:36 +0100
Message-Id: <20190118234339.16050-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_154349_402854_741CB4C3 
X-CRM114-Status: UNSURE (   8.71  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This brings various small improvements for the Endless Mini EC-100
board:
- the Ethernet PHY status is not polled anymore, instead interrupt
  support from the IP101GR PHY is used
- general update for the regulators which adds missing ones, links
  the parents correctly and adds some notes about the actual components
  on the board for anyone who is curious
- show the GPIO line names in debugfs for easier comparison of the GPIO
  definitions from the .dts and the schematics / vendor kernel sources

This applies on top of version 2 of my other patchset "ARM: dts: meson:
chip temperature (hwmon) support" from [0]


[0] https://patchwork.kernel.org/cover/10771753/


Martin Blumenstingl (3):
  ARM: dts: meson8b: ec100: enable the Ethernet PHY interrupt
  ARM: dts: meson8b: ec100: improve the description of the regulators
  ARM: dts: meson8b: ec100: add the GPIO line names

 arch/arm/boot/dts/meson8b-ec100.dts | 122 ++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
