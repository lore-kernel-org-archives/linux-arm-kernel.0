Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49169C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:52:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D395208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SGJsZszE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D395208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=epigenesys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8l5eCFhLe/LD/CSSlJSxqxmDTvUGq0GB2UGDtZQ5ZJo=; b=SGJsZszE6ONPmY
	zYFsNxJ4W593GI2agrneuphLVRRUcDfmvhcws7cYxOwtosJ0q7XkWJjvO82JyzCyVJSAu7FPgCLN2
	o2oem9FiIYCmsS+yTE7Bmy2EBEY2Vv6fuUfuAJlIxUA60fvHyiFaiEABovh+oAAaQaOBtcsndRnay
	i9wWM33yXBS3c+AjjOQsP3mpHV1zLU3l/bxacIZp2m/KV738RgY8omjFoO9xfZrbr9aLRMPLi0cM+
	/JmZHuQtNB9pUJBgotyKHbNjmDafdKL9JooAa1Q59XTtuAjaAD0PmNq1weKkPpVPiUiRWpny7zzFE
	dBoF6tdBtKJILWd6PSCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvxI-00088c-DX; Thu, 06 Dec 2018 15:52:48 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvxD-00087X-Ef; Thu, 06 Dec 2018 15:52:45 +0000
Received: by mail-wr1-f65.google.com with SMTP id b14so935085wru.12;
 Thu, 06 Dec 2018 07:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eVkmmt8mDus3xwhFaWG+oJzkHqmOlGdBmMtv+Lg4LS0=;
 b=A2Sr2xfYJsu+KjMr1grG/NywesQYtNlyCFd3Es/xK7cIjBf1M+E6oq+T+SvqCcwgcg
 AFRcpZBLAKODiuB3TLPVCYjE/YrMSPr6BQ9QIFYIJivxs4scDshQUyAWp2S3+LutkWwW
 eKbmB/i0Y80MK8SdsnpuaH+QN+Gh6bgfcbuk5AyYZKpZsKXIiqnoPhyMYYjrDn67vAOK
 fyJRq8WVL38WTj6flxl2Vd9+XiQUa0C0WrEKIILOffgWxD19dxSY8zSjBogmam8VXZAE
 Iihp0IFY8vUpC6wHQqqkq7HqP66Z2TVZ78LHJS6Cly3/Fz45T7sQ6cuv1nFLaIpGg+7C
 WbsA==
X-Gm-Message-State: AA+aEWZhzRvkptK8k4h13SfeQdxlbVWTd+t2Z/CWEI1uJT2RFv+RWWOm
 04hoYaAV5H77nX1B6r42NDo=
X-Google-Smtp-Source: AFSGD/XD6VtFkeuKRs2u8U+/FHG63uisR9PWhDBT14EYlz9Vxkb/4WCK0ewUE3ovyWelntEZ5Re9LA==
X-Received: by 2002:adf:8c09:: with SMTP id z9mr26178029wra.301.1544111551554; 
 Thu, 06 Dec 2018 07:52:31 -0800 (PST)
Received: from ingrassia.epigenesys.com
 (host194-85-static.3-79-b.business.telecomitalia.it. [79.3.85.194])
 by smtp.gmail.com with ESMTPSA id s66sm1536919wmf.34.2018.12.06.07.52.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 07:52:30 -0800 (PST)
Date: Thu, 6 Dec 2018 16:52:28 +0100
From: Emiliano Ingrassia <ingrassia@epigenesys.com>
To: Carlo Caione <ccaione@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
Message-ID: <20181206155228.GA15225@ingrassia.epigenesys.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
 <20181206124347.GA10676@ingrassia.epigenesys.com>
 <85973a9cd43c677ffa5c80853e86d79f36a9eb3a.camel@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <85973a9cd43c677ffa5c80853e86d79f36a9eb3a.camel@baylibre.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075243_493446_CBAD3D23 
X-CRM114-Status: GOOD (  26.37  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, khilman@baylibre.com,
 robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Carlo,

thanks for the answer.

On Thu, Dec 06, 2018 at 01:17:58PM +0000, Carlo Caione wrote:
> On Thu, 2018-12-06 at 13:43 +0100, Emiliano Ingrassia wrote:
> > Hi all,
>
> Hi Emiliano,
>
> > thank you for involving me.
> >
> > I applied Carlo's patches[0] on a kernel vanilla 4.19.6
> > and tested it with kernel packet generator, monitoring
> > bandwidth usage with "nload".
> >
> > All tests were conducted on an Odroid-C1+ Rev. 0.4-20150930 board
> > with a short ethernet cable directly attached to a laptop with
> > 1G ethernet interface, with "nload" running on the board.
> >
> > The tests I performed are composed by the following steps:
> >
> > 1) Start packet generator with "rate 1000M" on laptop;
> >
> > 2) Keep packet generator active on the laptop and
> >    start the packet generator on the board with "rate 1000M";
> >
> > 3) Stop both packet generators;
> >
> > 4) Start packet generator on the board;
> >
> > 5) Keep packet generator active on the board and
> >    start the packet generator on the laptop.
>
> out of curiosity: why do you expect to see something different from
> point (2)?
>

I did not expect it indeed, I tried and got different results.

> > Test results without Carlo's patches applied:
> >
> > 1) "nload" shows an incoming traffic of ~950Mbps;
> >
> > 2) "nload" shows an incoming traffic of ~400Mbps
> >    and an outgoing traffic of ~250Mbps;
> >
> > 3) "nload" shows 0Mbps both for incoming and outgoing traffic;
> >
> > 4) "nload" shows an outgoing traffic of ~950Mbps from the board;
> >
> > 5) "nload" shows incoming traffic of 0Mbps
> >    and an outgoing traffic of ~950Mbps.
> >
> > Applying only the first patch (change mac IRQ type) I got the same
> > results.
>
> This is expected. The change in the IRQ type is solving an issue that
> you can see if the run a stress test involving multiple components for
> several hours.
>

OK, did you use "stress-ng" tool for tests?

> > Applying only the second patch (drop eee-broken-1000t) I got the same
> > results!
>
> I am a bit confused here. Wasn't the eee-broken-1000t added to fix a
> problem with the ethernet? Are you suggesting that for some reason you
> cannot reproduce anymore the problem for which the quirk was
> introduced?
>

Problems without the "eee-broken-1000t" flags were experimented
one and a half years ago on a Amlogic development kernel from [0],
probably a 4.14 version.
Many patches about Meson8b SoC, dwmac-meson8b and dwmac driver
were introduced so yes, the "eee-broken-1000t" was added
to fix a problem with the ethernet (one and a half years ago),
but new tests are needed to say if it still necessary.

> > With both patches applied I got the same results but with an incoming
> > traffic
> > of ~3Mbps on the board.
>
> On all the tests and immediately from the start of the tests?
>

Yes, in all the 5 steps immediately from the start.

I also tried to execute "nload" on both sides to see the bandwidth
usage.

With bot patches applied, after starting kernel packet generator
on my laptop with 1Gbps rate, "nload" on the laptop side shows me
an outgoing traffic of ~940Mbps while "nload" on the board side shows
me an incoming traffic of ~3Mbps.

Also consider that a pinging test from my laptop to the board shows
a packet loss of about 90%.

> When you hit the problem con you check in /proc/interrupts if you see
> the IRQ counter for the eth0 incrementing or not?
>

The eth0 IRQ counter is incremented during the test.

> Cheers,
>
> --
> Carlo Caione
>
>

I would like to conduct other tests with iperf3 to be sure about
the obtained results. What do you think?
Should I apply your patches on the latest Amlogic development kernel?

Regards,

Emiliano

[0] https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
