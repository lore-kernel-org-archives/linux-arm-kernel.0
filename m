Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D654C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 07:38:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8B2208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 07:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VOL2X0ZF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6bHE1zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8B2208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r7BPcTbjtMWDN/hVHSETCf7yfXciZ+xYKC5tXET1qlA=; b=VOL2X0ZFJk4GL7
	MwBt4CWl2LwkMWqmhc3TRyENjVs8CN7eUF5CW7AHRt2miUEZK7sbmjNXBbLFiVNPP+DZEv8YNdqre
	7HqrWJWiOT74wveAU8lZJDLtFO7nz/lQMg7vDWblR4M+MxuuQ3HuTLMZR6ou8dYO9MA2CfPfA6ApE
	AcYERo27fnNzRBgbXPgFrBe2lrCPHdnpqtXOFBuxDlqnXbE8/nGVXDBw7KGE1CQ9LRjnXDezPLGol
	XsieD7+H0RjUU///I8OhfCcU9GThnQkK/smk+mzzkh7O5PHQO4GmHj9lcf3RvxhqCJebTh7mIM/Pn
	Xg2Fm6LZeH9oL8x2Rc6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geEcl-0004gm-NV; Tue, 01 Jan 2019 07:38:03 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geEch-0004fj-S9
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 07:38:01 +0000
Received: by mail-pl1-x643.google.com with SMTP id p8so13325049plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 23:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=97y5ma4ufpzuFHgG4U4LHmitRQtAGbTe3kx87jknEPs=;
 b=i6bHE1zwmWlww+T4Cd55Y9VG3Pfp8hBrO0nxdoQRK7DAblxPvIGixOOUTTbWDyX4p7
 ftpB7iIE6MLRyreHVbtlD8I9ZugNvwrTqB/sy9CYSFlKpB/ijt1xTAKmE96I7iitZqkU
 F7ua5HgbvqIs3XwnJxwnurvRIoxhovZAz81MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=97y5ma4ufpzuFHgG4U4LHmitRQtAGbTe3kx87jknEPs=;
 b=i2lXZuZNzpiWZun+nqltTjc5Rgeo4rW/Dmh3Dl4Ur/uPlgSsYWeedD31NR6kDsyUQP
 0Wo+QHU1hekHcT35b8lIU9doGv5RRZtL8SiWY0/e+/wTchin7av4a7jbyMnT8TRhHMb5
 21Rzt+VEDF0l6wDaPeVHhPYALXXToHj+19rU0rITGLjBymSO6TCmpHrWg02vMmuffpe9
 xu4tZxwAJp9L+B6neFWlwnw86tgSs+9IGgCMA2mJ4eEUftLHvEL7f5q4GXofD2StI0Yu
 zysOY1TBVtXhcBdCXR3J+ZdM5Gd1Fdzaafwg826nI5dRY/BX0mNrTM7aADvADReti3ST
 w+5A==
X-Gm-Message-State: AJcUukdmjAkc5f30T8IxxIA2UnRWz8Mj5G3fEynVLyWmI8dP/rWuoTcV
 ITa4NOYd2NpokRTDOD/W+i6r
X-Google-Smtp-Source: ALg8bN5uYQ8cKV0BX7QuhVvDPQ7pWu1/iXjsOY5XIo8XP/92WrjJFeyTxMG/vTQz3ARaX3iK8ZJO8Q==
X-Received: by 2002:a17:902:8e8b:: with SMTP id
 bg11mr40203473plb.332.1546328275746; 
 Mon, 31 Dec 2018 23:37:55 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6394:f979:3812:84fe:81d3:6fa8])
 by smtp.gmail.com with ESMTPSA id u87sm96116441pfi.2.2018.12.31.23.37.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 23:37:54 -0800 (PST)
Date: Tue, 1 Jan 2019 13:07:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for
 Actions Semi
Message-ID: <20190101073745.GA6711@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
 <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
 <20190101032622.GC2736@Mani-XPS-13-9360>
 <6c6cc111-ad1b-15eb-a1b0-3cbe8b5e5226@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6c6cc111-ad1b-15eb-a1b0-3cbe8b5e5226@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_233759_924594_EEFCDA9A 
X-CRM114-Status: GOOD (  17.04  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, Joe Perches <joe@perches.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 01, 2019 at 04:32:40AM +0100, Andreas F=E4rber wrote:
> Am 01.01.19 um 04:26 schrieb Manivannan Sadhasivam:
> > On Mon, Dec 31, 2018 at 11:12:18AM -0800, Joe Perches wrote:
> >> On Tue, 2019-01-01 at 00:25 +0530, Manivannan Sadhasivam wrote:
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >> []
> >>> @@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> >>>  M:	Andreas F=E4rber <afaerber@suse.de>
> >>>  R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> >>> +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
> >>>  S:	Maintained
> >>>  N:	owl
> >>
> >> The N: entry matches too many non-owl entries like:
> >>
> >> Documentation/parport-lowlevel.txt
> >> drivers/misc/ibmasm/lowlevel.c
> >> drivers/misc/ibmasm/lowlevel.h
> >> fs/udf/lowle
> >> vel.c
> >> net/ipv6/ip6_flowlabel.c
> >> sound/soc/samsung/lowland.c
> >>
> >> Maybe there should be two entries
> >>
> >> N:	/owl
> >> N:	-owl
> >>
> > =

> > Thanks for letting us know. Yes, we need to change it. How about below?
> > =

> > N: owl-
> > N: -owl
> =

> No underscores anywhere?
>

There is nothing with underscore yet and I don't think we'll add it in
future.

Thanks,
Mani

> Cheers,
> Andreas
> =

> > =

> > Will do it as a follow-up patch if agreed!
> > =

> > Regards,
> > Mani
> > =

> >>
> =

> =

> -- =

> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=FCrnberg)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
