Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB741C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906A2218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qOLaQ1A3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="etuK4Ac/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906A2218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:In-Reply-To:
	References:MIME-Version:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w26GWDw26lS3lebNpu1LW6rUgY5IdDHK2baRvhx57DU=; b=qOLaQ1A3keBlQ5
	3gU/DWxi0EOC/FTqS0yUPSx1YF/yFQK8QL0SKFTpZITlaw/PBlI7qNMYmEIpns3qOv4ZoSufWWX1A
	Ww/tXV7SWLYnXJ4T5KMSOjONJPhP5YnCyEIojkLFTy+JHyChpTCQpWBjHx5lrVKYZuTgZPop50i6t
	rOEI+QBpYOY0EoiqQWxP353uirfwUQU++tFDpTmBdtbruX9YG57wYuqH47DlT/+lG+fGiOOZXLch9
	/w77oYdBU4oJDxHvLtDg9Tn5MMNgr46JDdW/wA/Fef18MdakLsVq/5LeMi2Bpbv+TmRK0/nQp5PB7
	t2bnioYcWWl0jZLKl1Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBiq-0004b8-4Z; Thu, 31 Jan 2019 12:45:36 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBin-0004ap-4w
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:45:34 +0000
Received: by mail-oi1-x241.google.com with SMTP id x23so2606597oix.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
 h=from:mime-version:references:in-reply-to:date:message-id:subject:to
 :cc; bh=Sfu6Zq/WWsE5VxlwrCHEVgVmSgLmCzC4eI5lBhFjV2I=;
 b=etuK4Ac/zLckHjoqpT5dyGhRImUAH6IcL6GV2NHMsUjmfReBLhR6wvVGiZeMKh648X
 2Z9182qjJ8fQ2BijGjkE/VeP24z0fdvLUw2T/Psn3R92BP69q8YxDPTIGsgz2lwUso+h
 vFI8dAfM9iq5SO6BCWrNAzor/TmxgTazzdEjczpWRg0qvSto8k0dMHapGW1X4e0fb280
 Z4MKiZdhI24rPg0GNoTcn8HC2nzQgYPs738VsM+4VumQyrmG52KJL4qCjtgTHtcIdvr5
 79KFK+KspNRcw9JxG7A/F5unLvHg+sXTyKM9NGRqlFJRBE7qWLyCtxzS5c7NjW3GrjoG
 XDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:mime-version:references:in-reply-to:date
 :message-id:subject:to:cc;
 bh=Sfu6Zq/WWsE5VxlwrCHEVgVmSgLmCzC4eI5lBhFjV2I=;
 b=UJEdr0YBA8Rzno7BeMeTGPevilWtmeGD/+b6HYpLMmtYb0gJc0JeBaB3+/OLW3yVqe
 j53tRC4kqqbsrCHTcwtoh3oogF4p8LPoIZbCPAxH8pSTtzeCBCysZbBTmlZ5IwGQWnq6
 oowrdwmQeP5dfInbhWI0KhoHO0b9Fpbs3kEB76TAdUq9MzBlsUhXupKW+iTXiXAqHvo+
 FoULI82saQedOHK5bVnwHmbXfKquV2S83mwg90fwyIva55bvpSJK9pZxLEcH+jzVvB78
 E7MGc4iwj0lPIfyA54uD+4AXw/QBJKeiYfNuKtP2RIRaZLA7VSMuB6hmMtPXwWUK824g
 MB4Q==
X-Gm-Message-State: AJcUukfPIHP1q2WI8OsLy9D2N/IQW2bhyI8Zjf8lfVeR4//z/juJYJSE
 lgVMJttn96ovaiGHvCj/moczW0wkT25/ag==
X-Google-Smtp-Source: ALg8bN7yxkNTr76QqIO354em6Zr7MBuAJRDEU0Tnim7AL+/2CyLM5g0sIDkCvLSYQ4aB7SdoMaXQ+A==
X-Received: by 2002:a54:4088:: with SMTP id i8mr14769355oii.324.1548938731120; 
 Thu, 31 Jan 2019 04:45:31 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com.
 [209.85.210.48])
 by smtp.gmail.com with ESMTPSA id h24sm1664001otq.11.2019.01.31.04.45.30
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 04:45:30 -0800 (PST)
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-ot1-f48.google.com with SMTP id s5so2662012oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 04:45:30 -0800 (PST)
X-Received: by 2002:a9d:842:: with SMTP id 60mr24835948oty.22.1548938729575;
 Thu, 31 Jan 2019 04:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20190129195424.10161-1-otavio@ossystems.com.br>
 <20190130153956.GB10665@sirena.org.uk>
In-Reply-To: <20190130153956.GB10665@sirena.org.uk>
Date: Thu, 31 Jan 2019 10:45:18 -0200
X-Gmail-Original-Message-ID: <CAP9ODKoeo3+rQOXN8PMj2at1C0n1_P9GtC9E+ucqt7-4hoC8TQ@mail.gmail.com>
Message-ID: <CAP9ODKoeo3+rQOXN8PMj2at1C0n1_P9GtC9E+ucqt7-4hoC8TQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] regulator: rk808: Fix BUCK1/2 voltages on rk805
To: Mark Brown <broonie@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_044533_278131_073C52E1 
X-CRM114-Status: UNSURE (   9.89  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>,
 Otavio Salvador <otavio@ossystems.com.br>, Liam Girdwood <lgirdwood@gmail.com>,
 Kernel development list <linux-kernel@vger.kernel.org>,
 Tony Xie <tony.xie@rock-chips.com>, Vicent Chi <vicent.chi@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Mark,

On Wed, Jan 30, 2019 at 1:40 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jan 29, 2019 at 05:54:21PM -0200, Otavio Salvador wrote:
> > RK805 has the following voltage range for the BUCK1 and BUCK2 regulators:
>
> I'm missing the other patches in this series and don't see a cover
> letter - what's the story with dependencies?

Those are just adjustments on dts files fixing the regulator handle. I
am preparing the v2 without those as they are independent.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
