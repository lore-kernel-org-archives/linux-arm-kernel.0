Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4EDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:13:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB3621872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t+vO6TsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB3621872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fw3czNuONszy9rWGAorCv/9Nh9sileuMLnP3gXhmLMo=; b=t+vO6TsSCXISDG
	1FJAOR7+Qv5I2SlXw+RQU+P3QqtqBaT9av06/SpfcItemjilIB1B3jXlso8EMSHidjCEqTe05hL4j
	UBOGDBoTSkpomhawkpYP9C6X1U4LnusT4+envxYiRG18HnavmjZQfl1vSU9PL9HbWLh4OnTtEC+Kw
	iiV5LK35UOfQfHl381vGiHYgwr/dnfZJGA2qfqClsBatSxwLh0HTYceb2rCvNKvPNpXAdlV/ZD+m5
	nNWe3iQbLnCyqGozJ3Tq0sjt5f09pNc4SB2fXyqXyF6IUrkdkacc2zrUO1IVW4/s92v4ffumxX/nX
	agb4o3iPuQ9NZtoHtDbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfMTc-0005SU-8v; Fri, 04 Jan 2019 10:13:16 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMTY-0005S0-84
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 10:13:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B895DEBD;
 Fri,  4 Jan 2019 02:13:11 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84A453F575;
 Fri,  4 Jan 2019 02:13:11 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 074761AE0C51; Fri,  4 Jan 2019 10:13:12 +0000 (GMT)
Date: Fri, 4 Jan 2019 10:13:11 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
Message-ID: <20190104101311.GB24160@edgewater-inn.cambridge.arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103163740.GC3529@e103592.cambridge.arm.com>
 <db5968e6-609b-1a1f-464d-436327dd1738@arm.com>
 <1951199845.271163.1546543806398@email.ionos.de>
 <5818faa8-e820-7aee-5aaa-42ced65d6f9d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5818faa8-e820-7aee-5aaa-42ced65d6f9d@arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_021312_543029_7227FF74 
X-CRM114-Status: GOOD (  24.05  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, mark.rutland@arm.com,
 mlangsdo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, julien.thierry@arm.com, ykaukab@suse.de,
 linux-kernel@vger.kernel.org, steven.price@arm.com,
 Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, shankerd@codeaurora.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Dave Martin <Dave.Martin@arm.com>,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 03, 2019 at 02:32:44PM -0600, Jeremy Linton wrote:
> On 01/03/2019 01:30 PM, Stefan Wahren wrote:
> > > Jeremy Linton <jeremy.linton@arm.com> hat am 3. Januar 2019 um 17:46 geschrieben:
> > > On 01/03/2019 10:37 AM, Dave Martin wrote:
> > > > On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
> > > > > There is a lot of variation in the Arm ecosystem. Because of this,
> > > > > there exist possible cases where the kernel cannot authoritatively
> > > > > determine if a machine is vulnerable.
> > > > > 
> > > > > Rather than guess the vulnerability status in cases where
> > > > > the mitigation is disabled or the firmware isn't responding
> > > > > correctly, we need to display an "Unknown" state.
> > > > > 
> > 
> > i applied your patch series on linux-next-20190103. On my Raspberry Pi 3B+ (defconfig) i'm getting this from sysfs:
> > 
> > l1tf:Not affected
> > meltdown:Not affected
> > spec_store_bypass:Unknown
> > spectre_v1:Mitigation: __user pointer sanitization
> > spectre_v2:Unknown
> > 
> > AFAIK it has 4 Cortex-A53 cores (no PSCI firmware), so shouldn't be affected.
> 
> So, for spec_store_bypass, as you noted your getting hit by the lack of
> psci/smccc to report the ssb state, and this patch is just reflecting that.
> 
> In the case of spectrev2 it may be correct to blame this patch set because
> its displaying "unknown" since your core isn't in the black list, and your
> core isn't new enough to have the csv2 bit indicating its not vulnerable. In
> this case if we do away with the unknown state, we should probably depend
> entirely on the black list and simply display "Not affected" if the core
> isn't listed. (meaning we may report cores not affected when they are
> missing from the blacklist).
> 
> 
> > How can this be fixed?
> 
> For ssb, the correct answer is probably fix the firmware, but given the
> situation, its likely this kind of machine is going to force an additional
> MIDR list to report the state correctly. Maybe Will or someone can chime in
> here?

Marc Z is already working on this iirc, since we need it to fix the message
printed to dmesg about the mitigation status anyway.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
