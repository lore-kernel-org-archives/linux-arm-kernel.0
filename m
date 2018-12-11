Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EDFC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:36:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F62720855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VzI+xL84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F62720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WrsbT1SgpdKuqKpIYoxKJNgcyPc4eEb0QxCz76xLDkc=; b=VzI+xL84uMdewD
	h534xi5MEBxzRkgEqDnqW3NJOFX0tn35/x9gp2+MX1eqtRUXsikUblbZtO7tBS3L0oK/eaE3sRk2E
	b8Z+Gr3B5RWTB0QUcVWZL/PCk2kN7gKZiotMG11cLIF8zYgXAS6sp1wpDd22NOJNL+koUgezLiv6v
	+4RWaVZj4NuS5a7yRJfpD9RLgY5YoN+8OYLIPBDoiyK4h+m/zd3CwojxC7boeqLvhy0OtY3pfkCf0
	ARxMYj2gx8x78ZZBY6OeH6lhUnqUCKGGOGFqar9dxSurMFIbPxsQwOn02oQ/c/V6a+Cz+QcTotBk0
	A5opuxmCWu5bHsFc3dJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWl0t-0000rS-DG; Tue, 11 Dec 2018 16:36:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWl0d-0000dM-9m
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:35:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B44591596;
 Tue, 11 Dec 2018 08:35:36 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84E1E3F575;
 Tue, 11 Dec 2018 08:35:36 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 79FB41AE0D31; Tue, 11 Dec 2018 16:35:59 +0000 (GMT)
Date: Tue, 11 Dec 2018 16:35:59 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: next/master boot: 175 boots: 18 failed, 143 passed with 10
 offline, 1 untried/unknown, 3 conflicts (next-20181211)
Message-ID: <20181211163558.GB12597@edgewater-inn.cambridge.arm.com>
References: <5c0fb738.1c69fb81.f62ad.3f45@mx.google.com>
 <20181211152311.GK6686@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211152311.GK6686@sirena.org.uk>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_083547_352323_A2AA17B2 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: catalin.marinas@arm.com, John Garry <john.garry@huawei.com>,
 linux-arm-kernel@lists.infradead.org, Wei Xu <xuwei5@hisilicon.com>,
 kernel-build-reports@lists.linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 03:23:11PM +0000, Mark Brown wrote:
> On Tue, Dec 11, 2018 at 05:10:16AM -0800, kernelci.org bot wrote:
> 
> Today's -next fails to boot on D05:
> 
> >     defconfig:
> >         hip07-d05:
> >             lab-collabora: new failure (last pass: next-20181210)
> 
> It takes an oops during IPMI initialization:
> 
> 09:51:45.224591  [   87.646247] ipmi_si: Adding SMBIOS-specified bt state machine
> 09:51:45.242352  [   87.652129] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
> 09:51:45.242646  [   87.661875] Unable to handle kernel paging request at virtual address ffff7dfffee000e4
> 
> ...
> 
> 09:51:45.429194  [   87.845965] Call trace:
> 09:51:45.429426  [   87.848400]  logic_inb+0x80/0xb8
> 09:51:45.429640  [   87.851620]  port_inb+0x18/0x20 [ipmi_si]
> 09:51:45.443075  [   87.855620]  bt_detect+0x40/0x250 [ipmi_si]
> 09:51:45.443320  [   87.859793]  try_smi_init+0x1a8/0x868 [ipmi_si]
> 09:51:45.443539  [   87.864313]  init_ipmi_si+0x190/0x220 [ipmi_si]
> 
> ...
> 
> 09:51:45.479097  [   87.910207] udevd[2569]: worker [2589] terminated by signal 11 (Segmentation fault)
> 09:51:45.501664  [   87.917863] udevd[2569]: worker [2589] failed while handling '/devices/platform/dmi-ipmi-si.0'
> 
> Full details here, including bisection information and full logs:
> 
>    https://kernelci.org/boot/id/5c0f88d259b514823d4925c0/
> 
> Unfortunately it looks like the bug has actually been around for a while
> but wasn't stopping us getting to a prompt:
> 
>    https://storage.kernelci.org/next/master/next-20181210/arm64/defconfig/lab-collabora/boot-hip07-d05.html
> 
> and it might still be some unrelated hang there.

The "bad commit" is just updating the -next metadata, so the bisection
doesn't appear to be useful :(

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
