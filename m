Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D362C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:38:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FCF2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dF9aLibl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FCF2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WnqOIofV8l42icxSztB1P7TJmnlJi3JRIw3pNP7xbnE=; b=dF9aLibln25dY3
	9o/TQyx54kxe1uG1d271Hwuoja65UPFxpSF6hSNeY2945Jgf4Sn1J1g8xgkMPZKrsYfm1x3GjzFYZ
	xArVm/sr3nJkwyfVjf7WZyRnonaVkhMtgCH+8oCTvbDTuJ0KBacZW5dt2ffi6ljifrhRsA2EHBEql
	v1irs5kNu4ujOhY/FKeQhsuq8NobD/4z64oFGMB7gkRAcdxQagQcAqohI9/u+oTXTAICcRcFJz0Ie
	YIi2lQQDjR/bQnqqxcFBzorD0qwlmjGk48xKhzcrufOskt1TFUYpfyIaVH3OVBgYAjm2kaG/KY4E3
	sPhCoQBVDtdv/FKrARmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxYl-0004yP-Q5; Wed, 30 Jan 2019 21:38:15 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxYi-0004y5-Kg
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:38:14 +0000
Received: by mail-qt1-f195.google.com with SMTP id n32so1241719qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 13:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vBTlCiUrmRZLBfvnpISl61OodV5hK7c3EQkJPpAUHIg=;
 b=DNYuyX5UqNHuZLUSvt+RC6ccf+DOeyoVLeN2DCWFfvRLHwBaLoNdhUui+xqaBv66g7
 c1p82m5/g8tA1Ead/OpQ9asyGu/Nnspmyl9iI/zeuU/SazShe+EfUvT7/JQWQck29f/G
 UgXvE/BhDXPLf8eEVOR/6oKDSiObsbBYqLwT0XHIQCBR72g+MOznW1gB1+DwigI60VwH
 2PG0zUfEmQvswLydOFKDg1dvYFjGnaH4uT8NZhBJQJbDM+ry3TItc0jxlsjCtwYvdWhU
 b2BXIyYXGjXV1/zWzIHYff+V1x5r+G0kMqAommwNRvOGVBzstyIzCYKkSsbh0Ehf3DP8
 Nb3w==
X-Gm-Message-State: AJcUukdVuK9Ju0IOSjblxK91MOem7mQVnN0xiuem0mvW94Q23fcYVzhx
 b1K1A1OC4uOflji7u2kJKKxgLFPMsNrhM2JqtxE=
X-Google-Smtp-Source: ALg8bN5e3598NcHcgMJ059xpeYxnjvb5xhJ9SpV12TgcSzNcWDofpzXTA6YreogIuJUASec2qw2kolTP/G0rSxsV1KI=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr31125340qtr.319.1548884291725; 
 Wed, 30 Jan 2019 13:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20190130165319.GA19556@e107155-lin>
In-Reply-To: <20190130165319.GA19556@e107155-lin>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 22:37:55 +0100
Message-ID: <CAK8P3a25DhN42VtO-o2ji_kMZCzQ2=+E65ADJzhY9skU78tnpQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: juno/fast models: updates for v5.1
To: Sudeep Holla <sudeep.holla@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_133812_673584_59B026D5 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Kevin Hilman <khilman@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 ARM SoC Team <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 ALKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 5:53 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/juno-updates-5.1
>
> for you to fetch changes up to 4daa001a17739947bf966e388e8a287db80d478b:
>
>   arm64: dts: juno: Add cpu dynamic-power-coefficient information (2019-01-29 15:31:37 +0000)
>
> ----------------------------------------------------------------
> ARMv8 Juno/fast models updates for v5.1
>
> 1. Support for Fixed Virtual Platforms(FVP) Base RevC model to enable
>    development of software around the new features available
>
> 2. Addition of dynamic-power-coefficient information for CPUs on Juno
>
> 3. Miscellaneous changes like re-ordering device nodes, using existing
>    macros for GIC flags in interrupt-maps and using list instead of
>    tuple(which is wrong but works as number of interrupt cells is 1)
>    for mmci interrupts
>
Pulled into arm/dt, thanks!

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
