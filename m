Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F46C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:59:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBC320820
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iT10sn7A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="l1MuJiXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBC320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=LujyloDck6fD5TJ8WD5GuNxIBC/93aW2caMHIYDCSYE=; b=iT1
	0sn7Aqt7dzzZ+1Y4I6VTWKaBC0l+qo6Th1tHFwME8zVD9nn28y1LKBrYTmRY0qViLN0mv/VlOBUh7
	rgFsJ0p7fzd2TRw94zyGx+gUHM9r6JKIX1LnzB+bOKPXTLAKfGBVJEkWdfxNGMqHcZYXUeCd9Clk+
	zyMBPaC1wS8lSRn/f6O/8YYgqKJGt58x+p0j9UC+ct5Wkupq44ZVb/McBNf3mq6uDaaSVsG/HftDJ
	dLTySfWV2+OT2GXDRIYXSvWRZa3y9jesCgGbLxhuMdBLJv/P718D9dNTETDEdmCWOsBVbXLsLppKY
	g3v8aC/MdzyHJxt9COS4EMTiQIH+kyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmwOD-0000tr-V6; Fri, 25 Jan 2019 07:59:02 +0000
Received: from conuserg-07.nifty.com ([210.131.2.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmwNK-0008Vl-NG
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:58:09 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x0P7vbeO015362;
 Fri, 25 Jan 2019 16:57:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0P7vbeO015362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1548403058;
 bh=bWGogFjdAjj5RntcVo7bEd6FALUn0TMsMmCN+Olj4yo=;
 h=From:To:Cc:Subject:Date:From;
 b=l1MuJiXFUIFlza3PP+5weoV+BVc2KSSt0yW/goI30hKYK11EamxvVPXgbOR7Dp1MC
 bp1AjEowo5k1qBksnR+ZI+T6KPdJGEzr8vsy0np1LTOvVIj849aDR77EG8hWBuF3f6
 W2vymEKv6dIHhUVoN4QkspuvD0Kw2iJurAcwyEDHKEUIBIFK/NpikCk0w8gf7exjif
 OgpKLpDZqEshxWTzQoG1Pv71dormKaPb9JVs731I4hMmRTpi9Ldr1JQrQXQQPfEpEs
 U4ptO+dEPQlL+n0soZpmzmbQfMf+DDHUTxR9VaOVbFgD4JOeEnWHH3uTQhoA2aH4Ua
 tsYhXASfRE8DA==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH 0/3] KVM: arm/arm64: trivial header path sanitization
Date: Fri, 25 Jan 2019 16:57:27 +0900
Message-Id: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_235806_991552_68D20C78 
X-CRM114-Status: UNSURE (   6.08  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

My main motivation is to get rid of crappy header search path manipulation
from Kbuild core.

Before that, I want to finish as many cleanup works as possible.

If you are interested in the big picture of this work,
the full patch set is available at:

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test



Masahiro Yamada (3):
  KVM: arm/arm64: fix TRACE_INCLUDE_PATH
  KVM: arm/arm64: remove -I. header search paths
  KVM: arm/arm64: prefix header search paths with $(srctree)/

 arch/arm/kvm/Makefile   | 5 ++---
 arch/arm64/kvm/Makefile | 4 +---
 virt/kvm/arm/trace.h    | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
