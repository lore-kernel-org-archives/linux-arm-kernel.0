Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F017AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:37:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF16D217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fNzn96Ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF16D217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intenta.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sPWnH9y3UuRpqOBRyvj5YzunkF2QpHcyRScmKJsjVWM=; b=fNzn96WstN9i1B
	iGQrnD1tKdIp/uckxSfGc7iif3Xf68c3TgswVnyJW4Pc3GGxNsy2psv/kwNyhf+fNWSmREbK0kssK
	zeLndWmJDWrS4hnmAbPjm6r+nS32ZgbvOGXOaghBiaT+1lyF3F4lu7do90zHcuoxA03M3NM2dm56v
	Os2+xWVuH6TZ/ZnYNHNf26cdWiwnXPcBbDWSCI7TtFwAMYa8r3UJ9edwa43yq271pMqylu54DtsH4
	HFQTOu+dx7KbryzQ6p6sy/zuNvD6XXMRcBirBgR0/YepxqS6aplzomeMrlqAq18DZEJq6rnA7u+qA
	biej/UOkEFl7GRL4ewmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBoE-0002ap-Mo; Tue, 18 Dec 2018 09:37:02 +0000
Received: from mail.intenta.de ([178.249.25.132])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBoB-0002Or-2u
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:37:00 +0000
Received: from [10.10.16.42] (port=17605 helo=ICSMA001.intenta.de)
 by mail.intenta.de with esmtps (TLSv1.2:AES256-SHA:256)
 (Exim 4.82_1-5b7a7c0-XX) (envelope-from <Helmut.Grohne@intenta.de>)
 id 1gZBnk-0004ho-13; Tue, 18 Dec 2018 10:36:32 +0100
Received: from localhost (10.10.136.105) by ICSMA001.intenta.de (10.10.16.42)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 18 Dec 2018 10:36:32 +0100
X-CTCH-RefID: str=0001.0A0C0211.5C18BFA0.0054, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
Date: Tue, 18 Dec 2018 10:36:32 +0100
From: Helmut Grohne <helmut.grohne@intenta.de>
To: Ben Hutchings <ben@decadent.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 <linux-arm-kernel@lists.infradead.org>, Paul Durrant
 <paul.durrant@citrix.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>
Subject: ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
Message-ID: <20181218093630.io6p4ovl36hnxalk@laureti-dev>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [10.10.136.105]
X-ClientProxiedBy: ICSMA001.intenta.de (10.10.16.42) To ICSMA001.intenta.de
 (10.10.16.42)
X-EsetResult: clean, is OK
X-EsetId: 37303A298ED8D26262706B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_013659_287226_521BE0F5 
X-CRM114-Status: UNSURE (   4.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

During a compile test of v4.20-rc7 for armhf (cross build), I
encountered:

ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!

Some searching brought up c5157101e77 ("arm64: mm: Export
__sync_icache_dcache() for xen-privcmd"), which fixes a very similar
problem for arm64. Is that commit maybe also needed for arm?

Helmut

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
