Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D606EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 12:42:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A380D2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 12:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jf784fGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A380D2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Ny+oC3gd+qYnFNYau/ia1OsXIO6E/WmCu69IwUP4Xo=; b=Jf784fGvSDNKO+
	pm1W+PrYEZjArhH5mlpICD2aBO1egg63VkteOPymO2dksSIc1NJ8Oj1kwUOq14EpZxc7WynzOQea0
	NvTsbILNhQZyOJzoStAA5KbTXoDJueGycGGSZlH4UdetuDPuebJm0UajXLBAUiWfQ8sK+Ztwx/Mbc
	099qSe1j10AmdadgUmY/e8qWi+OLaO4N8SWWmJfdP1mKJlWx+iTzbDmM7NSYAtC+/4tNGly6/Q7rI
	304bBOkeHFs8ZHhcWdIbfA2Ozncb80Qf4ExY2n/Ly33HbHlFrS0yCM6HcxOuUhx5f6tCu3+MAdsS+
	NdUMK3TloiJTdHKoJHuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY9Gp-0001Yw-VD; Sat, 15 Dec 2018 12:42:15 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY9Gk-0001Mt-SA
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 12:42:13 +0000
Received: by newverein.lst.de (Postfix, from userid 107)
 id 9E2E968DD2; Sat, 15 Dec 2018 13:41:53 +0100 (CET)
Received: from blackhole.lan (p5B33F2D3.dip0.t-ipconnect.de [91.51.242.211])
 by newverein.lst.de (Postfix) with ESMTPSA id 3653E68D7F;
 Sat, 15 Dec 2018 13:41:50 +0100 (CET)
Date: Sat, 15 Dec 2018 13:41:44 +0100
From: Torsten Duwe <duwe@lst.de>
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCH v5] arm64: implement ftrace with regs
Message-ID: <20181215134144.6b0cc45b@blackhole.lan>
In-Reply-To: <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
References: <20181130162015.83FE767357@newverein.lst.de>
 <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
 <20181214094714.GA30043@lst.de>
 <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
Organization: LST e.V.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_044211_677728_70A5857A 
X-CRM114-Status: UNSURE (   8.36  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, julien.thierry@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, takahiro.akashi@linaro.org,
 mingo@redhat.com, jpoimboe@redhat.com, live-patching@vger.kernel.org,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 14 Dec 2018 21:45:03 +0530
Amit Daniel Kachhap <amit.kachhap@arm.com> wrote:

> Sorry I didn't mention my environment. I am using 4.20-rc3 and it has
> all the above 8 extra patches
> mentioned by you.

So that should be fine.

> I read your change description in v3 patchset. You had mentioned there
> that graph caller
> is broken.

No, actually I thought I had fixed that for v4. Would you care to show
us an actual error message or some symptom?

	Torsten

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
