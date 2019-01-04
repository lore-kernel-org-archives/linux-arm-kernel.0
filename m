Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1BAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:18:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2498D208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="beyBY/14";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw1791Uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2498D208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZxL03G+9oDI5A4SEsKSJB+lVv8MFkWJb0ga4b7Y03Us=; b=beyBY/14OxuI4g
	KahnoqO/XdvPhNF+jSsZj3QuwUXqjwcDBkYgkBZolXGg5t+HbJbylVAoAuht1U1FkDq2HYefvLyMm
	PTaivEojPzPCnkkFbUdQrk9cL1OUKlizJsj0tL9gGmyT3rZsA9cK/NKJkjwu1ck9IPa1z84a8+e3z
	Dr+CkQJDdu07t8yxIxdzgla+r7+1WRcNXGxmtEoH64TbhXGIIhAgNwNrLWQF7DKEeFIlSel9YXOQ4
	7J2JG5QY9ALB3UbJFbidXFfjJh+tbU/dGyhjryIHb8Ixiix1Tfkd2qoIazVJFvH5PodIl/wzijQtF
	gqsXMAHPLbKchGBjPYXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfQIe-0000rm-I8; Fri, 04 Jan 2019 14:18:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfQIb-0000rH-83
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 14:18:10 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9751B208E3;
 Fri,  4 Jan 2019 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546611488;
 bh=lvh/revn/Ntxo2/w0uYzO0T0Wis5FHhyYbshoEFusdA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cw1791UkRLdC77XIzT6wQ2JVvIaXhrvUyiwU9L/9hx37uh2B7kXX1YvTF+/CHAsl+
 TGKnu8tUJomrgNk1hNtAm9TQrvhTzr05iqf5dwyoRlqcs670BcIFHbt7btVFajlI0x
 OmAo+sGYGGpKBuB6RSYrGQ2iZ2ET2DiGzqW2yFko=
Date: Fri, 4 Jan 2019 15:18:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
Message-ID: <20190104141805.GA15939@kroah.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103093858.GA10794@kroah.com>
 <c9e08010-3ca0-cb03-e5ad-ab19342ff63b@arm.com>
 <20190103164831.GF14994@kroah.com>
 <20190104140832.GC3571@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104140832.GC3571@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_061809_319626_4BA66590 
X-CRM114-Status: GOOD (  28.27  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, mlangsdo@redhat.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, steven.price@arm.com,
 Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, shankerd@codeaurora.org, ykaukab@suse.de,
 Thomas Gleixner <tglx@linutronix.de>, suzuki.poulose@arm.com,
 David Woodhouse <dwmw@amazon.co.uk>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 02:08:32PM +0000, Dave Martin wrote:
> On Thu, Jan 03, 2019 at 05:48:31PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Jan 03, 2019 at 10:38:16AM -0600, Jeremy Linton wrote:
> > > On 01/03/2019 03:38 AM, Greg Kroah-Hartman wrote:
> > > > On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
> > > > > There is a lot of variation in the Arm ecosystem. Because of this,
> > > > > there exist possible cases where the kernel cannot authoritatively
> > > > > determine if a machine is vulnerable.
> > > > 
> > > > Really?  Why not?  What keeps you from "knowing" this?  Can't the
> > > > developer of the chip tell you?
> > > 
> > > There tends to be a few cases, possibly incomplete white/black lists,
> > 
> > Then fix the lists :)
> > 
> > > firmware that isn't responding correctly, or the user didn't build in the
> > > code to check the mitigation (possibly because its an embedded system and
> > > they know its not vulnerable?).
> > 
> > If the firmware doesn't respond, that would imply it is vulnerable :)
> > 
> > And if the code isn't built in, again, it's vulnerable.
> > 
> > > I would hope that it is an exceptional case.
> > 
> > Then have the default be vulnerable, don't give people false hope.
> > 
> > > > > Rather than guess the vulnerability status in cases where
> > > > > the mitigation is disabled or the firmware isn't responding
> > > > > correctly, we need to display an "Unknown" state.
> > > > 
> > > > Shouldn't "Unknown" really be the same thing as "Vulnerable"?  A user
> > > > should treat it the same way, "Unknown" makes it feel like "maybe I can
> > > > just ignore this and hope I really am safe", which is not a good idea at
> > > > all.
> > > 
> > > I tend to agree its not clear what to do with "unknown".
> > > 
> > > OTOH, I think there is a hesitation to declare something vulnerable when it
> > > isn't. Meltdown for example, is fairly rare given that it currently only
> > > affects a few arm parts, so declaring someone vulnerable when they likely
> > > aren't is going to be just as difficult to explain.
> > 
> > If you know it is rare, then you know how to properly detect it so
> > "unknown" is not needed, correct?
> > 
> > Again, "unknown" is not going to help anyone out here, please don't do
> > it.
> 
> Thinking about it, "unknown" is actually the common case.
> 
> Kernels that predate the sysfs vulnerabilities interface effectively
> report this for all vulnerabilities by omitting the sysfs entries
> entirely.
> 
> Current kernels also don't know anything about future vulnerabilities
> that may be added in sysfs later on (but which may nevertheless be
> discovered subsequently to affect current hardware).
> 
> So, can we simply omit the sysfs entries for which we can't provide a
> good answer?

As you say, we already do this for older systems.

But don't add new logic to explicitly not create the files just because
we "can not figure it out".  For those systems, I would default to
"vulnerable" as I think that's what we do today, right?

thanks,
g
reg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
