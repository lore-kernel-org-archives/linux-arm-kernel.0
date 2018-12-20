Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:33:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CAFF218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sId2+GtP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jetKypdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAFF218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lZrJaMPncr/uxLEx+hdHAWq+/yFWKNu1uHCH0Hywpqw=; b=sId2+GtP2rQrpd
	N+tjvpgVOZDKwgC2LLdbMU0+OFIHmopfEeUwpmO2Dg1Y4zfdrdcFOvhvWv6FvRtvX/3joZ5YSACXo
	TqEYJFRz0Tm7ws9tMmRPqfmNYnUozsuFj19e7iCetsv9nc1qrZ6reoQMzCgnzMjoeuTIlkvBZsY0K
	Tapr6rKkkQgSW0UHNHVdME85XD69eo9upcb0yV5Ksoe4xoVCk9pjiiePZH3aEW0KVUSJ/U3PZWKd6
	ZPlXjpOoJYO2TzUZ5hTGKZXa0PSwOxyH4wDardWGAnP2SWXLbKdkWqOGTj11u+3ZbtBW12sR2kS02
	59iufzM7ZX4jt7lmHUlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0KH-00068v-1t; Thu, 20 Dec 2018 15:33:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0KE-00067E-Ee
 for linux-arm-kernel@bombadil.infradead.org; Thu, 20 Dec 2018 15:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8HdLoo3XeoCvPN8Bky158htrrZYVtVxLY92UnXyV41Y=; b=jetKypdqPe2WJZ9DkH8eHwvkX
 TbAWTE/cXheKW5+oA5i9Ate16pj6ZV80gMF1zcOx7Hp/3V8X1pQ5GTl8Ot25YCaAklpgFgXCdrCmn
 24C7ZSfH9xq4l1+AU+HcyzxQgXOzGgwjLj8AhKTEeQAVzbxBLVW/HkB+fDfRqdS7VNhRdiP+BNZ7H
 Ya4/uaLthFMoTnyR2fp3yroBrB9fhW7fKiLgg86ZBogBruOTnFpQBNM/yBTYi4JurGjYD5sVeFHk+
 8ScGGy16QBi3cIPQs2QcZnBKWxfqbIcay3Gb45tXMvn9SeJUeK1ycGloKBW0TTDM9WhUW0mRWo/jA
 W/c4j8ULg==;
Received: from mail-qt1-f172.google.com ([209.85.160.172])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0KA-0005rE-NY
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:33:25 +0000
Received: by mail-qt1-f172.google.com with SMTP id l11so2250036qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8HdLoo3XeoCvPN8Bky158htrrZYVtVxLY92UnXyV41Y=;
 b=umNFPFCKpaKaemXxzLM69f9ME1YyWjkqQ/8QEwf/dXr2IC0L78EJAiUYsr7se8uOPR
 3aPUNyJSRw14qOYKgzQ8xmAeJ8B4OawObKM8hy3FgCfzb4O9krA1sZKUB37ul5JbYMT1
 SqPK6y6073aoxDeC5WncfT/QFHO4QdTJVF4+5pEOFih5hEzJPsdOP0YyJxwx7oqnQ1gK
 sNfid1xKq1u+faxRWjiTV3bXJ7QhO2lGExH+F3f/hSxnKEATrTq2gaJyeZeCLF2/z3Qz
 12hFO4s0ZKLaazRkMHLVCQrmcWUmGr19mmIYaeKmNDR1Oc2nL/oukdboDNRdy1OfAwnZ
 YeMA==
X-Gm-Message-State: AA+aEWa0rjyMMk8QbydRfnHyRRUb48QeWnxi1WsvSbe3Z7W1vLuSH4ZJ
 kdtx19eh7L6c0bfwti4k35wZq/ebNyRMrscO/Os=
X-Google-Smtp-Source: AFSGD/VdqRzwIflRyc0eoM4kCAhR9vzgo7EUOgmtXfeSatGZD7PE4JXag1PiJX7dzi4IoFAaaXzMpcXVTqY22J4E36k=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr27046518qta.152.1545319991096; 
 Thu, 20 Dec 2018 07:33:11 -0800 (PST)
MIME-Version: 1.0
References: <7d52530e-8dcf-a7b6-a758-19d398f472c0@monstr.eu>
In-Reply-To: <7d52530e-8dcf-a7b6-a758-19d398f472c0@monstr.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:32:54 +0100
Message-ID: <CAK8P3a1Q0za-=tCXrmZ2t=29Y1n6pP4Hv2ymj_uMygW9NiKLpA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: Xilinx changes for v5.0
To: Michal Simek <monstr@monstr.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_153322_756170_8CB1B873 
X-CRM114-Status: UNSURE (   8.15  )
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 4:29 PM Michal Simek <monstr@monstr.eu> wrote:
> ----------------------------------------------------------------
> arm: dts: zynq: DT changes for v5.0
>
> - Fix mmc node name

Pulled into next/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
