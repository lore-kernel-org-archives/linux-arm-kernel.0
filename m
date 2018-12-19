Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7503BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:40:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460AE217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LD2pEHzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460AE217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanmierlo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I9e0Te+MyeTXH0qoBSzMjGSyvimRVqyCgGVrQIXPGX0=; b=LD2pEHzPYzDHNdCAJzQS3Igyc
	Y6dYzetJC3nQc+WifxsHtWJp7DujkGuRVDJvnF9v/WbcOTjUDlRV0jR3t/nF0hT2RdaBzojPP4YSh
	DxZVR3PJLcKaBxCCBrpqYwZxikR9gbKv7R+KT4oCHX2P0wngOW6am7Qc9AdGKy/ho6JCnlDCkMLeG
	302u4uczo+QJLWlmZjkj3Tw5As7UDXwqEJCtxtsTs6nhOR1pTqUIOkJ5tM1+1aRXLcb46UUdyOiHp
	MAJThRevsrbroOb0uYw9QK6LMZ1nj3rAFc4WIwk3N8jaRi4m4OQkiliUfHQNiomGncg89gvi/S3Zy
	R/NMuP/eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZglk-0002T4-Lm; Wed, 19 Dec 2018 18:40:32 +0000
Received: from fieber.vanmierlo.com ([84.243.197.177]
 helo=kerio9.vanmierlo.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZglg-0002SZ-F6
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:40:30 +0000
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
 (authenticated user m.brock@vanmierlo.com)
 by kerio9.vanmierlo.com (Kerio Connect 9.2.7) with ESMTPA;
 Wed, 19 Dec 2018 19:40:01 +0100
MIME-Version: 1.0
Date: Wed, 19 Dec 2018 19:40:01 +0100
From: Maarten Brock <m.brock@vanmierlo.com>
To: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 0/4] serial: uartps: Driver updates
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
Message-ID: <06bcd18cb2e0e81d3051ef6305139d40@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_104028_647330_A517D307 
X-CRM114-Status: UNSURE (   6.02  )
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
Cc: monstr@monstr.eu, linux-serial-owner@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Michal,

On 2018-12-18 13:18, Michal Simek wrote:
> Hi,
> 
> I am sending 4 patches in series to fix some issues we found.
> Patches were sent separately but I have been asked to send them in
> serial that's why I am also adding cover letter to explain this v2
> version.
> 
> Thanks,
> Michal

I'm wondering why, when reading the linux-serial mailing list, I can 
only see this cover letter.
Are you perhaps using a different To/Cc for the actual patches? And if 
so, is that on purpose?

Kind regards,
Maarten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
