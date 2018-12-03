Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3614C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:12:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B280420661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H5TBYpHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B280420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M9+WBdsdugKp2Kt34AM/j8qTqpnoxAh9TZCsQnrkM58=; b=H5TBYpHSKTNPk0
	hRQFFhpJ7MDfo3sa5jGVSF2pZERpUqC46+09uue4+G7fzIVO2paDEiiMkP+aHDP2fOmLtas6oU7AV
	jXET81jHAOSsKsuBEVVs7RnqmIBptKpD9Sz3Lnif9bcDKU2hxPzlo93SKMjoLJFwpGbXnfQ6838Tm
	PUb1jHXRnJouUH5pKljD3Negzl6nGcItozc33UFPA/Fbz2lfUwHm0VS5aw8fCoX0+Ux0zG9MwTzcs
	5kTCW6GXS/Ti1s6gY/+KSU9ZtID7ESW0sQdhsgTIJV7n7O2xzvQcLpWDJvweZPvv7huDpDvyT4b+y
	fOT51C99jKY7it88AdJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrm0-0001UU-4Z; Mon, 03 Dec 2018 17:12:44 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrlw-0001RI-VL; Mon, 03 Dec 2018 17:12:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3780F1682;
 Mon,  3 Dec 2018 09:12:30 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8738F3F59C;
 Mon,  3 Dec 2018 09:12:26 -0800 (PST)
Date: Mon, 3 Dec 2018 17:12:24 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFT PATCH v1 3/4] cpu-topology: Move cpu topology code to
 common code.
Message-ID: <20181203171223.GD17883@e107155-lin>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-4-git-send-email-atish.patra@wdc.com>
 <20181203165833.GA27796@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203165833.GA27796@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_091241_008390_1908C5C8 
X-CRM114-Status: GOOD (  18.03  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Dmitriy Cherkasov <dmitriy@oss-tech.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>,
 linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>, Atish Patra <atish.patra@wdc.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sudeep Holla <sudeep.holla@arm.com>, Anup Patel <anup@brainfault.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-riscv@lists.infradead.org,
 Ingo Molnar <mingo@kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

(Fixed Juri Lelli's email)

On Mon, Dec 03, 2018 at 04:58:34PM +0000, Will Deacon wrote:
> On Thu, Nov 29, 2018 at 03:28:19PM -0800, Atish Patra wrote:
> > Both RISC-V & ARM64 are using cpu-map device tree to describe
> > their cpu topology. It's better to move the relevant code to
> > a common place instead of duplicate code.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/arm64/include/asm/topology.h |  22 ---
> >  arch/arm64/kernel/topology.c      | 303 +-------------------------------------
> >  drivers/base/arch_topology.c      | 294 ++++++++++++++++++++++++++++++++++++
>
> Whilst I'm happy seeing this code moved out, I'd like to have an entry in
> MAINTAINERS so that somebody can review changes from the arm64 side without
> having to poll a load of different lists. I assume patches would still go
> via Rafael and Greg, but if we could have Sudeep added as Reviewer for this
> file, then I'd really appreciate it.
>

Thanks Will for pointing this. I agree with you and like to be added as
reviewer for this.

Since arch_topology.c was mostly added for ARM/ARM64 and by Juri Lelli 
(who is no longer with ARM) and I did review the initial version, I would
like to assume maintenance for this file if both Juri and Greg are OK
with it so that I can keep an eye on this as we expect more changes to
this both for ARM and RISC-V. I am fine if anyone who has contributed
more to this file wants to maintain.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
