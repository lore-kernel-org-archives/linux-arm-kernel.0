Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D92DC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:25:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CE920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jizWVoaB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLGP7GIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CE920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cxZiwJ80YJZipHh/ggt/J8L5IrMcgH49J7DOdvRCHvk=; b=jizWVoaBOAuM15J0/7kQmAsD85
	snoK/aPry3+vLAetIUMDIc5hyfjTwXXPcq0Rw9QE8VLm6r1ubpV8Bz7qJgaca2OZ2ZKNHdOHiOXeV
	6pxzT8AolF6aiXLt4qi2q2oul6XCvlhv4i8ub92uF4b+DRjVG6lhzRb9Kfx91R5mE+5J84UIspehP
	hrKyrpi39jYDG/dhCHLY1jwb2tq2XWbpcl8bomL771WkHFpdtTeczivKisRI8hStdvqdF1YHQbYpi
	XZvtYLg0ZorpeirUo9wpQTzNH5MCTL82TqNTsYzPGWLuiDJ0YD5l2ck/iv+fOEobbhIB+/iMXiHFH
	asn+lD9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYIT-0002Xs-KG; Sun, 02 Dec 2018 20:24:57 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYHz-0001yD-Fo
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:28 +0000
Received: by mail-wm1-x341.google.com with SMTP id f81so1261655wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JOM18/2JI/XRqmtoCiSEfwWrBMkMvuRt2TRd7mJVRjI=;
 b=gLGP7GIaVXawVef7RXWc0UwDAdtOX2LMpmP0FaeI+zFg1FlFTMrX3BSsca8bF9a1CP
 htQqoMaoPCjg0ow8siWQ8AlVeUhYf2usojFv1/xQzM3HyX+NjzHZsRfzFLglgq8I6WhV
 Lu2aRcwTs9KJhFKZRXFLZPzOjpMmd3WRDRlfCKkfoJlQZEFbsHB0o1rwDzBBM5L/5lRI
 nwl0tOlgsAp6ghGbmgMpDdmxXDvNwqbpiTPT6hJbOl4Xw/v3TYEbJOQ2L/PswYpJaThS
 t6oRqUfzj03DphaveXQWD9ZJ/jIMeq3r9vF0xUQdlPd9Pln5O2oMXVipr+VHmXwG9bBf
 DJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JOM18/2JI/XRqmtoCiSEfwWrBMkMvuRt2TRd7mJVRjI=;
 b=l+hJTlhwDndLIX/qC03vsGRslB4GvblHURkfsHxcV9lE5lW9ebT+3tVGr5t7xrzHyK
 fHlfZKXrcNv7Kae3DWBWcWE58G+hInYpJmkgjuYApUQQ7nrql5bUVyJtEFIGpfu/MXuj
 WIFJ0z+ZoDpF3JbQWozGOt8eDh0qxb2Zbt9RRSUYKuDoed8VJYncpBvd93KCIFZ0WFkP
 ZtQ2NP/alooh7dCR6mF6MsMa0fQjldlT2u1Nx7QxnBAOobtoJTjqurL2844Em1vcVdFd
 X5+HoKSqmUvz3LEyh7vvm1bLG0+TWlnQrmf/JHEf/joT6y0q7pHHvfVk4EYLLIJBYjkb
 xEWg==
X-Gm-Message-State: AA+aEWYOVGNCIxZa4HS151vE6YfrK1s5pqh/n0aEEzJpP/Tp2IylqRki
 vCkL0PcL4892NHnSYzfvwgM=
X-Google-Smtp-Source: AFSGD/W7QX4J2lsvaA8NvQCdiuL27IRzzpKO6FhpOjj25mfcInqV8rBl40DwmYhmRdkims1AAu47BQ==
X-Received: by 2002:a1c:3e84:: with SMTP id
 l126-v6mr5546933wma.91.1543782264458; 
 Sun, 02 Dec 2018 12:24:24 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:23 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 08/17] dt-bindings: timer: Add Allwinner suniv timer
Date: Sun,  2 Dec 2018 23:23:42 +0300
Message-Id: <50f5d37e67d9aaf88c911aa614a7a520a9179996.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122427_551149_77FAD9C6 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add compatible string for Allwinner suniv timer which is similar to
sun4i timer.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
index 5c2e235..3da9d51 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
@@ -2,7 +2,9 @@ Allwinner A1X SoCs Timer Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-a10-timer"
+- compatible : should be one of the following:
+              "allwinner,sun4i-a10-timer"
+              "allwinner,suniv-f1c100s-timer"
 - reg : Specifies base physical address and size of the registers.
 - interrupts : The interrupt of the first timer
 - clocks: phandle to the source clock (usually a 24 MHz fixed clock)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
