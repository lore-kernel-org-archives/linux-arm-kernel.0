Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5BCC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:48:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2968220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y9P9Jy0B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kt6u5UkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2968220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bf89enpeKyoG4D6IM4fEyqLks72bBRvoq2SMpH+pg6g=; b=Y9P9Jy0BENEW60
	vu/ApPu0Ku/C7alW59/1+9MEW7xxprGckIKe3J1P2uXtLWxjLhBUwtMo6rgOIQfsk1zSYGBg/0lVH
	kbdqLPaWOzC2EL/DzKMykYITR5FmfAeJkUOfZ97z113elVQKjCP8PGL+qn5tYnuMpkY7yy++5ijs5
	ZPxMucIUgazsWPZV8VPRIln1RoSiViXjgcWz7f4OKr/zvJ+GuRlpWRQt+o5svH3ay38GrpPNxovXi
	vcz/RXBqBON4VQB6rLC6vc9K3nQmHBuNpnDzjgDCNHi+6SibC4zcVdXiDgQcYT2H08s1Gt6wFVGLb
	yge3M7HY6sh0fbh7fzuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWuZm-0001Vw-CC; Wed, 12 Dec 2018 02:48:42 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWuZX-0001Ij-RQ
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 02:48:29 +0000
Received: by mail-pg1-x541.google.com with SMTP id w7so7579145pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 18:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Nm3XErZxq1V23HwchQFuq7pdH5x+uYeR5VK4HABXJAA=;
 b=kt6u5UkOKGq+hTC+9btenOOh0cjJaftqyRraaYDJinXFiXMf0Q3upcacttmhTJ02bh
 unAzrA+TsV0Q3OlvJguntKmGqRCD1cMkLKD6fLqQSdZQ4ZSLTGTv29Znh8nClpFHTJuE
 HUSjYnMU7dSly/0xaKv8FlW+CPY1u/3Uc9vtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=Nm3XErZxq1V23HwchQFuq7pdH5x+uYeR5VK4HABXJAA=;
 b=F0ozyVWxtmNtinfXXytXTpYSVWg+/JAqtbviJ7cRQhFbp0zHXrMk4AIXcnSomenf+R
 0tuNiSpdyHNouxXp/gLHeUmoWIVtj+yBjtrNbO2JK86fOrnam60OtkJ9FmKpkjAQSmvG
 XcsoCWrsY6vfG2gegY3r3CH7Y3R3icy3hnNK9U29UM1xmRVQreqyS9LzbHvHWa24KRVY
 ZYuDx4dueSM4L/OpQ+VaWeIfB2f3K/bBQPwcnlI2tCfoQQa20VesUuS4bdYZRZhoJF0H
 ogBOyX6zu84fSR1U62P7i1JuhA7f2mb+zJGJdKRSAOQhtzcbPE5cU5eMS8IJhWGHu7ma
 pzcQ==
X-Gm-Message-State: AA+aEWbN0dK4E3sreUG4cZhf5yhZ44E1nJ9Ape8ZYQbMEdxFu4PDC0MH
 gGX4lj9IkL2GsCGwo8ZyQ8sryph+9yQ=
X-Google-Smtp-Source: AFSGD/W5gP1Qi0aUwP9j2RQvU6uNklf0ZsNs6rqSmDdN1Y+6lFxQyrqwLCH4Y47cNY9qX1EGHp8NPQ==
X-Received: by 2002:a62:5884:: with SMTP id
 m126mr18604345pfb.177.1544582896672; 
 Tue, 11 Dec 2018 18:48:16 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
 by smtp.googlemail.com with ESMTPSA id
 q187sm28401988pfq.128.2018.12.11.18.48.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 18:48:16 -0800 (PST)
Date: Wed, 12 Dec 2018 11:51:32 +0900
From: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
To: James Morse <james.morse@arm.com>
Subject: Re: arm64: kdump broken on a large CPU system
Message-ID: <20181212025131.GL21466@linaro.org>
Mail-Followup-To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Qian Cai <cai@lca.pw>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <113776f1-5633-e397-96eb-c533ea79671d@lca.pw>
 <29f74c6d-dd21-dcee-6c62-914f018c4e4e@arm.com>
 <7f467952-342b-71e2-c553-ff53ecc1812e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f467952-342b-71e2-c553-ff53ecc1812e@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_184827_954476_6F98CB2E 
X-CRM114-Status: GOOD (  33.03  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Qian Cai <cai@lca.pw>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 11:34:22AM +0000, James Morse wrote:
> Hi Qian, Marc,
> 
> On 11/12/2018 10:09, Marc Zyngier wrote:
> > On 10/12/2018 22:30, Qian Cai wrote:
> >> On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash dump just
> >> hung (4.20-rc6 as well as 4.18). It was confirmed that the executing went as far
> >> as entering __cpu_soft_restart(),
> > 
> > You can forget about 4.18 altogether, it will never correctly kexec.
> > I've used 4.20 + kexec on a TX2 system though, and although it takes
> > absolutely ages, it reliably works.
> 
> >> __crash_kexec
> >>   machine_kexec
> >>     cpu_soft_restart
> >>       restart
> >>         __cpu_soft_restart

@Qian, how did you confirm that you reached here?

> >>
> >> The earlycon was enabled but had no output from the 2nd kernel, so it was pretty
> >> much stuck in all those assembly code in arm64/kernel/head.S or the early part
> >> of start_kernel() before earlycon was initialized.
> > 
> > Could it instead be in the purgatory code provided by userspace?
> 
> Yes, this could be anything between entering __cpu_soft_restart(), purgatory and
> the earlycon driver in the new kernel.

To be in purgatory, or not to be, that is the question.
(I'm serious.)

> 
> >> It turned out this has something to do with nr_cpus in the 1st kernel, although
> >> the 2nd kernel always has nr_cpus=1 [1]. It was tested with both
> >> crashkernel=512M or 768M.
> > 
> > James was saying something about a timeout, which may or may not be long
> > enough.
> 
> This comes from arch/arm64/kernel/smp.c:crash_smp_send_stop()
> It sends IPIs to all other CPUs, then waits one second before timing-out.
> This may not be enough time for a system with hundreds of CPUs.
> 
> Increasing the timeout may help, but I don't understand why extra CPUs would
> matter if we're getting as far as __cpu_soft_restart().

Indeed.

> 
> >> nr_cpus <= 96  GOOD (2nd kernel was up in 2-3 mins.)
> >> nr_cpus=256    BAD  (2nd kernel was NOT up after 1 hour.)
> >> nr_cpus=127    BAD  (2nd kernel was NOT up after 10 mins.)
> >>
> >> I did also test with and without CONFIG_ARM64_VHE (i.e., el2_switch) made no
> >> difference.
> 
> >> [1] KDUMP_COMMANDLINE_APPEND="irqpoll nr_cpus=1 swiotlb=noforce reset_devices"
> 
> >> I am still figuring out a way to debug those assembly code to where it actually
> >> hung, 

In my experiences, I have used the patch I mention below
as well as a hw debugger, DS-5 with FVP in my case, for examining
purgatory-related issues.


> There were some earlier patches to purgatory to let it write the console, but
> this didn't scale as purgatory isn't an operating-system. (Reducing purgatory to
> be as simple as possible is better, with kexec_file_load() we don't use it all.)
> 
> If kexec-tools still has a 'ARM64_DEBUG_PORT' you may be able to get it to write
> to your uart. (no idea which uarts it supports, or how it tells pl011 and 8250
> apart).

@James, are you sure? I don't see it.
@Qian, I can give you a small patch of enabling printf in purgatory,
although it's quite hacky, if you want.
(As thunder X2 has a pl011, the patch should work.)

> Some threads to pull on:
> https://patchwork.kernel.org/patch/6121951/
> https://patchwork.kernel.org/patch/9238475/
> (search for 'TX as the first port?' in the last one)
> 
> 
> >> but the server was hooked up with a conserver that was not able to
> >> generate any sysrq and I have no shell access to the conserver, so seems a bit
> >> difficult to use kgdb or kdb in this case.
> 
> More recent kexec tools has a 'lite' or 'no-checks' option that tells it not to
> bother checksumming the kdump kernel.

Are you sure? I remember that Geoff's original patch was rejected.

> This is what takes a long time as its done
> without the MMU+caches enabled.

Pratyush has a patch of enabling MMU in purgatory, but again
it was rejected.

Thanks,
-Takahiro Akashi

> It shouldn't be possible for the old-kernel to corrupt it, as its not mapped
> unless its being loaded (or save/restored by hibernate). I'm not sure how the
> crash-regs get written to the elfcore header though...
> 
> 
> Thanks,
> 
> James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
