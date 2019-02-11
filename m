Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E65220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MQTGUE7Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQMjz2Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E65220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/GZ6xjgCbKDuhCHe+NuZZiy+LgD5AK6HjCpcL6RTenI=; b=MQTGUE7ZjhCmbcz5C3pFYOV2Zx
	ymfV2vA6xbroj91SrpN0TsMgWK9MpP70XmJMaNrdT67+3+1NRHdJSZQoJr8MMas8Zb+yZnYMTc4Fg
	EMeiKxlo6vQSaOGTj+ayxshvoacfRR1l16JgMvePsY3eNsx0dnWJh3BSoDe0/PLhgXob+QAUl9W3X
	WypRypDmn07hpEcBXFl53ucgzuUx07t8VJUD8S/VsAtkVndbtk543i26NlgVAj9lPOP3i7/2FQHsK
	OCQTUx8YjnpQ0bgotyugUYISceXJMU9QPTrxE6MHmbo+tjWZgWLfz/3ZiMIp7OmsbQGThlyRHXMXS
	fn3eqJkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7nH-00088a-JE; Mon, 11 Feb 2019 09:22:27 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7mf-0007Yl-Os
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:21:52 +0000
Received: by mail-wm1-x344.google.com with SMTP id v26so15695203wmh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 01:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KC/AZsTOApyaTqdtOdp5tkyz0s01W2GX9aJLAHDbvJE=;
 b=oQMjz2Ti6vIJSwIPb1JjTvnEkDvE4WmacA/olAy5EXdv1BJcFqSUV3fYWQ8Nm0gv+q
 2G7CvPwo1POSa/E/7vStj6zIC1YTnBhYvkJYh3CYbwoySIM/WvmLUfy9Wl031rQ+TBfJ
 GBZNAufAnUy0Sw9CJNjHfkbZeneUqwFBYP1IdTkGHYeJftcgGe6dzsJE02hHa27u/ZYE
 /EST1NN6r63Dmw72dWuC9GX5W2e3+F5eylGhlwx7wJ9TSu3OrD19ZHg3PQMeysV8w41J
 MLT4bDNGjEOkWMl2qzYfOgaHOh0rxd03lvBXjLyiV2BYDbsABkNHZ35BajRjC4ciQNeT
 8nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KC/AZsTOApyaTqdtOdp5tkyz0s01W2GX9aJLAHDbvJE=;
 b=hgtwxeFI4Fc1mvbF3Kq+stg5/1fwBjS9Ho6OQMRTaDTULIYYFVEnSoAapZCMJ3Dubm
 Q1wSWnK+zMfT1GRB5xUudjAwylvzqpy2wtwlU2JYiMndUrTk/7c5EY0FJrCMTb4SQBXr
 4yyY8COqZSnleH1ljKKFqXbi3q/msZDXejTGVcRCvlDmt2e8huqTf01ijvJyFYxQNz2r
 Vd0f5OTErfJiapy4ZoSELoVzC7AtvE1YN2E/7UHwv12KhgyIOIXnsb14V3jrc0Ohxq25
 Udwhkj5Dt4BJ+00syMX3eWX1oB2z0Cx8lUL0VhCEjqcIICyDSzhMwllkx1Wl394DBBqE
 BCjQ==
X-Gm-Message-State: AHQUAuazz2RsUTlp+Ml5kn/Ntb3O9lBuG0UykueXtBar/Ic+GjjmH/l0
 tfCFWjZZ7FaqpNfl9bhCi3g2wMqdWRs=
X-Google-Smtp-Source: AHgI3Iav4KUl6LXM67xdIp/EY3zzphMUhHg7AMKdPC5yWa7zgAoIgZMlhZkrFCBd4/uhYjyzZHPGcA==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr8322318wmc.0.1549876908205;
 Mon, 11 Feb 2019 01:21:48 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
 by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 11 Feb 2019 01:21:47 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 2/7] clocksource: sun4i: add a compatible for suniv
Date: Mon, 11 Feb 2019 12:21:08 +0300
Message-Id: <3de720ad1d2b47bf987fa56076d570de8043ed35.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_012150_047748_002FA5EB 
X-CRM114-Status: GOOD (  13.74  )
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
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The suniv (new F-series) chip has a timer with less functionality than
the A10 timer, e.g. it has only 3 channels.

Add a new compatible for it. As we didn't use the extra channels on A10
either now, the code needn't to be changed.

The suniv chip is based on ARM926EJ-S CPU, thus it has no architecture timer.

Register sun4i_timer as sched_clock on it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun4i.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index 6e0180a..65f38f6 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -186,7 +186,8 @@ static int __init sun4i_timer_init(struct device_node *node)
 	 */
 	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
 	    of_machine_is_compatible("allwinner,sun5i-a13") ||
-	    of_machine_is_compatible("allwinner,sun5i-a10s"))
+	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
+	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
 		sched_clock_register(sun4i_timer_sched_read, 32,
 				     timer_of_rate(&to));
 
@@ -218,3 +219,5 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
+		       sun4i_timer_init);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
