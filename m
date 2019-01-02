Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17966C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:36:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0C6218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1C53SDQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaYeCb1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0C6218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=nngjHY+iqv19VsHVP63g/MWyOKAinjHISUzLb5ea50U=; b=F1C
	53SDQHqSZVJarKOcvvclGCKh+9yvvph/20jJly/2bBO19Ol4PWSkxYqGPf/rd9NJdHj1fOZz3hQ3z
	So0zZZlH1aSgY+yKQFyLHWloYHFesPu6QVa1evooVIQLz+TZpfbilA83mYFHpyI6lWvUTIRfDiXK3
	pog8nUKDeuniPWoelTJPTBO+kQRP/d7iZ0sl1TOx764GvlNiaNs3dX5s7LLcmNfcqbyRd3XiZStpq
	CaVSD455kCASRQYo7WQNTzTw5wCbOOx7zzObbeG8B9q2LI+daduTnvqyK3PIqVt5+gh3V9Yd2WFre
	k0rOiJ3VusGCitpn0nfU3eltUSCk8eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gemJM-0002Nw-W4; Wed, 02 Jan 2019 19:36:16 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gemJJ-0002N9-LK; Wed, 02 Jan 2019 19:36:15 +0000
Received: by mail-ed1-x542.google.com with SMTP id f23so27139732edb.3;
 Wed, 02 Jan 2019 11:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=r9AosAxJcFz5w/zKJPIe7Lr7elemtBB7jYeNGbWlqAU=;
 b=gaYeCb1vHD2WfKSEpklqyfZ/P7Rx+UI6xe/s2O6ImbVbQAXF/vYKTelSoCmzJ2A3Jf
 lRID6SfqSaxSXkE3mgHiyU4yaPQZ/tL8STK2YbMcl+yN8tfcxjvvQHlGpmYfwzPAcB10
 5WdWeBYSDONhxli5dlzoalGJFg6uy+bjpzubMNCrxW2KH8uX4M/KKYgLLMG3PjFqINDm
 2I0YXA/KhbkW69WPW4yzzA1q3P30CxMJFSdYudDZsq57nd+v/DuN9iKPtPqLyw7sI0gB
 HO4OakO14AlYJp54C+NFydy/FWXfi9aG0riJb4J6Vu1OAtp0BkXDfBrKiWKiRuPXCtdn
 +/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=r9AosAxJcFz5w/zKJPIe7Lr7elemtBB7jYeNGbWlqAU=;
 b=TtkTsAtmBlOSi5rCuPfSnv5BUVGv/umYGmOVJe9r3xQqbNQpi+Kfvhft2Y54giveqC
 R12LlBaNxHeYVYe2Mx5g45PCQ86MyK0rO3ikA6zkIsUnx5jjPJz19JJ5KUO+Ygir7lnB
 KyW4bPZMCt7IkbxdQYrDVID/d43FeflSnV4vFXU3r3VTs/BN9emG2v/gKOmGan7eMXsQ
 AYFpqdqVK9+r7VFA2AjzWtaHke0u26MgljhXi7eW2C0GpYJyyRc7bHE9/iLaVNUq5Xj8
 p42XoKz/CUJ5HS5cnDz7M5coVP48jCgYJWC/rgR8qjjBa9G8W5or15fKGwkEZmvMD/CP
 oDDw==
X-Gm-Message-State: AA+aEWaIx5+wFU2vWScbgscTqjsdyHZIjLLy6dK0qDpbJx9CrmGfx8Is
 7Q8IAtAR4W3opdovRTf+aOL/2gxq
X-Google-Smtp-Source: AFSGD/XFqFi/xtOVtYUN3w97hiQDH4uQg1uXbJOXvvl/VYxobqvzPZyCf+DN8KTxWhYXjhmhOHTuvA==
X-Received: by 2002:a50:cdd0:: with SMTP id h16mr41116215edj.151.1546457771048; 
 Wed, 02 Jan 2019 11:36:11 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id v20sm22326532edm.29.2019.01.02.11.36.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Jan 2019 11:36:10 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH] ARM: dts: rockchip: rk3188: remove qos_cif1
Date: Wed,  2 Jan 2019 20:35:52 +0100
Message-Id: <20190102193552.5853-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_113613_700620_F759229C 
X-CRM114-Status: GOOD (  10.43  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While the rk3066 does have 2 camera interfaces, the rk3188 does not, so
there also isn't a QoS block for that non-existing interface, so remove it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 4acb501dd..3ed49898f 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -719,7 +719,6 @@
 			pm_qos = <&qos_lcdc0>,
 				 <&qos_lcdc1>,
 				 <&qos_cif0>,
-				 <&qos_cif1>,
 				 <&qos_ipp>,
 				 <&qos_rga>;
 		};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
