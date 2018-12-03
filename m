Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A77C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:59:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBD621473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ixahy00z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxBqpJAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBD621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5O50II1JVk6QBKQGLYk4W7qlKNoitpwGO5F5bfhpKzQ=; b=Ixa
	hy00z1llYkqAyh0itL8JdzbyufgS5gR4inO8sFMu0J7bZ1ttg0jLPKKQxCcRdfEiKpnx/i3Nma2UK
	nUmoIpQ7X71U6J+BKluU8/nsgggr1M/aS43H6m49MwbY1lh9OvTMFESFJzoKopttfOdSVF9LW1Cfj
	zV1C4nUVDARoD5sOTEiR0a9nK+JEU9f8RyvSB9bk9M8VDV3daZ4rRD0x7M4iO5B7iwuc1PeboQ3xn
	zBNXZCAOjN7Fdp7kxdBPlLOzbxAzZHaINZkFAy+gLV82lsH5gH1miRyqEfdr25U3IGSAa377BJC15
	lsDHet/yVq4HwuDKWjVlEc365n8S7Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTl11-0005HK-1F; Mon, 03 Dec 2018 09:59:47 +0000
Received: from mail-it1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTl0x-0005DF-NI
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:59:45 +0000
Received: by mail-it1-x12d.google.com with SMTP id h193so7627095ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=BsGebUY4KFvgkw+j8YwFqQgZqv52CPxQBMVi6Uhr8qQ=;
 b=cxBqpJAhd0In68A7mIslyyvPXsyzSr0hyyEPNZPfV+xNwTN8kbKB8rLBkHnLWFufHD
 Ed1JHB3eBUCB2nMgrBBYc7xc7MikhbQ1uIEnZHeJ20zwDQeOmV1Yu97o7iKYFSvIeLWr
 F5RNi9di2J1tggQBnNTBcVXBOD9WIhAauVoOi5wOAn4DdGTmFNv+pE3SCC1w8LDWiZ/H
 L5gpd8GMt7IMYaEERPxssHhZs+bDy46KudldXXItzejhonqExzXXRMjbwU4VMt0gZh3u
 UePFxBsab4xWFhpuVfYT5+DZEgvZX2YWx1R8CXnpp7BRvtAJnTL7puxEuYvUyo5Xsk5W
 OqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=BsGebUY4KFvgkw+j8YwFqQgZqv52CPxQBMVi6Uhr8qQ=;
 b=Gu+DGEMsB50KJXOZln1mIAMo2xQI1P5kVaV/jRxGqWKnlVrNwUZQ+XKW6LdM3+uG5f
 uzSdToK7XavPgspcmr1wv4q/7rJszH85AEPWvU4FrFlhkE/SGklzSkHTeHr5PxH2TlbR
 39rDOLDLDO0S3Ys7QcFSajtv3yh8yToSZEsRWZG3DehH8Qz8NAbIlAyOhEgCbhMtvAbN
 GOli1XKBg84MMl2U98LvUZgEk19SJZk7XD2KhxmjC61/jC79cd4cxaeyfwc+WV9d8H7r
 EiefBV6nNhSejWp5GAloMLFuiLK57/CrfVD8mt3w5r8INiH971/ujo4w8L0KasTFsxqB
 nZSw==
X-Gm-Message-State: AA+aEWZJD1VrzaQ1UOBy+JhmXFqWGHn4KGnLtHCWjJKoQgniH9csAJOb
 Ry4I39LOVh8eRZQ1t/ubMGAkixI6x0ccb1lLTXwS9DYB
X-Google-Smtp-Source: AFSGD/VtZvI4dgc1kw6aiHXNPHA0FAQFTlWqlUzq9RU06F68fQNq56d7UmFqhAyZ8ndljHI010Unxv0vU5SuUL7sZ/8=
X-Received: by 2002:a02:1217:: with SMTP id i23mr14306005jad.53.1543831172181; 
 Mon, 03 Dec 2018 01:59:32 -0800 (PST)
MIME-Version: 1.0
From: Roman Rozman <rozmanro@gmail.com>
Date: Mon, 3 Dec 2018 11:59:21 +0200
Message-ID: <CAEHvULkCgpHd-BKKbpqB=TPnOGX9i6OfgBO5kHPvt3PAeqZ5sw@mail.gmail.com>
Subject: Sfp PRESENT driver indication to user space
To: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_015943_781252_D1AB74C6 
X-CRM114-Status: UNSURE (   6.35  )
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

Hi all,

Would like to ask what is the best way to receive an indication in
user space upon SFP module INSERT/PRESENT.

I can't read the GPIO value because it says resource is busy.


THanks,

Roman.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
