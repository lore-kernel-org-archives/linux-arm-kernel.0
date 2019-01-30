Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AB0C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:27:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FE82175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U9mA3hPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FE82175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gasmgL3u3ZpW+9TQfmN31I+jKQlMmXRUYvb4ZsU+DfE=; b=U9mA3hPYOfHiyB
	6hofwFHRVlNydwypI894ZtmL4Z+Nkw4b15rQ4OVY/MZUFZwtaORhxN6t1HZoRYzHCW1qloqvvDoxE
	Zn9XOtyjBCKA4G7B4PqBGNrRfNVsZJscwr22Ma1n7giI8UaMiD3fyS6phLR2o0fvh23T6nkFEPtDZ
	WfYOOLAh3xZfePKYqYZkklZgbKp1Dt2fI92ycSZPYMZtLZEdtxuus/iC4d3Pqzql0NTfvNsohToHD
	N3knyHpwj2YpgxEyYrzLUUql9R3O1fPTFKPYoSBKgBgNa/h83p3p7k/fJ845SLbEdrNwozAA5EfeO
	DVpJCkfflKIDe8sL5d2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gon5R-0008Rc-LG; Wed, 30 Jan 2019 10:27:17 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gon5O-0008RH-Ot
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:27:16 +0000
Received: by mail-qt1-f194.google.com with SMTP id n32so25558104qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J3gLeQ+XlbHcVxbJb83vwPT18p1conIS2TS7+iF2dy0=;
 b=smxzoTSbgz4JyHtFVA6GwnP2bhF3/qOhHZAtyC6iQP3dQ2WftJKnoLCwPKr9weIeKY
 CMsT0M1ZrRMiSJ1sxTuZQI12Tr3iYu1h3cqSFc7XimZi7sfogaJYhXaY3g6SUKv9YRcF
 xSmUJVH/4MbfxR4mFIfg9QsISw7UwQAgxbDZOu5oWwRZet/QuHqwFge19Gv3SumO2ewO
 sHDa4A9515IUrz9J6YmSTaUtCoOkxIjxjszRUwa8GzI1mDfr6POECxO8hOVMT9YB9iRP
 Iv32FRfSgZGKt2susa5uaTeOH0ByX7rvoRfZ3zmhBIHrE8GgSg/w6k9I77CwnGoH4MYJ
 zEYQ==
X-Gm-Message-State: AJcUukd2MynSzlZqhgq+QP4fRBvZHbGV0/iGW592x5mY3Z2cec5JDg3Y
 lpAm3LECS1ke9qrd5qXvNY84clBQtYmgB/cvUXa59g==
X-Google-Smtp-Source: ALg8bN6BPlAQlKBEtuMrkewhPeVz3B1XuSk9f1wYGLC68fiRdtJIcU/k78/O5OWZWzfQSaFiFc3X7TaMXJF4wsoN1jw=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr29860454qta.152.1548844033402; 
 Wed, 30 Jan 2019 02:27:13 -0800 (PST)
MIME-Version: 1.0
References: <E1gn7nr-0000Pm-39@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1gn7nr-0000Pm-39@rmk-PC.armlinux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:26:57 +0100
Message-ID: <CAK8P3a16weCOvvXTKFk7YNMz-q4GoP3Pc0Rm0us=60Lg=bpJMw@mail.gmail.com>
Subject: Re: [PATCH] ARM: iop32x/n2100: fix PCI IRQ mapping
To: Russell King <rmk+kernel@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_022714_804501_2B3250C7 
X-CRM114-Status: UNSURE (   9.16  )
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

On Fri, Jan 25, 2019 at 9:10 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
>
> Booting 4.20 on a TheCUS N2100 results in a kernel oops while probing
> PCI, due to n2100_pci_map_irq() having been discarded during boot.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> I can't find a maintainer for iop32x anymore, so sending to arm-soc.

Applied to arm/fixes, and marked as Cc:stable for backports, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
