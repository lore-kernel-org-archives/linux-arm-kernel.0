Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A832C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CEF20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P43Bv/Wv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CEF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6zIivL22pA8JNUe2fCVMaGKScdGYAZa/noUcHk5wo+w=; b=P43Bv/WvMA9uTk
	tDErCheD/wUb5tqpHzSNXNx08UYSZFVEyJZvE2+9IQydVt29s7tIdLrhEa2RIn6MDBHKShVv/abDZ
	Oxjzot4mgn4+jFzL2VWgIYEWXcIpTdKBSE9+Y6o0clBa3KibQjZcSecG+RUb8cG/4BEVT9mu9Hl+e
	zAhBrLj8utspHH+QLjOEKsiwgAlZPcWocWSZLEt6SlpPwiKmzCmT7kODAyrpxDzFWqCAIyKdnJJv/
	iT/7cJcykJVvpPnmTEnS1KPbFcdtADTdVY4IoqmZJbnGe80EuevXapCArJ6aLPwHK3ToEdj50StRi
	aW6JPxHT41jxon1n/Gpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucqN-0002pd-Mm; Fri, 15 Feb 2019 12:43:51 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucqL-0002pM-Ir
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:43:50 +0000
Received: by mail-qt1-f196.google.com with SMTP id y4so10629903qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 04:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dR6VrQJ+63G0NUYBPYcNNh4WEoLRzg29zku9VMlYalY=;
 b=E/aqQtiinVWN4wThGgsdOPKPdhgElF0VC4thnma4Pyg7QKuNOpWsN2Wp19SlMWz5AS
 zB9gBRHJaBecH14Fjkpj4JZH9LB9e4eAkkxOtrY4F5xuIlzBP9ZqsUlqGiUZsoiW8ZlX
 iefzxE8J3TxamgHsFqnSlhjmoXqF9YTya5vVeUYyscZAWk7kfdymmHBGwiI6auq4uuMX
 p+GySjNNpUN2+9epBN/bHo/Lld+iMMSv1+N/vCb6gqsG52zYSrA43DqTAgG+RPjQkbG2
 BXxw79X+TLxBW+1P/JhqQflHRQTIj8bHMY8mvvDWbGzbB5tGR+1Rp67TvS+SJAFtqWPH
 VN/g==
X-Gm-Message-State: AHQUAuav0nPvMjhnbjUeP6misUTzsT5BOxB8ib+JMB1XypHOiqm0VGl2
 sKYtX3Uc/ALRQYvJCfewtFpmV0l/DxE5Ipt77J8=
X-Google-Smtp-Source: AHgI3IbVrsxEluC7QQe0XHcMpb/cmUwv2SwFhQfmxc2mueAJe2eYyfzm5X4cgc6ZJ9eU2wjWaO2r8HCYwXAR+9CVXhE=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr7429916qta.152.1550234628813; 
 Fri, 15 Feb 2019 04:43:48 -0800 (PST)
MIME-Version: 1.0
References: <20190203014400.GB22413@dragon>
In-Reply-To: <20190203014400.GB22413@dragon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 13:43:32 +0100
Message-ID: <CAK8P3a0MpSKqCiWN6HXg3TEiAkFAEWaUxaZNJV0RWr1k4LoPeg@mail.gmail.com>
Subject: Re: [GIT PULL] i.MX fixes for 5.0, 3rd round
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_044349_616034_5F2752F9 
X-CRM114-Status: UNSURE (   8.31  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 3, 2019 at 2:44 AM Shawn Guo <shawnguo@kernel.org> wrote:
> ----------------------------------------------------------------
> i.MX fixes for 5.0, 3rd round:
>
> It contains a fix for i.MX8MQ EVK board device tree, which makes the
> broken eMMC support work as expected.

Pulled into arm/fixes, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
