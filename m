Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5038FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:01:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F4F206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J4m2AmB+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIqjAlxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F4F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fMd94wG9Hy5T2V5gYR0DzP75SLlJRidQf8XMYVpbY8w=; b=J4m2AmB+vwE9If
	GYLp1wMgYdbK/7OIgtDCdmsStFZoKiOEYZnNCSzc72pknUI8lGyYxpyCyAF88MDQFkZgmQClRJ479
	crmOZCVXmkbdqnl/hyMP904cZyT9eCs3cPcQdh/Kf65AXVqEPt2XpP+hNqJPaqXeMq4Rhbsn9AFj1
	j2LJFYJhgnl6rlByOgm0zU9Ui5MqfMmpnCkyLTHFRSb6Y/qTaedjaQbqhngzp+SAtq+vsCKpWlvL+
	PNnupU3chiEUlIZ2raiMc8Billw43u257qQBV1lMH80+USIqWgvIas4Fsh145zx6PUje1VK4Ui8yJ
	kYjVhGG9mc5gINEHT2xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guezA-0004It-WF; Fri, 15 Feb 2019 15:01:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guez8-0004IH-I0
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:01:03 +0000
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6AD0D207E0;
 Fri, 15 Feb 2019 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550242861;
 bh=AkVBKEMZ0ZYJo67INS81B29Rgu0o9C+VCzGlb/jazs8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MIqjAlxX0GHFbsj9JncL/1H7+IfZ0hRrH34WM4G7PMtnyN5vECPRdt3AsFpFz6117
 HddvhlNMLNhkexjGJ2FGwdZLbxQ0d7/eRetcAGlmpeOChx6WLQwVhNxm0fijb/mXao
 SOXwYKisokyabfcyzOmKHm1s22Lx2L9vDlupxG18=
Date: Sat, 16 Feb 2019 00:00:58 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-Id: <20190216000058.a75ff4d9497065ce216e246d@kernel.org>
In-Reply-To: <20190214155522.GA1825@fuggles.cambridge.arm.com>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
 <154998628802.21869.4041705065539411318.stgit@devbox>
 <20190214155522.GA1825@fuggles.cambridge.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_070102_611020_06E64D05 
X-CRM114-Status: GOOD (  20.47  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 15:55:22 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Hi Masami,
> 
> On Wed, Feb 13, 2019 at 12:44:48AM +0900, Masami Hiramatsu wrote:
> > Use arch_populate_kprobe_blacklist() instead of
> > arch_within_kprobe_blacklist() so that we can see the full
> > blacklisted symbols under the debugfs.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >   Changes in v3
> >    - Do not populate blacklist in __kprobe_text in
> >      arch_populate_kprobe_blacklist(), since it is already
> >      populated in populate_kprobe_blacklist().
> >    - Add exception entry text blacklist since those are rejected
> >      by in_exception_text().
> > ---
> >  arch/arm64/kernel/probes/kprobes.c |   45 +++++++++++++++++++++---------------
> >  1 file changed, 26 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > index 194262fca5cd..37d913f33a89 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -465,26 +465,33 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
> >  	return DBG_HOOK_HANDLED;
> >  }
> >  
> > -bool arch_within_kprobe_blacklist(unsigned long addr)
> 
> I think it would be useful to add a comment here so that we remember
> why this code is the way it is:
> 
> /*
>  * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
>  * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
>  */

Agreed. This looks good to me too.

> 
> With that, you can have my ack for the series:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thank you!

> 
> Catalin -- can you pick these up with that comment added, please?
> 
> Cheers,
> 
> Will


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
