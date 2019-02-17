Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E26C10F06
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE35021924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IimMNG0L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0rC7sn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE35021924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=OSNFhgGQPx+nfgsXzuatQFbGWe1widGeOEIfE6LdYtc=; b=Iim
	MNG0LbJ9WjXyg2/zLnyNZu7IkZdqwUe8LxvmaLRT6DJRqn8k4xylL4ZomECcehf+yfOtIqMmI16LS
	Dx0ApIQ6IHVGsTuhR8AqGCGaXbuVhZY00Vjt++QyOLhj3tnBp3nuDzzNVcbjrJvXZ9H6d3wAq+qHx
	Ja0gfv4856tKJUXZsMkXGugvFPx8skNZr4fnMzsaG2r1eJ9jOi4JlNQ/2Y/Ii4WHLn9n0xsBs2DSH
	aKihFizQqHvInBeomiNeHKz6YTL/tkl98F/ou4zVWvR9o1jsDeDjsXS+372SwtHCekEdH6Wj9uHw5
	BHPPzbC9Hx7f3y2EmlkvoZdd4vE7P0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvPE1-000275-WE; Sun, 17 Feb 2019 16:23:30 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvPDy-00026e-7C
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 16:23:27 +0000
Received: by mail-pf1-x444.google.com with SMTP id u6so7275350pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=044zzjCw4ZN/dcuprZ5Plp3/agK0+JZyI0LI9BwuQXc=;
 b=c0rC7sn55G5pkWZWJ90fEg7dGJpW0wMX52kjSbOWwzWh2o3d6B9iGQWAiif26GAUjL
 h+/RiEzCtGAoI3dw24BNm9I+2ZeCu8lJcdyK3rAlJin3OQpQK4AqBXw31moHEJO+M53U
 R8QBdI93DxMusxpw1a5V8+4FZmrxRIEMq/0rqtibN4JLVtiuxFJ6/C6BcOj/D8mvlzmU
 waVGTbHLZTbsYtfYG33m+gHiCLDnUbWEL3sgni0wVOBY6bQSjPwk3L6rfOnE19LwBboH
 6/CR1CZ7KMkdTSWTkrasG6ELT/Pjv/uQlINfuTUJt4AiH/Q877SbB0Km23s8PQ1A2nLx
 2+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=044zzjCw4ZN/dcuprZ5Plp3/agK0+JZyI0LI9BwuQXc=;
 b=AZ9XT5XvpZqFCsxqvCSnz1PxOtLbrfrJktUWFyXUSIXlktGdgReB2D6pO99WS3BH4I
 KKDWqVNe7LOFM3BJB3RAeIxRJdtUctpVCSMuwxebFAg1HP7ewCX44AlJf7QZbkNsANfH
 O40nEl+Y8RMUPE63upaBKFqOes2gof/vThWNB2HdvlB/bA2WLr2BhLH0m7ne0mhDQ3br
 eqa782hObhHRqS/ZbGqXcCCxt86KpRUqiKH3cIU7AqADaDFNzcseKLRww+LQy3TacbgY
 1eTJA1WFPnxke+zfEl8/6G+9I/WchRb2AYDUypTXXK+1XdyRo2feCPVujbU4H0Hp19VG
 BBzA==
X-Gm-Message-State: AHQUAuZIOWAVIACwcIXu1Qz90Dh5NpyYQKhP6JmPlJBjle47ywc/FN9U
 5iQwvwrW5HCD9jY/Jhe4JYg=
X-Google-Smtp-Source: AHgI3IYpoKb5kNwFZmr6W1HZ9CAPqVLaEiXfiSaBYzmfRJGqRx5Vaj5qdGUvnsET1Ijk/3DQjlwJGg==
X-Received: by 2002:a63:2141:: with SMTP id s1mr14431685pgm.363.1550420604516; 
 Sun, 17 Feb 2019 08:23:24 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id a24sm1624043pfn.85.2019.02.17.08.23.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 Feb 2019 08:23:23 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: srinivas.kandagatla@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 maxime.ripard@bootlin.com, wens@csie.org
Subject: [PATCH 0/5] nvmem: sunxi-sid: add SID controller support for H5 and H6
Date: Sun, 17 Feb 2019 11:23:11 -0500
Message-Id: <20190217162316.14111-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_082326_263990_9BAEC764 
X-CRM114-Status: UNSURE (   9.71  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add SID controller support for H5 and H6, and do some
cleanup without functional changes.

Yangtao Li (5):
  nvmem: sunxi-sid: fix wrong description in kernel doc
  nvmem: sunxi-sid: add support for H5's SID controller
  nvmem: sunxi-sid: add binding for H6's SID controller
  nvmem: sunxi-sid: add support for H6's SID controller
  nvmem: sunxi-sid: convert to SPDX license tags

 .../bindings/nvmem/allwinner,sunxi-sid.txt    |  3 ++-
 drivers/nvmem/sunxi_sid.c                     | 23 +++++++++++--------
 2 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
