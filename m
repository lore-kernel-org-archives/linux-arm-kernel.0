Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6899C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A646F2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJq8kXYi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="0JUT7KTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A646F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GlSUI31IHuG+IK9ODlYs4XpFZptHTHjDfA5g3aAbJ1c=; b=XJq8kXYi4NJ9hQ
	8ki9TLTh+XZPkGwTrRF6N94+yohNw3mI6wmmTGsnyRiBKbJlVj9nP25jT0fb4aCi5A44HdHKaPNwN
	Sowdh/foFiUA6dO31oCr4tcwb1SG0PNPWMbllnuaQkePDgjvzib3dYppQtbJWblJLG+Yh/tfFX2zq
	l8TtSfI0R0nsMAUDJYrjAybDe7zcrtmPAfRDLrbB4dvXVlb81QHQlHDd7oWrj8QpzOeb+Q1Gumz6D
	QUytCHbKl53kzjeLAsYhWaB3AH9KwlDMmCPckkdrA6iUVs3koK+XRnCc+c0XICMbEwb9D/+P1tsDP
	GvvOk1KqOrlD+AO1f+EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZEL2-000563-Q2; Tue, 18 Dec 2018 12:19:04 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEKz-00053K-9w
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 12:19:02 +0000
Received: by mail-wr1-x442.google.com with SMTP id x10so15674704wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 04:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MoT/FUV/sLikcgl6YNjLcqACd1Fc/igbWdW4TaPEwEo=;
 b=0JUT7KTRdhIIRyC5BAkFfDVBMkIRNwd9KBDyV7NJFT+pgW93IFJwqsJbGRqwO1z4KA
 B82yNMijNIjE4cW4u9RmTfgoar878F3ah1xqMuVyUTfNXMufwzA+0TqZFRxl/mrgb8Hu
 Jg0GkX3yEtr/+9xGtOd3VpIzeIJDGvf1IgCMPKbchZMGT9VfGs3KOV0hce++PawrbdH2
 uVnUIvZkV4g66kD6h2Eb+qKEmj+2vBOtpK7X4jCoS2WnEWGCv4c4m+kSKo02hpYeroNA
 9L6E914HIlFbii9/XgREALFOQBVVsxkDMVIKZLH9G7E/TiNYRfAz2dzlWW2kJDKECxHi
 vdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=MoT/FUV/sLikcgl6YNjLcqACd1Fc/igbWdW4TaPEwEo=;
 b=Eq621yjC1jFBV8FAZ/8IG3o+AcsZJbnZMG0tkmUr7mezlDYOAg6q/Ry+fDw+iYN6if
 uuj+ILeODoTOejdP0oY8H5AUXqLu2JtIxxEIiofGHGOGXEeJcOakoUtPjDd3C/CVE9/N
 D0kDng4whw0KLmb+x1kI6niefFl9FwHKslr4P5WELKNW+BOLIJScQEiFfaymOU4g9evo
 h5+mN3gIj3M3LUyeswklAeSLg0u2lu84wORyAoW5PWPZMY5CzRXGYtaLxGoxjEsMLi/L
 RWms8G5SiCZhaLtltrsvVZp+KWcd9Xx5fYpll5EJm5QXpZs9CFRpzcmgbCC4ZxS6T/cZ
 hw1w==
X-Gm-Message-State: AA+aEWaKPZtdElBrzKYXKgehFLc1//L1bx7y/NfjUBLtb78I3ORIfzG1
 AJFSJ5pPXgADnmBm7Zv3gtpA+C4DJpq4wA==
X-Google-Smtp-Source: AFSGD/WzJIx/F5ImXjanNDKC1/agaTba7zOlC1+HRxpqHscnSoR5q2uk4WK2jLl/+5ymVn4UGTO8oQ==
X-Received: by 2002:a5d:5443:: with SMTP id w3mr13409725wrv.4.1545135527368;
 Tue, 18 Dec 2018 04:18:47 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id w18sm1945541wru.54.2018.12.18.04.18.46
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 04:18:46 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 0/4] serial: uartps: Driver updates
Date: Tue, 18 Dec 2018 13:18:38 +0100
Message-Id: <cover.1545135519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_041901_352919_FA8BA3A9 
X-CRM114-Status: GOOD (  10.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

I am sending 4 patches in series to fix some issues we found.
Patches were sent separately but I have been asked to send them in
serial that's why I am also adding cover letter to explain this v2
version.

Thanks,
Michal

Changes in v2:
- Change description based on request from Greg
- Fix Nava's email address to align with patch email address

Michal Simek (1):
  serial: uartps: Fix error path when alloc failed

Nava kishore Manne (1):
  serial: uartps: Fix interrupt mask issue to handle the RX interrupts
    properly

Shubhrajyoti Datta (2):
  serial: uartps: Add the device_init_wakeup
  serial: uartps: Check if the device is a console

 drivers/tty/serial/xilinx_uartps.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
