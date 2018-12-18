Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CCC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:20:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151B12080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e1S6TCmR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="CPuj/r/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151B12080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oRj8iXuc9d8aBMnGEQJektC1NtYD83Dbg0DoQ+3SwcE=; b=e1S6TCmRlqot5nTpB7DHd08N6D
	zpZyT9SNH1xB+xjf2ZjuEIu+d/HfHrm1azFHy2YZjJTq02hfxFHN9nGm/5eHEapbsVNAV6YTcvaF8
	BOKhHuQ374QquSJHSXUwb3IScsOJZzDTatztqg8lDeGFS01GyV3KxkWvRZ/TGnY8WbohZSj+HZqjf
	M1uN2uNVJJE8tALKlXqAtLwEKjHYnj23AAtVwLKddJy3Z/18RSOANTlibGfoDfnvBVc0JFeXlygkK
	gaQJkHdvZFNwJa0W7YtUUpuo+ncjfjKAlTNS2jZebHve9QOuwS6hfsLTLiMx/jqDk7LU/2yeMwpxg
	1/CZicdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZELq-0005pC-ED; Tue, 18 Dec 2018 12:19:54 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEL2-00053Y-RU
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 12:19:08 +0000
Received: by mail-wm1-x344.google.com with SMTP id b11so2388489wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 04:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=eSWAZ8hE+0QmxOSC1nocpx2/Vn+e5jpinCbecxT0A1U=;
 b=CPuj/r/i3UFd+YIrnxG0g630Kds/PAKQUZcebI8OCjummw+9fT9Cv8Q4tAn91hUzR+
 j1AsMVfOWONddLGNp6Ig3rGdBPrSSWShb86H15qWzlMyPWSfAW5pxwadN9/LdnLLGvAa
 LXU2XAqubaXg2La+Q1FMeCM8H4Q1MzdlpPQ+aKpk1Jv/8kgip+Ql8Sb4PjHvjGhzA48P
 Bux30y7bSPIxQJnf8jnLsQ2vst0DMSERSxV9n74WAb1+Binw1xBPJhy4rks+JufyOimA
 rceETvjlvJX7Extac0QySHselFY1jKEU5mR57JRcCQp2/PGFDYiTC0GVy4fJIqtBqZEV
 OOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:in-reply-to:references;
 bh=eSWAZ8hE+0QmxOSC1nocpx2/Vn+e5jpinCbecxT0A1U=;
 b=BsmWdOBvLQV5XLiL3Ixex/5JRY4/WvhLd0GzfjddPjt1fwxdJAl9xuR2JI6Z3COSii
 D8g7/SwHo04IKKxqWO+Bhd7aarhCbMqF6u4aS7HJFBKIkMLEacs3QWm6EU8Y2hxSUwQJ
 sussOCkMQBei6Belf3IWvAUwKehnBFg9YlZetqushvClBGxss/7LHnCiLZT3vW7ZduP8
 kt7ar6XetfKXDMVtvrKJVJNf+FQagRGz6IaPXiESzHtK5B1wSuAjPxkjd4VNjrrBVFi3
 7QsyPsBk5vXOqaMWML/kZ3HWQ3k7zxInqC4fY89wwVSljgNz9JZAmRv9Vx6Zyz9AWh4M
 kBLA==
X-Gm-Message-State: AA+aEWalH+z1jEHioNLGhkP8NWJWFjT8YPIPfVcSS/JYL57oGlqTjKn+
 dKpd9xQFao93Ff8Kw/CZhbXzjw==
X-Google-Smtp-Source: AFSGD/VsDGPBBDng6W5LtjkbuBDOleG+qY9bwFQ71ITJ8/+DcG9OwXkaK+TcXJneJQBU8Ao+XuFlpg==
X-Received: by 2002:a1c:6a16:: with SMTP id f22mr3014484wmc.25.1545135532031; 
 Tue, 18 Dec 2018 04:18:52 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id e19sm4269935wrc.25.2018.12.18.04.18.51
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 04:18:51 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 3/4] serial: uartps: Fix error path when alloc failed
Date: Tue, 18 Dec 2018 13:18:41 +0100
Message-Id: <2c90972b04a6f87100f6bcc4f6fa4630de025874.1545135519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_041905_019217_034F64B8 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When cdns_uart_console allocation failed there is a need to also clear
ID from ID list.

Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9cdc36be5b13..c6d38617d622 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1508,8 +1508,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	cdns_uart_console = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_console),
 					 GFP_KERNEL);
-	if (!cdns_uart_console)
-		return -ENOMEM;
+	if (!cdns_uart_console) {
+		rc = -ENOMEM;
+		goto err_out_id;
+	}
 
 	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
 		sizeof(cdns_uart_console->name));
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
