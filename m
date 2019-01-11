Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EB7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:54:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB7320872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QnNIhjmK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIDfgAtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB7320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3YJRZ4pLPcdfUL4v8hwwKJ6HBKq/vtxyiV8IHLaMDfo=; b=QnNIhjmKVmvWKf
	pp3wZ3GNUZFXR8ORPJV1WJniiyCZ/ORnvTndaWfNuponiRloeMvC+zWJZkY+rqXunsrhCS1F9Sf+5
	0KsgLjU4S3d5QvncpWTF0iG73igl0y73w+hSN0iJGl8EijEtzsQBcbRj8hHwR3OivyOCfQTYTnqyx
	yDMCMxjpp7lzGhGupgphRYMjLm+srGgDpcjzU7VzjsmVZFLs/u0AvBobUgJANPdSYCnJaSvitdq0y
	FUgoOXJaZqJPaFBcJgtbVvSiXCK7kr8sZ97H/8mBBQfvRaqQhu9qnyDr6ri5aC+EvsUsfY0f/DqGN
	x9bi2EmT9HOKO8sO9egQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghnte-0000P5-8c; Fri, 11 Jan 2019 03:54:14 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghnta-0000OV-Cg
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 03:54:12 +0000
Received: by mail-ot1-x343.google.com with SMTP id u16so11996261otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 19:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mh8Y13SDTRaV+A1oBQTFShssINOe7TO814WDWYQK8PQ=;
 b=eIDfgAtldZAUkxiAEktyusIxFrSMYnws+/L0hQWS//wF4Y0HA+7ZIl+Mmdy+qfeAVo
 iHks2mCHLn6TkXfgMTIOT97fyZ7rPdCdyx6+U/HG4f7f/fwXu8UnYY5LMvCN+lf2m0T8
 Cs7HBAjdcNi5IxDxypz7by0O0/0/iIzJNs/YnIQ0St2g2op8hLI3WyX+JJHUz70JhGgp
 fhHC2xCsL0VWsuQWKpNUF3DxamDenll90bycc6Ts1C3I44Y7jQQhSdN0IbXHzZak+cEt
 WpxUrf4/FOX0HspiJ2k/bIUBF2tONoocrXF65kL5E32PP0E9nl4Nn4M+zpQqZeYVadi2
 6LpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mh8Y13SDTRaV+A1oBQTFShssINOe7TO814WDWYQK8PQ=;
 b=MlPmT8H+npUr6xaarRhPBX7HM6BhCyKA/xdGqydVTm4FIDiYVErjk3HnIJHChBODjB
 0iKe20ByMz/dE/iSojpwIzL83GJRNuf5JW5W0tM9q0/DtZsERTJuvjPXWAWGmIlnAXJg
 gXnb7zjAwlkUJaQj1IHPfxIE7Tj/PyILSh4ZEbsm/e4QyYuERENBWNa4R+WXUE3lvsB3
 bibqmSrpLQJNME2JP/Ql1cZ04OE06znePYc1+mkSH8jtjlPUJOYdLvdlEh6h16CVKvts
 +ZeFubuOnjOrW0GQUezWo+cOu4qFEcpxfu7PYk0j0mvi+qFrorC1GT6aJzBQLvPEHxSv
 B6wg==
X-Gm-Message-State: AJcUukfx9yfHGAaYtDg4Br2iXxnJBqCx9FLE+RdCSExsRGTfk8OP6nKW
 50TbHsjeitJN5W3Iy6H4D4AfhI7z4tRMQxIDPtE=
X-Google-Smtp-Source: ALg8bN7hsagFfq3/jS6BnlhjYPEH2g975gQQp87jMZLAaKlMNd7J10IBYEAW9Il2b9e1Gya9AB8OfdyhxPF6D2gJzpw=
X-Received: by 2002:a9d:14e:: with SMTP id 72mr8898399otu.54.1547178848846;
 Thu, 10 Jan 2019 19:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20181213105924.30384-1-shameerali.kolothum.thodi@huawei.com>
 <4fe81519-1ddc-1d73-8c7a-cd0865299b53@arm.com>
In-Reply-To: <4fe81519-1ddc-1d73-8c7a-cd0865299b53@arm.com>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Fri, 11 Jan 2019 09:23:57 +0530
Message-ID: <CAKTKpr4uvQtYKrcAMSoaA-sYv2MNCqZgRb2KQhYa23KaYptaUA@mail.gmail.com>
Subject: Re: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory allocation
 for ITS tables
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_195410_459108_D4B000C9 
X-CRM114-Status: GOOD (  19.11  )
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
Cc: "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
 John Garry <john.garry@huawei.com>, gkulkarni@marvell.com,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, Robert Richter <Robert.Richter@cavium.com>,
 linux-arm-kernel@lists.infradead.org, Hanjun Guo <guohanjun@huawei.com>,
 shankerd@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shameer,

Patch looks OK to me, please feel free to add,
Reviewed-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>

On Thu, Dec 13, 2018 at 5:25 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 13/12/2018 10:59, Shameer Kolothum wrote:
> > From: Shanker Donthineni <shankerd@codeaurora.org>
> >
> > The NUMA node information is visible to ITS driver but not being used
> > other than handling hardware errata. ITS/GICR hardware accesses to the
> > local NUMA node is usually quicker than the remote NUMA node. How slow
> > the remote NUMA accesses are depends on the implementation details.
> >
> > This patch allocates memory for ITS management tables and command
> > queue from the corresponding NUMA node using the appropriate NUMA
> > aware functions. This change improves the performance of the ITS
> > tables read latency on systems where it has more than one ITS block,
> > and with the slower inter node accesses.
> >
> > Apache Web server benchmarking using ab tool on a HiSilicon D06
> > board with multiple numa mem nodes shows Time per request and
> > Transfer rate improvements of ~3.6% with this patch.
> >
> > Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >
> > This is to revive the patch originally sent by Shanker[1] and
> > to back it up with a benchmark test. Any further testing of
> > this is most welcome.
> >
> > v2-->v3
> >  -Addressed comments to use page_address().
> >  -Added Benchmark results to commit log.
> >  -Removed T-by from Ganapatrao for now.
> >
> > v1-->v2
> >  -Edited commit text.
> >  -Added Ganapatrao's tested-by.
> >
> > Benchmark test details:
> > --------------------------------
> > Test Setup:
> > -D06 with dimm on node 0(Sock#0) and 3 (Sock#1).
> > -ITS belongs to numa node 0.
> > -Filesystem mounted on a PCIe NVMe based disk.
> > -Apache server installed on D06.
> > -Running ab benchmark test in concurrency mode from a remote m/c
> >  connected to D06 via  hns3(PCIe) n/w port.
> >  "ab -k -c 750 -n 2000000 http://10.202.225.188/"
> >
> > Test results are avg. of 15 runs.
> >
> > For 4.20-rc1  Kernel,
> > ----------------------------
> > Time per request(mean, concurrent)  = 0.02753[ms]
> > Transfer Rate = 416501[Kbytes/sec]
> >
> > For 4.20-rc1 +  this patch,
> > ----------------------------------
> > Time per request(mean, concurrent)  = 0.02653[ms]
> > Transfer Rate = 431954[Kbytes/sec]
> >
> > % improvement ~3.6%
> >
> > vmstat shows around 170K-200K interrupts per second.
> >
> > ~# vmstat 1 -w
> > procs -----------------------memory-- -  -system--
> >  r  b         swpd         free            in
> >  5  0            0     30166724          102794
> >  9  0            0     30141828          171148
> >  5  0            0     30150160          207185
> > 13  0            0     30145924          175691
> > 15  0            0     30140792          145250
> > 13  0            0     30135556          201879
> > 13  0            0     30134864          192391
> > 10  0            0     30133632          168880
> > ....
> >
> > [1] https://patchwork.kernel.org/patch/9833339/
>
> The figures certainly look convincing. I'd need someone from Cavium to
> benchmark it on their hardware and come back with results so that we can
> make a decision on this.

Hi Marc,
My setup got altered during Lab migration from Cavium to Marvell office.
I don't think, i will have same setup anytime soon.

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

Thanks,
Ganapat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
