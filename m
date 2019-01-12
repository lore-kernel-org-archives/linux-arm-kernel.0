Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B22C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:02:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034E520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oiuA0b/Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwIbuyeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034E520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xFvkuF9qTG/OCmxgRe/AE9+Zi6DOB5Ne6IDTBK1Axd8=; b=oiuA0b/ZdUOjPA
	P7R5LHHT9EgSYmxh1D2o70akQFjUO9xaXeSMOILRoS0C18b1phTLP5RSOKSJLmsE3+vy3isxBcoSs
	TSVxaF+gumFJLSMeB3HmrHcvga8qpmv/66p4XgiO1uTOSkGgAKaRg3AQcL+c3oyWg9F8Zbd+HtpdB
	tCTVXHrh0meKiDy+Mw6l8TcPBsZ05R32O/AG1AcFdGt7Mr9n1qIFULDogvNNlSC8Nzwia4z+CN7AK
	fCkscvLovnKNfNzyrjHMm6VWqq+IeLNdKPmkVn0IjcdmGrP1IJAZbqHwkHsGexuedOk5V58cF2Os+
	brkc3eVetubG/qOcf6SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi7gN-0003Ec-Ra; Sat, 12 Jan 2019 01:01:51 +0000
Received: from mail-it1-x133.google.com ([2607:f8b0:4864:20::133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi7gK-0003EB-TJ
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 01:01:50 +0000
Received: by mail-it1-x133.google.com with SMTP id x124so3340353itd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=SIvrHus/HV5e2jXBHxFy3bnEECHkLQHT8AX2SuzNeg8=;
 b=XwIbuyeMmFUZqLTHpZEZhjti3xn3E91YUZol+PRI8yDkcif2ZVS1UEkgCHFTh5PQJF
 +5pwzOcDCE+1ycvi0i+IxR1BTJBda63PZI80xBPP7BRu7xT1+nJVR9wRQFZSTKWnfrIp
 bNyxEyfGgu9aXSH8efZ1RfbjkJjOKpQWGQb7YhGJTzHy3UkHDpem4x5oVvgMexi0sNaW
 3HqkeAGrWj+FmW4CynwOy4J3eaNp9YScOQLpNfA4wDLpYlqF5292esfR03o1ouqdCAj7
 EU84tmY6+qiTpqwwLal2Zz2Fmvq+yvLk+MHAza5v94LAtpMYIbYuGdy4Tk2apLCXwEop
 Z5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=SIvrHus/HV5e2jXBHxFy3bnEECHkLQHT8AX2SuzNeg8=;
 b=PiQA5pbJ2ZuXUHUkIlOxO8hH9BfrI/yRaY3fAminxb8s/jOTZUX4+GeDpIWxDYCgt4
 LZRkYmWe94254EH878QSF4KK5mSUHZfRJEPt+kIZt7KyShzrDjWUa1dOyXOYKfEjCtnH
 +H1B8BZnEBiDROvxhA301Qs2l2JzTQxxzuoJqCCyVQM3og+YvSBZB9dsm2tSPlFgfO9Y
 qFI8dVYcKiu2Fcxp6ZWwPZhdQBXcGA4wEomrbdAYFKocyAzLxzFegNQCZh3Px1PPw14h
 l5Opkdpe9D4xi06EhII0nqHF3wXU2hFDs34TEXxxE2eFoam0HixM44cd2wnxyefkKR8x
 BPcg==
X-Gm-Message-State: AJcUukeGVwX3xniJQfLN3Tjs/m3ygjWHFdzFF6Xu6BY/+2EKmtkI3WFJ
 IKAhUVFElYqhTiEsVPPzXCw=
X-Google-Smtp-Source: ALg8bN7jRcW4MNeuu7feFtD10RYzro4K2GpSnqwykrQFiW0pN2Uwx5JvIaiWYUzsVnF+OBD0n4f13g==
X-Received: by 2002:a02:ba01:: with SMTP id z1mr12092163jan.100.1547254906931; 
 Fri, 11 Jan 2019 17:01:46 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net.
 [75.70.96.103])
 by smtp.gmail.com with ESMTPSA id 195sm1854860itm.2.2019.01.11.17.01.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 17:01:46 -0800 (PST)
Date: Fri, 11 Jan 2019 18:01:39 -0700
From: Jeremy Fertic <jeremyfertic@gmail.com>
To: Stefan Agner <stefan@agner.ch>
Subject: ARM: config issue with ftrace function graph tracer
Message-ID: <20190112010139.GA5288@r2700x.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_170148_973879_14AC6BC4 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I'm having a problem with the ftrace function graph tracer on a 32 bit arm
board (orangepi pc). A bisect points to the following commit:

f9b58e8c7d03 ("ARM: 8800/1: use choice for kernel unwinders")

Before this commit, if I use sunxi_defconfig and then menuconfig to enable
FTRACE and FUNCTION_TRACER then the function graph tracer works. With this
commit, and as of v5.0-rc1, doing the same as above results in a broken
function graph tracer and often an oops as well. The commit introduces a
choice group and it looks like it should default to UNWINDER_FRAME_POINTER
if FUNCTION_GRAPH_TRACER is enabled. FUNCTION_GRAPH_TRACER is enabled by
default when I enable FUNCTION_TRACER but this has no effect on the choice.
The choice always defaults to the other option which is UNWINDER_ARM. If I
manually choose UNWINDER_FRAME_POINTER then the function graph tracer works
fine.

Any idea why the default behaviour has changed?

Thanks,
Jeremy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
