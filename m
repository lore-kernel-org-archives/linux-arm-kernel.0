Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09009C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:11:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA5121773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hEQgZ7lp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLqsH+/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA5121773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ETZ7B+Vky9XM8tRmbKEvxTtCnBwpBEKxFG6BTvk4GsI=; b=hEQgZ7lpNHnoXc
	xNsdr9zkwgDGmTBHVA4rplED3AejxB9v4FV1P032XyVrVcGNYbTuSoAsXCFcu4iZaWDeXH6zsPtgH
	2j1kWNbBf1tKn6ZuMM0aV8FGKVKo7+SmB9H6LmEr88joIgszmjJo5vi9aj4qQGrJAnnoYmUdwl0QR
	hIQlCt+TUumd2lV4ZNNyh83InTbfxvoGpYhuil0YROVwwLolDiCLFVaYPsl7I1OfBJCYENU4SMylK
	cDc9CWxHeNmTxTWmDRhKF5N6Ce6ebN873UZJmivXo74q5wzgIpah54PvWU8e1mk/ityMDKV6NJTGb
	fnItb3/VDs96PlVLWkNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw2NB-0007nb-GM; Tue, 19 Feb 2019 10:11:33 +0000
Received: from mail-it1-x131.google.com ([2607:f8b0:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw2N7-0007nF-DI
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 10:11:31 +0000
Received: by mail-it1-x131.google.com with SMTP id z131so4725622itf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 02:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L0cZ0tVqtW9kfItlciv+ga9j/6Pg5sRtl7YtijL5Qfw=;
 b=lLqsH+/tJTMh73Z5IHIhmGvCRCWpnuvmHd2p0gJ+v+A/UoqB8owwb2A01rttc3OKND
 aK4lVZxI5V2XF63HbnIqzk2OqZannL6Ja5rT1Ag9cqfkYPoNzkfUBQo2Ffewy3epE0FY
 rQcliu1z89+qy/0+CDvhkOAoe76wk+rQOhK4lU/Tr8ItnAPox36BO5q5ZZUN/MmsckR5
 E9WA+X0dnaIc4dNWN5zWjE0LFHbTxIIkhRSIEa86bSvePQQ+aUX0d+kBuSQQu0LaHIhc
 dQqRg5irgzWJk6F5EXdDp0uDyJEIJYfLf613rOe0ZKH5Orqgwx0B0lW1RhpucHzH40Jp
 w3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L0cZ0tVqtW9kfItlciv+ga9j/6Pg5sRtl7YtijL5Qfw=;
 b=btkXtYJZd9r+/MKoaCDg3qns7tYZp+68n1JFcq22/Sw2C2kVvpKIV6c7ZEzGysui3P
 qeh6m3lzBfWSo8nsYBJx1EHD+17qLe+l8G4aoF5HGdh7OISomgIrcgNAMExAslGMfx+U
 mjNzt8+iUWuRgTQBsBLbt3rv3UXJha0IplNs9o65ONFk5PLI0JdTzNCHu9DfNSWUBPZV
 l6AAK1QxPIC91ZLW1qYG/hDfHdyw2bj187pvT7cEOVB4sX3lIBj6v8zF40znQjUPoV4B
 tGshUE1ms8AsvrZo7n05qXUwF7RvM1I8Oe4ATVkQ8hDYlheoUte8p2NtN0z4ngeuMW7F
 68Nw==
X-Gm-Message-State: AHQUAubN9IP6IOQ+XJFsolejn/ltqOiSBgR/Co3CIyuGFZfv022/vOuF
 RO1xBbaScUERktxlBczzw4gaxNAyjVBwiSppvSN6zA==
X-Google-Smtp-Source: AHgI3IazTFGtyUp+ZG5NwknbpPVzij/BGpd9sn0Xp+gcI6OxPlqcnr64aq35v0OOe+8lj9Y1/3OQC+0v7f8xiPgCRD4=
X-Received: by 2002:a24:1947:: with SMTP id b68mr1551697itb.121.1550571087965; 
 Tue, 19 Feb 2019 02:11:27 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190215185148epcas3p23960bfe37c629ebb2103e673509949f4@epcas3p2.samsung.com>
 <20190215185058.GB12909@gmail.com>
 <a78f8033-954f-8b59-b361-557acef3acdd@partner.samsung.com>
In-Reply-To: <a78f8033-954f-8b59-b361-557acef3acdd@partner.samsung.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 19 Feb 2019 11:11:16 +0100
Message-ID: <CAKv+Gu_6QNOWN8wd+dpvGocrLhQjvNS4SpMaVqZ86uWtT70yiw@mail.gmail.com>
Subject: Re: [Bug] s5p-sss crypto driver doesn't set next AES-CBC IV
To: Kamil Konieczny <k.konieczny@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_021129_451667_32E88219 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: linux-samsung-soc@vger.kernel.org,
 Christoph Manszewski <c.manszewski@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Eric Biggers <ebiggers@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 19 Feb 2019 at 10:58, Kamil Konieczny
<k.konieczny@partner.samsung.com> wrote:
>
> Hi,
>
> On 15.02.2019 19:51, Eric Biggers wrote:
> > Hello,
> >
> > The AES-CBC implementation in the s5p-sss crypto driver is failing the improved
> > crypto self-tests I currently have out for review.  The improved tests check
> > that all CBC implementations update the IV buffer to be the last ciphertext
> > block.  This has always been required so that requests can be chained, but
> > unfortunately it wasn't tested for by the self-tests until now.
> >
> > See the boot logs for Exynos platforms from the KernelCI job here:
> > https://kernelci.org/boot/all/job/ardb/branch/for-kernelci/kernel/v5.0-rc1-149-g64c945c018af/
> >
> > alg: skcipher: cbc-aes-s5p encryption test failed (wrong output IV) on test vector 0, cfg=\"in-place\"
> > 00000000: 3d af ba 42 9d 9e b4 30 b4 22 da 80 2c 9f ac 41
> > [...]
>
> I checked dmesg logs after my patch with:
>
> root@target:~# dmesg |grep alg: |grep aes
> [    4.087168] crypto: alg: self-tests for aes-generic (aes) passed
> [    6.305202] crypto: alg: self-tests for ecb-aes-s5p (ecb(aes)) passed
> [    6.405489] crypto: alg: self-tests for cbc-aes-s5p (cbc(aes)) passed
> [    6.505000] crypto: alg: self-tests for ctr-aes-s5p (ctr(aes)) passed
>
> and I noticed there are no cbc-aes-generic nor ctr-aes-generic
>
> Did you test them in separate tree ? Why they are not registered in /proc/crypto ?
>

Generic CBC and CTR are template based, so they are only instantiated on demand.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
