Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF00FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:33:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705A720815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RW/62qVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705A720815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=76RZhQPbTkQNykmdcsqcEb21fH909KmX+P5JcsP58fg=; b=RW/62qVYRQnZX3
	eAdIxYkgLuNPc73jFHMpOfmv8wbGlMVfy7U9Jlxs1RR2QCOwi+CGFVh2O5FrxN798+4+fOUHFkkAg
	mKiZQP3S9Qn7NnVmBR4w7o5vXzxG78N9eeVFg5gMaK+TEn7PKc5f7Sd2E2auyh3bHpmDWUyJn9xGu
	Wikxim6G/seSQpCBdfC1em4aS9zW0/eUgDxcbnFMYnHu64CEhlCnJs0++Jg7z8XquPnZM4Ssj7og7
	RKKMD44VchMEp6Xyut8kuhf1W505lAET6x9S0KfkIcli0q2FFowF4+NIx1FRxqfweybzPoKGlh7Tl
	cGQDMygUlGv54+kD7wng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonBZ-00030D-RF; Wed, 30 Jan 2019 10:33:37 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonBW-0002zs-Ll
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:33:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 321C2A78;
 Wed, 30 Jan 2019 02:33:34 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF4483F59C;
 Wed, 30 Jan 2019 02:33:32 -0800 (PST)
Date: Wed, 30 Jan 2019 10:33:30 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] firmware: arm_scmi: provide the mandatory device release
 callback
Message-ID: <20190130103330.GB27201@e107155-lin>
References: <20190122113525.13705-1-sudeep.holla@arm.com>
 <CAK8P3a09=Z6rfyeqZmSF8rZVuUHwHx0FM0PAA5kaukJFmv_GLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a09=Z6rfyeqZmSF8rZVuUHwHx0FM0PAA5kaukJFmv_GLQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_023334_715390_35F62071 
X-CRM114-Status: GOOD (  15.17  )
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
Cc: Kevin Hilman <khilman@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ARM SoC Team <arm@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 11:30:24AM +0100, Arnd Bergmann wrote:
> On Tue, Jan 22, 2019 at 12:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The device/driver model clearly mandates that bus driver that discover
> > and allocate the device must set the release callback. This callback
> > will be used to free the device after all references have gone away.
> ...
> > Hi ARM-SoC team,
> >
> > Can you apply this one patch directly or I can send pull request if you
> > prefer ?
>
> I applied it to the arm/fixes branch now, and added a Cc:stable tag
> for backporting to 4.19 and 4.20.
>

Thanks for that.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
