Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C82C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:29:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D0821783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WVm4mLjw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kf8vx4Ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D0821783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LhKrtoQxXNvNI5d44LwLYB2yFq7Z0K63A+o4B2dVV+U=; b=WVm4mLjwvERQ+j
	tlqPHsEyhrxvoikuPwP38eGj5w84LBOHmRLepZQq5yFonrunstae5EHaLf4SN4hIiWWjQZczTt6qS
	Zr4prTcRiQfTvehoryCzvV6tl48r5xo1VqC5cxC0FufPbm/2hOQVxTLufvlrsg4cWZo4TS1NuZNMz
	CBoJC+Rv4gsMD8yJsJLZaW4tcfyPevnknzf5bPQ9JAkd1PzHMEEgHRXG8+tgxnnhukAY05EOgthOp
	9kMl2rXPRSLtPPxf/P0aC01xAHQfjmmg42GAnJJzGd8QwBJFlZEY09eTc/AQRB3aIGXXOdsiP8QKm
	1IUC6I8T/7UOEUZ1deQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghuzu-0007Gf-MX; Fri, 11 Jan 2019 11:29:10 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghuzf-00072s-9N
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:28:58 +0000
Received: from zn.tnic (p200300EC2BCAC5006CCD8D4D75E662CE.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bca:c500:6ccd:8d4d:75e6:62ce])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4DD91EC03DB;
 Fri, 11 Jan 2019 12:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1547206127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hCfXYtQjUYbpfemdO/BMKeV7KyCEeg9EzgbAR4onQaM=;
 b=kf8vx4Ds58lhzBpSZx0kkKyt1+ja5ObmR+3a331sGWk1ZqQRce3wBwLmP4y61squ0aHDh9
 rUEXhymnTCgkSdcIq5DNNBG7xvUBP4w6EyI1cLe1emdOqjs8HzTGgQZ+Egr2ZZ0cfFArL0
 Q14SuAC2zP9ffp8oRxKesLOjxHtsWyM=
Date: Fri, 11 Jan 2019 12:28:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>
Subject: (ghes|hest)_disable
Message-ID: <20190111112840.GB4729@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_032855_632968_9432A661 
X-CRM114-Status: GOOD (  13.89  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ok,

lemme split this out into a separate thread and add Tony.

On Thu, Jan 10, 2019 at 06:20:35PM +0000, James Morse wrote:
> > Grrr, what an effing mess that code is! There's hest_disable *and*
> > ghes_disable. Do we really need them both?
> 
> ghes_disable lets you ignore the firmware-first notifications, but still 'use'
> the other error sources:
> drivers/pci/pcie/aer.c picks out the three AER types, and uses apei_hest_parse()
> to know if firmware is controlling AER, even if ghes_disable is set.

Ok, that kinda makes sense.

But look what our sparse documentation says:

        hest_disable    [ACPI]
                        Disable Hardware Error Source Table (HEST) support;
                        corresponding firmware-first mode error processing
                        logic will be disabled.


and from looking at the code, hest_disable is kinda like the master
switch because it gets evaluated first. Right?

Which sounds to me like we want a generic switch which does:

	apei=disable_ff_notifications

to explicitly do exactly that - disable the firmware-first notification
method. And then the master switch will be

	apei=disable

And we'll be able to pass whatever options here instead of all those
different _disable switches which need lotsa code staring to figure out
what exactly they even do in the first place.

> x86's arch_apei_enable_cmcff() looks like it disables MCE to get firmware to
> handle them. hest_disable would stop this, but instead ghes_disable keeps that,
> and stops the NOTIFY_NMI being registered.

Yeah, and when you boot with ghes_disable, that would say:

	pr_info("HEST: Enabling Firmware First mode for corrected errors.\n");

but there will be no notifications and users will scratch heads.

> (do you consider cmdline arguments as ABI, or hard to justify and hard to remove?)

I don't, frankly. I guess we will have to have a transition period where
we keep them and issue a warning message that users should switch to
"apei=xxx" instead and remove them after a lot of time has passed.

> I don't think its broken enough to justify ripping them out. A user of
> ghes_disable would be someone with broken firmware-first handling of AER. They
> need to know firmware is changing the register values behind their back (so need
> to parse the HEST), but want to ignore the junk notifications. It doesn't sound
> like an unlikely scenario.

Yes, that makes sense.

But I think we should add a generic cmdline arg with suboptions and
document exactly what all those do. Similar to "mce=" on x86 which is
nicely documented in Documentation/x86/x86_64/boot-options.txt.

Right now, only a few people understand what those do and in some of the
cases they do too much/the wrong thing.

Thoughts?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
