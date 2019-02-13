Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F72CC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:46:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F8A222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kAT7NdPF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPkdxirG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F8A222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SnP6Wjuh92t+XnxWMzaH9qYw7gTaDTxLNB6zV+nKg+4=; b=kAT7NdPFogYh5N
	ss5zMWiLmf81Ioj8oghM2IPZIwtD/nr+dNlJu/DjWFgcvNfrVhcxp2bGwGhhlGadPeQjv7QjcYMLT
	tMGx4ZC48nTo1qgNlUMA/dHE4qS7w2vvOMdg6FNBcbLnglIRsv9yeXvyHqKVelcC9npy9QjQsXnwu
	Bac/Zaq0GcyyvrXUaxn34EEa8ql4415A2Wb/g/4rvVL8O3VOYei37Xlp9yfq+noA6XuYK+I0wPdcj
	vITXoJWzDxC0L+OqDv1e7GFBWRZBd8HIK0FBljsjlsZK03k3+7BX7hZUNVEf2Nif0T69zJFWhaKSV
	WMS7KeC9TmUc/N7fFb/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtnN5-0007xT-GE; Wed, 13 Feb 2019 05:46:11 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtnN1-0007wR-Mx
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 05:46:09 +0000
Received: by mail-lf1-x144.google.com with SMTP id t14so816514lfk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 21:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PeCBPDtNKEuaDKuiaHAzR3WaJUZOBwZPqqRsoj6cyhI=;
 b=UPkdxirGr+HslQwZfW7aZGsFIjX/hlnjhkEgIOZjSq/gGk0dL7x/rGp/35KCQTsyfi
 E0UcpVCn0e4A0Knks+0AXHnTnFHmXE2DUr8IBYqPIidXClhRwzHTU4SbMg/ccvpevDCn
 fn6oLBF8kAgU+lV2Ig2XWO1F2HOeFkgps4lxF/J5UzMZRDxETvMwBLRh69Z0NdDuPaA/
 a2VnxY9l6w31IMeZC83IQyv8LQZOR7nisU+gLkg8Om2nuSpjIIjxx2Y7fwyEglqo4yxA
 dkPwsCnSOqabvbmxTAdhTazgU7qwobUmqv3awExjwmof94h7yFDxkOuB5ve84T3Yq3fl
 M6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PeCBPDtNKEuaDKuiaHAzR3WaJUZOBwZPqqRsoj6cyhI=;
 b=rs/qvka2T2OQKMWGcyUwhjY4erT5SYKqEtLtNYAd6EMlQrIp4laOf8pb+Qs9jeAg09
 y+Fl2L2Fs/vhDCPx5t1YACO9+TRPdCcxEPFs5ISd3OFgXMIz+c/KpdnTDqcWQEdZLLw+
 OjNohcuqIGkFj9vtmzwJ9OyBrEzR8YCHJ4dklXtCFH092YAqPjVFCOeLJ8Nj6Y5Z8gaU
 9HpZ5SjfyDUcJM9dERJuHwICDzw35GTjMI4WLyZSXonnM9re1DnkY/VZaCuuanHHGGdh
 2Sg/Cxna2sfWV9S0IjxsGcLnucg4HIHL/AgPwh+YggvJligmzJh7mRH/AqD8/u6vQv59
 DP0A==
X-Gm-Message-State: AHQUAuZr7QX38dneG/D4CP0HbsR7cdRZSPxl95CiRiswtw+Flg3QnnEW
 xggbiri75VKbgeSdilLNvh7qzvpWc1XNRe87XO1rLQ==
X-Google-Smtp-Source: AHgI3Iamku4Gk6WwnAlQTQH0P3xvFkH9o1Kpoob1PmQ254v3FRny5b5BJ2MVBR1/ydD7UCVLB1jrXDy9s0tm0TxPsxo=
X-Received: by 2002:a19:5205:: with SMTP id m5mr4613271lfb.61.1550036764803;
 Tue, 12 Feb 2019 21:46:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548052878.git.baolin.wang@linaro.org>
 <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
 <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
 <20190201130519.GH20797@sirena.org.uk>
 <CAMz4kuJdPts31Ak-H=VAivvoqqPtxO5M1RdqrNPwTLT5d1h_7w@mail.gmail.com>
 <20190212122035.GA20635@sirena.org.uk>
In-Reply-To: <20190212122035.GA20635@sirena.org.uk>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 13 Feb 2019 13:45:53 +0800
Message-ID: <CAMz4kuLCA2d0aRf4r7-F6w7q58F4Do-z5weTXNHYVvvJ4Acegg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
To: Mark Brown <broonie@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_214607_759359_8970E493 
X-CRM114-Status: GOOD (  19.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Lyra Zhang <zhang.lyra@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 12 Feb 2019 at 20:20, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Feb 12, 2019 at 04:40:10PM +0800, Baolin Wang wrote:
> > On Fri, 1 Feb 2019 at 21:05, Mark Brown <broonie@kernel.org> wrote:
>
> > > You can just list all the individual device names in the of_match_table
> > > for the MFD and then it can bind to any of them.  You can always map
> > > them onto the same behaviour in the MFD driver if they are identical
> > > from a software point of view.
>
> > If I understood correctly, as you suggested, we should add new
> > mfd_cell groups to list all different PMICs' device names. Something
> > like:
>
> I do think this is a good idea (registering the components of the MFD
> using mfd_cell), though it wasn't quite the point I was making.  Having
> individual device names matters less for Linux-internal names like this.
>
> > But from my point, they are just some meaningless duplication, and
> > will waste lots of code there.
>
> I was more thinking of the of_match table that has the IDs that appear
> in DT - they're the one that's the ABI.  Look at something like wm8994
> where the driver has several IDs listed in the main table then selects
> function drivers based on that.

Yes, we can use id_table to populate the PMIC child devices, but some
child devices need use the device node to get some resources which are
described in DT, so we must specify the of_compabible member of
mfd_cell. That means we should use compatible string of the
of_match_table to populate the child devices.

So the problem is still there, we should expand the mfd_cell groups to
list all device names, but just some meaningless duplication.




--
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
