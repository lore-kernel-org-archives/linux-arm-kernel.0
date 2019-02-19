Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05573C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:08:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C622147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dvf6JTrD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="p4vTiCpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C622147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uW9HgoJd5H/tmRWnvSuFStzb9RuEXk8OQUeAv9xvraw=; b=dvf6JTrDLb0G59
	hiUBv6wrlHEybORPlSLnQTzpGRvCXBmhbta9qHiORsssbRjdeOk39Q/bRS+Zvk2xW0fAGUXYG06er
	/DZwX7lqk31LbEJvH2X5vlJDMFayov+tJVp460dwN778zry29SAQciClsiSxyU/TjegidKkr5tPoo
	yLfr23aYQTgJkaTb1gndfqdw7o61McxVCefam9jEv9F/D07rgjqC60V0V9DNmzJSPdsHJZ4l5HTRS
	6vrssh0sA9+wMphuXUkws56AUMUaypCVtesTnCc9l5wH1AnPpUDWUsNqMhH2IA7FmV2P9mM9aqztO
	Hgr0dkeDKNA9OXHaDylQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwAkR-0006hO-Et; Tue, 19 Feb 2019 19:08:07 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwAkO-0006gz-0g
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 19:08:05 +0000
Received: by mail-qt1-x82a.google.com with SMTP id z39so24501266qtz.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 11:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9QPcI3GweBG60DYqTCubOmWKpX0tQQ8av80+o8uxtXA=;
 b=p4vTiCpPmU7ymlo09KPaulSxl0/v1dR4NQvP7wcOrL5uzyKuGObgsjSM7E387XsjL1
 v9e4ERqFrbhmQOrcW+nRPbHXbPFU4OwcSYUbvobb1h7jYOu+/8WWwS2ujsrugM0fsMd2
 82Ec09tcPk3XJl3S8n0g2jH+JG5mccwzQmAAELTxrIPr/ny3P485LNH7L/N5LChB7JtP
 mxEEfSAzejYIzBwDolizuAcIwmyaQVK/+F6m/F6QjfO0eu5MSTV9bzc6x29czWZMtVWs
 6CjujVc9JEmh3FBNP0DrtujlU/wgIInEL3C0vZEPaJnEsyFtwVXl0ahhmHQOwUPZjBSS
 RpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9QPcI3GweBG60DYqTCubOmWKpX0tQQ8av80+o8uxtXA=;
 b=imy8xebprlX5q+9dk99MiokIWs77LNP6qeQONPTD4EFttG8YXtcLFd9nYvgfFyB+yo
 IydZn8FP/ClzO9F/Qga6FH19h7kQJO75/4sf8qS62GsFMPtqbUCVujyPTtec006ozapf
 F47Tzk70a6b55ojSNG/tJm+YuzdrnzXkf0INxF9WNIW8jBufpGQINpB1zOHJpFcIgeGl
 x+J1ZvCQ0LUZP5Dtdlf2WHGKnfaDU1axM7JVx7VvBGiuimyvoXHl8yRICi7J2PWx/K4f
 QPlprGjmqSkZvf6wLLNpM+r+Q6YCNj9IJ7L/J3a3epzwvhgleJ0SJ4zJHyN76+2jS2DL
 JcZw==
X-Gm-Message-State: AHQUAubBOnG9yDkyU371B8bf/NZindlgZrMo5QvzFdDYj267AT47nTzi
 E6L7Q8gHVLvzx3/DBOZZZyfMhA==
X-Google-Smtp-Source: AHgI3IZev0j28Kk+5XEzkhzd/8ezk6MQoLwZQa1UIueAbBB2BhOzj+S/y20dchk3vwXcoHCLNStMoA==
X-Received: by 2002:aed:302f:: with SMTP id 44mr7158231qte.178.1550603282420; 
 Tue, 19 Feb 2019 11:08:02 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id n62sm9018306qkf.89.2019.02.19.11.08.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 11:08:01 -0800 (PST)
Message-ID: <1550603280.6911.43.camel@lca.pw>
Subject: Re: soft lockups with SLAB_CONSISTENCY_CHECKS + KASAN_SW_TAGS (was:
 livelock with KASAN_SW_TAGS)
From: Qian Cai <cai@lca.pw>
To: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 19 Feb 2019 14:08:00 -0500
In-Reply-To: <CAAeHK+yUQ0kZUspiFazjkFu7CRdaL_DZijUXD1po45gnGZkV3w@mail.gmail.com>
References: <7ec14ad5-8d64-b842-a819-9d57cc8495e2@lca.pw>
 <20190214163536.GB1825@fuggles.cambridge.arm.com>
 <50ef4f07-af09-5498-2bca-26ced76d9736@lca.pw>
 <20190214180125.GH2475@fuggles.cambridge.arm.com>
 <a31780dc-2fac-734e-61b8-8bdedaca2f05@lca.pw>
 <20190215142350.GA6299@fuggles.cambridge.arm.com>
 <CAAeHK+yUKS=5kMaug51ZyekQn8ee2pZQYChyxd_RqK-O6538dg@mail.gmail.com>
 <1550601754.6911.41.camel@lca.pw>
 <CAAeHK+yUQ0kZUspiFazjkFu7CRdaL_DZijUXD1po45gnGZkV3w@mail.gmail.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_110804_061222_9D655D86 
X-CRM114-Status: GOOD (  10.85  )
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
 Will Deacon <will.deacon@arm.com>, kasan-dev <kasan-dev@googlegroups.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-19 at 19:56 +0100, Andrey Konovalov wrote:
> Ah, so it doesn't lock, it's just very slow? memchr_inv() is the only
> caller of check_bytes8(), so we could remove instrumentation from the
> latter, and add one KASAN range check into the former. But I'd say
> this is the expected behavior, KASAN slows down stuff and I don't
> think it makes much sense to enable it together with other memory
> debugging options.
> 

Yes, just very slow.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
