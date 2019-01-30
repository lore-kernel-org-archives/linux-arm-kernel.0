Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FBFC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:56:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D792086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YB4aOtuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D792086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DhfMkS94cWvtg8HDmlADo8UQYTAHaUtCeSSObpSbNjg=; b=YB4aOtuoK6TGCf
	CPrXYjknw9VqsZGUiOw3L4tDT3nZ3AMK70c2ne8Go15o76zrSp58gmQcPYiZCrIbY/ScEuc/V5a2O
	FUbKkKtsPEUvy9lR3iNOK8Ilb5G2KD0XUoLV3+k422g3dWtWqMC5naX1a9HCuC3ZuIDHyOCRuD7Ee
	ys9GKIPXJvRahMsaX5QiHA7ndrATRyDo0wOd0KlnDPC39jYmdweeEv0xv0RD5/qy6gxySfWoU3URO
	gP9PYgotDR0jsEigOmNw2sS0bo+gu9e5seWiyORf89HBBAtU83yB41lVu81uOwkodtLrFtwU3Txv5
	c07rMh88Yl6H13qKmI3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1got9g-0006Zw-Mo; Wed, 30 Jan 2019 16:56:04 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1got9d-0006ZM-HK
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:56:02 +0000
Received: by mail-qt1-f194.google.com with SMTP id p17so258479qtl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H4c+fzEjWSqodPtPdwOq0Jl4jiAhWYR/qIasiDYwzgU=;
 b=kftCvXG10afm0FLLC005Z9Qn6DOVH7x9kYzHkcvw8dOasLqZPAAF7d8UQ3w7QXJtrU
 4xKDJhHVMxoQ/eN3t7UC9bZpnV7/Vc1poNiBJXB3/J9tpk7CTdVYY25tBVeTzgOR42fA
 Z1FRRyUX4sSbURIL674UI8gVhL6jssKPrFAMvpyyAYb7y+IX3kHXhHeKymTE0ufh0RKA
 1+z4JHeUUDJFDZcB1MkGBZSfbh/HlFLuu8MxsXXawLp3n7Gige6G+H/VjH3xC9hcGzdO
 zpsT89D0uktdg4grXpHfDSdgqEcpFpeqA2i4/jt46NMKVLy7k5YIeN7tRCnseLcUC8sW
 cWEQ==
X-Gm-Message-State: AJcUukflwzZvrr11QkrzrwNjdcDs/IWFUNs79tv5BPvDykTXubt+/eFs
 29dHcGIg+kEqFk2qNN+npTCHnFCsSDKHYOYnMhI=
X-Google-Smtp-Source: ALg8bN7l4KKjN+8fLSRfG7JJPUxK2m28Ma8DVQMfnroaor2HFON91xE5J7c6oMaK7G8iXrOGQCfBHJQWc+IqYd3fwFI=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr30185189qtr.319.1548867360651; 
 Wed, 30 Jan 2019 08:56:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548233325.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 17:55:44 +0100
Message-ID: <CAK8P3a0BxWZ=PWG4-m5a_XojKcFqVkrk1aoK6MyoNKhmZpa--g@mail.gmail.com>
Subject: Re: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v5.1
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_085601_568648_765FEB2F 
X-CRM114-Status: UNSURE (   9.99  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 4:12 PM Simon Horman <horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM64 based SoC DT updates for v5.1.
>
> I am sending this pull-request now as a number of patches
> have accumulated in this branch. I expect to send a follow-up
> pull-request closer to the usual rc6 timing.

Pulled into arm/dt, thanks for sending these early!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
