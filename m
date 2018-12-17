Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED647C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD0B20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nI7C6YkH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWFbCIMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD0B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=n3HXElbS7rNASZ49x+cqiuG1dhXs8ADfGzoYGqWWIQo=; b=nI7
	C6YkH1rCEAuqoFCMjz3UlVM5wxQQI8zsJ4jiLFO3k6few4ZmndyK4dpP4ZBBsXSsYrmV9oGggbDUt
	QnrU2EHX23anmc1xZY7eh6UaxRkZZMJ4Q1y3hfD1fSwmnd0hIBKwz22Y4YVA/2xu9QNKJAT1/1130
	jZbhEZdAnnhb79FB0hevunEARp5P2q70QtantQhAobakwihYbUw9QjZtscqq+69bP5WCZAzxatQy8
	SOAQBYY+9G1LGC251v3kRuLe/VTgsNfM7KYlZjsIcIx7KtiArnSgh4fP+zm4FA5jrMF+MI+IU5smu
	BAjE2TBx3e2zRiwGMKdrpcrSYCt62fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuPr-0000KA-LV; Mon, 17 Dec 2018 15:02:43 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuPX-0008Qg-BT
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:02:40 +0000
Received: by mail-ed1-x541.google.com with SMTP id x30so11022137edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 07:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=v24CCnKuqw2Y9MFhWwT9hmLhXnoHt8om6PjIfHIm4ao=;
 b=MWFbCIMeNFIZIetlasDHQFTXaH8zdmNJO/VAjSAS/0UrQDO5OBLyxf+yMMkKbnqSVC
 6gAH19EXWXrQBatk7BI3ss2tpqCjRxOf+oSqNA6iT3mVVuIxn2EmwpQuGl+I5YFNJz5w
 JJc3QRZ9yj0i8QfOYmMJGUi3uZd7zuHJRnnJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=v24CCnKuqw2Y9MFhWwT9hmLhXnoHt8om6PjIfHIm4ao=;
 b=Eq8Yghoq6ky75PXLvzgRUVvphXfBg1qlVZA1fqMmsbYMP6mRaM2aIlOFlFajuvXh1d
 cwMHkw2TH1kQa51+jHn2ay8aDBS/zec8ccU2wXny6hIcfqMy4ZBAb7X0z8+v+ZSTMUX6
 864H1xsYfQ9mI7/hRsi/KaVeW3kFZLTcBR9IPOV72fX5n7eM073y2bu9TVhDHX4VgUNH
 DACHnrugvyAo3V8TbEDh+NrH9gPoKWvP/m2ZRPpkyYbyPokl+B5+f6u13CnXpT+t+8tl
 kSQjef+y5n0jR7USBDKlLF8m8xFkwT3tIptY0nC8vVg4UY2ZutoW4DlvNK+hrsZfTUd3
 tz3A==
X-Gm-Message-State: AA+aEWZE/9brLiHYoDmYNfnGJpAHM/0T2FAdKXyRsoT7ou6uiToNIb1J
 GI8ds2dT4Y0px3SxTUZuBc7oG/3NjqQH2nSr
X-Google-Smtp-Source: AFSGD/Wghpwtj+JSviLso7o9erif1w97jVAHVl7u8TXCO5KtE0GMflvMxY05C4Oq5++Es31TjRuz+g==
X-Received: by 2002:a50:9153:: with SMTP id f19mr13319923eda.159.1545058930790; 
 Mon, 17 Dec 2018 07:02:10 -0800 (PST)
Received: from mba13.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl.
 [77.251.17.237])
 by smtp.gmail.com with ESMTPSA id s5-v6sm1904340eji.25.2018.12.17.07.02.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 07:02:10 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/2] arm64: kvm: cache ID register trapping
Date: Mon, 17 Dec 2018 16:02:03 +0100
Message-Id: <20181217150205.27981-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_070223_688955_1160FFE4 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: marc.zyngier@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 christoffer.dall@arm.com, Suzuki.Poulose@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While looking into whether we could report the cache geometry as 1 set
and 1 way so that the ARM kernel doesn't stall for 13 seconds at boot,
I noticed that we don't expose the sanitised version of CTR_EL0 to guests,
so I fixed that first (#1)

Since that gives us most of the groundwork for overriding the cache
geometry, it is a fairly trivial change (#2) to clear the set/way
fields in the CCSIDR register so that it describes 1 set and 1 way.

Notes:
- build tested only
- 64-bit hosts only.

Ard Biesheuvel (2):
  arm64: kvm: expose sanitised cache type register to guest
  arm64: kvm: describe data or unified caches as having 1 set and 1 way

 arch/arm64/include/asm/kvm_arm.h |  3 +-
 arch/arm64/include/asm/sysreg.h  |  1 +
 arch/arm64/kvm/sys_regs.c        | 74 +++++++++++++++++++-
 3 files changed, 75 insertions(+), 3 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
