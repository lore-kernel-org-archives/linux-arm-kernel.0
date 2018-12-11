Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7047EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:04:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E73320849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t2SWA3KP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVtx2jhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E73320849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=6aM4aY1T08ai9ZfGroFDY85d6e90Z//Gx9cXg6DY2gc=; b=t2S
	WA3KPgfUKiFDe6H31Rf/6r2THEFr6o+y8qQMcSWLggmxIsDBoiqQf5Y+16lzakaTzs7cyc5P3OYTH
	huxNq1nLgKeGLMqPZgplvlk78kUhW8n5se9RHqdfQQbggt8wa7BPqyrrapDi4XilyEwptH4yKLPbV
	BXufF0TJARf82sLsnU8yAsBF3ymdOt+VLTmcivCHS5WZRnCmWD+oyVlC+PqMV1mZ1T8F+mtE/HClV
	uBoazjh7g8dSQZfhl6C9iyGCXipSDW7vEbQeo6bn0QQ245p4FdfQ4wiFdUarNXgdZULb7+oGvhR1u
	ek1kSxJvW+FyV9JvC6AkBRSRyvjG7Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWglk-0008GK-CU; Tue, 11 Dec 2018 12:04:08 +0000
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWglh-0008Ft-8V
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 12:04:06 +0000
Received: by mail-yw1-xc41.google.com with SMTP id h32so5316983ywk.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 04:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=wnTTlHeuMUkuDlqqIhK/IXjL6memw6gITF+GO7SvONM=;
 b=eVtx2jhvYCBSAh47wkeTwLkF8JoSiMqF8MNvl8vsFY/0IcZeh7v09aDZHDxCSh21K4
 pIIwiIEf7Pq/cubC6ltug9PjcqQZVm4cjDxUhPW+1W24kHyA2ISIUluy3OCqLbt5Rp+e
 vjQY6ecKWJWqK119IurP0ZoYEC6Xr+G9RXeHjAldPzo7PLzqjkHOu/E9B2Ai+3KKyQ5E
 T/2/L3mot39WpZ7ecI2cWmicotTM1vYusAVddFIjoqtvWBQcDrLCvDbxZMY+CBZM34vW
 5aMjHWqykoUDiBgSmYL7rySN9HL8RDtOOaFCJojpgpMtE5gIjbIarj49PMsk26penMDc
 1Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wnTTlHeuMUkuDlqqIhK/IXjL6memw6gITF+GO7SvONM=;
 b=grZB52bHcuoC4AVQHFJ4+Fcz4MDF0J2/GU2mJBjvEMaQXfnyBLf2mVLD/li4bbLaMZ
 sgJ4yUuN/keHqYcooV9kYBpXKkINrWXLcl33D/63L34zUmRh1AB4EthBGUsJLJLDSbEV
 py5LscSyClQAxV4dIElq54GVXwLe0ZgFhHTjwha1G+nYyxdQoXsYvn9dPelkpnzMXqMq
 FMmYyU9V+6cqF7lEBT0IKTH4aLHl4pHyQb8ZDaWenk7MeezkqlvX8vvw+H0JfcprY79h
 8Kv2m1HbP6whj9j7CvsgiwSMnL3JmGOgifEfAUJEgVQBn6cbpdi0WQAOu/6XJmLHdYcD
 SoBw==
X-Gm-Message-State: AA+aEWZCd4ULKbOT/Y7VgxWEzH/ghWftsBOrKn5AJ15t0hxqRhGpwWgg
 7xPXRWvxtJGOFEw6JYGaMCI=
X-Google-Smtp-Source: AFSGD/WnbSpPh2NaZPMcVsExzD7xQJE9GzM6VO5YNv9sGP+SMQODR+eE3/lqv5GNbvgK3saTVYRkcw==
X-Received: by 2002:a81:2a55:: with SMTP id q82mr15225726ywq.311.1544529833053; 
 Tue, 11 Dec 2018 04:03:53 -0800 (PST)
Received: from fabio-Latitude-E5450.nxp.com ([177.221.114.206])
 by smtp.gmail.com with ESMTPSA id r20sm5536125ywa.13.2018.12.11.04.03.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 11 Dec 2018 04:03:52 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-cfu1: Run I2C0 at 400 kHz
Date: Tue, 11 Dec 2018 10:03:47 -0200
Message-Id: <1544529827-22842-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_040405_324892_53384598 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: andrew.smirnov@gmail.com, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org, cphealy@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

All the I2C devices connected to the I2C0 bus are capable of
running at 400kHz, so run it at a higher frequency.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-cfu1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index 7cdcc5f..445c7dc 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -207,7 +207,7 @@
 };
 
 &i2c0 {
-	clock-frequency = <100000>;
+	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0>;
 	status = "okay";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
