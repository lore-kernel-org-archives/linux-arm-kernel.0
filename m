Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A80C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:15:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849942173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AJugCH9b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el3xz9iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849942173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EswQjGyTsTUVTUFQ9YccRc0BPAlbKCpHKHD6WL92JY4=; b=AJugCH9b9P0Qzu
	0MOB55qWtd7WeMSrlJXXBWY8GHqbNFrsXfsuh+SdAoDmbszXyfl+FMRfVxhFjoR79+lFtTqhyprYQ
	nOaH8I9TzhQvMB8/vDjXCqHCx7y8gDXzb1lhsTZ++jGjUigjb+2ZvlHnHe2DM4keQJvpkaSvDw4bo
	cCcFUbS6pO+bZYyoFK98/b62ilZpobnHep+Hyh3JHXXSBkhOT/roTdJKu9/pvbJsh9SmhlyN3NyO4
	/FBZA02eQGe5+DNcnBt/f5UjwTgtgPfiGlnm6sKgMCbm3EypnKB7TuFDzDJ/pvUFn7LpUSLXGGOvK
	zO7GQbk6bmpgTLvR2QiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggYUc-0001Im-VT; Mon, 07 Jan 2019 17:15:14 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggYUZ-0001I3-Bj
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 17:15:13 +0000
Received: by mail-pg1-x543.google.com with SMTP id c25so414923pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=x/QzmUyHJ6F27j7w4MWF17KHvW3Orfvcl1prMlNjj+8=;
 b=el3xz9iqaEkNf37pJLFnUYd+fMGNUQdfA54pCPwiKcmLJb6jSYvQTW1BldSNfp/Ry3
 qLCZr4mckISAinfRez97Ye1LmcpTWkAYrqPBVq9RCe/MDm2K8l/Jb7N8Xbm+fuDPTjLH
 +WepaiTP97E3Vaj9TxIDS5IS5h/9q+7HLwe9Q3UffQCuPNUl4pNSyCx37qSU0CL7WuBU
 IPwpxeTFO0L7PEHMNElk91JKGQ2gQ1nSxWJHWvFan5T4gxS5cU+/dYHQJ6UOjFTzjMEv
 RNI8Wl6LOAIoloSc8KDHD6I5LS7HKkavmQn7r/RCnE/60853gIrIhLQXhCIh2VcpqBEX
 dzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=x/QzmUyHJ6F27j7w4MWF17KHvW3Orfvcl1prMlNjj+8=;
 b=RCC5ud+QmRLIVParAGJVgkYBN6UB1g8LUBD4MpcRwdsZfJimdgC1dR/ZkOxbMiiuIS
 cQVMSNPF1BoAlj8iteJyGMgnPN4GyzhESiyBIf3Fh6KXYAssubaMDCxZipXdC/+8XPpy
 ete5Y/LnZ12N+mnz3f8iY0aqEzeG8QAfVFbOrs0o5KMcoCU8wLXl9CXsaWSPnBLqbF7G
 lwjffUEuLXUXwk1ILj7Mf2eUvfVWkTldt4mj3/qbV2G0RDO8ayCFgO4FX0dn+M4wPiAM
 qZN0I0fmbEHLJQAzoruK487p6pSiaq1KCUiHWu5pkaaCxx0EuFY7iKc85SujiKtB1Tcn
 v3wA==
X-Gm-Message-State: AA+aEWalurINrA2AHucyt2Om+RhU2T7WGDGnTdxjJDtZBAjYlYf9Oj0v
 Iz6dITWo4ND6mwsP3wf7rZI=
X-Google-Smtp-Source: ALg8bN4hrojHm1+xmTxfWxSQfh+U9iWFKTVjoMf6FAqzNGy+dstoHCZ9/iGQowKlRYVAMqi3ZfCenA==
X-Received: by 2002:a62:47d9:: with SMTP id p86mr62375182pfi.95.1546881310280; 
 Mon, 07 Jan 2019 09:15:10 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.19.175])
 by smtp.gmail.com with ESMTPSA id s190sm97380708pfb.103.2019.01.07.09.15.07
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 07 Jan 2019 09:15:08 -0800 (PST)
Date: Mon, 7 Jan 2019 22:49:08 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: linux@armlinux.org.uk, mchehab+samsung@kernel.org,
 linus.walleij@linaro.org, wsa@the-dreams.de
Subject: [PATCH] arm/mach-sa1100/simpad.c: Remove duplicate header
Message-ID: <20190107171908.GA5246@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_091511_411285_1FD8C820 
X-CRM114-Status: GOOD (  10.38  )
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
Cc: sabyasachi.linux@gmail.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, brajeswar.linux@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove linux/gpio/machine.h which is included more than once.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/mach-sa1100/simpad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 406487e..c7fb9a7 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -18,7 +18,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
 #include <linux/gpio/driver.h>
-#include <linux/gpio/machine.h>
 
 #include <mach/hardware.h>
 #include <asm/setup.h>
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
