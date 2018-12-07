Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06880C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:46:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4B22082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JihA7K5g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xmck1bS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4B22082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PcgeJPMwfw/uxFjc8EadXpC+YUyKvO8iqY+WIN7rWH8=; b=JihA7K5g8hV9v/
	qnwtErBpdx5K+IjGq1c59CIvKhz24wSWvIu6uFwxeDw/weqHbqAhvbS0VBiRA9imFhtLDHN2mmq8f
	s6qcDpwkkh4F2e3CPsvKAlQwpVA6evIaym5SbznV2Z9jP6EOuRX0pXgUiluJBR+vDWXuJxwrdO+gQ
	AdNn9sNPuoA5Oz0zNWP6pbDZTLMaCWc7GiXfacbRjnayMaslDC/lLc0UVzOXgh2zfAHhyXAv3GlQE
	hjfse/ja2m/1hPybGDxvjs0xw//HYGKnOrHXhmxVGR6B1MBUEEUPe3EQ9u5SxQKGnHX2babo5jWGB
	tYjwF95EjvrTufuiHblw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVL8T-0002kF-RN; Fri, 07 Dec 2018 18:46:01 +0000
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVL8O-0002fB-8Q
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:45:58 +0000
Received: by mail-vk1-xa43.google.com with SMTP id w72so1173177vkd.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 10:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SRCkAV/rwwCb6G1s504cXx97lfWxm12ZTF5AciiY020=;
 b=Xmck1bS0DtZaa+WeJixKR5fKXvJ0b/KkgVumJ+cB+BRhf2dA1IB3yHuUry37zHpQs6
 zaxAXd4KG8ZJT1/0HnMFp9V5QWu3sIojUVz3n8BmfxYYfJvsAIizcUxSgPQrz5Rov1t2
 CbtwE330HXlFJIaGEy1i92cSc9oRewduTt9lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SRCkAV/rwwCb6G1s504cXx97lfWxm12ZTF5AciiY020=;
 b=pFZVv/l+ZMxtaG7N3kooElOVFwcv3fESwCiJO0sZDCIKUWCJVM73cOqys5VaX+hzwZ
 wg4ONsP81K8XzR583b4JE5e6vvmzBo8tDdkbUaPTmN0dVCTRRJx7GP5wXFaHIIWENuj2
 Q7ACX5RwMcIf3pHdDE5Dav4i0k9kiLNa43TVsb7yoqbkdsrmpq2fWY58jfrzMiAOlAfD
 Pw4Q4sAogHG0sM9YmDqzuafnCKi5sqVN9X9e43Vi9hriWQd76PrFlXocsVMAN/MHflkw
 qNMjxipaI66oSk3wW3Rt33MrnLk8L6XZMbN7ra6REBg1S1kFavnOCtClK/+Wj0Rw9oKo
 IqDQ==
X-Gm-Message-State: AA+aEWZsK+50ZqwB0kp9sALB9ubfH9icWdkgIK+qlzLxQoA1yJYoG3gU
 HUQ6e3ZRHe3kW2YENMwrLAOGSg8Ulw0=
X-Google-Smtp-Source: AFSGD/XyCKNtYUqUBbNcget7nKtzUAcQ+dvVnVkmysz8oP1jhoP8JzE1/NItbyshkknplO3HpCa4hA==
X-Received: by 2002:a1f:9604:: with SMTP id y4mr1341489vkd.28.1544208344474;
 Fri, 07 Dec 2018 10:45:44 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42])
 by smtp.gmail.com with ESMTPSA id d7sm1252731vke.12.2018.12.07.10.45.44
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 10:45:44 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id h18so3043933vsj.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 10:45:44 -0800 (PST)
X-Received: by 2002:a67:dd11:: with SMTP id y17mr1406802vsj.111.1544208038051; 
 Fri, 07 Dec 2018 10:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20181205033828.6156-1-dianders@chromium.org>
 <20181207174231.GD11961@arrakis.emea.arm.com>
In-Reply-To: <20181207174231.GD11961@arrakis.emea.arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 7 Dec 2018 10:40:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WO2xMojkEqKCMkufwihUvnow3yEH4GZPh7hh8noNZ+=A@mail.gmail.com>
Message-ID: <CAD=FV=WO2xMojkEqKCMkufwihUvnow3yEH4GZPh7hh8noNZ+=A@mail.gmail.com>
Subject: Re: [REPOST PATCH v6 0/4] kgdb: Fix kgdb_roundup_cpus()
To: Catalin Marinas <catalin.marinas@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_104556_324057_CED804DA 
X-CRM114-Status: GOOD (  14.54  )
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
Cc: mhocko@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 kgdb-bugreport@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, dalias@libc.org, paulus@samba.org,
 mpe@ellerman.id.au, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, ying.huang@intel.com, jhogan@kernel.org,
 linux-snps-arc@lists.infradead.org, rppt@linux.vnet.ibm.com, bp@alien8.de,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, christophe.leroy@c-s.fr,
 Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org, paul.burton@mips.com,
 Jason Wessel <jason.wessel@windriver.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, Dec 7, 2018 at 9:42 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Dec 04, 2018 at 07:38:24PM -0800, Douglas Anderson wrote:
> > Douglas Anderson (4):
> >   kgdb: Remove irq flags from roundup
> >   kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
> >   kgdb: Don't round up a CPU that failed rounding up before
> >   kdb: Don't back trace on a cpu that didn't round up
>
> FWIW, trying these on arm64 (ThunderX2) with CONFIG_KGDB_TESTS_ON_BOOT=y
> on top of 4.20-rc5 doesn't boot. It looks like they leave interrupts
> disabled when they shouldn't and it trips over the BUG at
> mm/vmalloc.c:1380 (called via do_fork -> copy_process).
>
> Now, I don't think these patches make things worse on arm64 since prior
> to them the kgdb boot tests on arm64 were stuck in a loop (RUN
> singlestep).

Thanks for the report!  ...actually, I'd never tried CONFIG_KGDB_TESTS
before.  ...so I tried them now:

A) chromeos-4.19 tree on qcom-sdm845 without this series: booted up OK
B) chromeos-4.19 tree on qcom-sdm845 with this series: booted up OK
C) v4.20-rc5-90-g30002dd008ed on rockchip-rk3399 (kevin) with this
series: booted up OK

Example output from B) above:

localhost ~ # dmesg | grep kgdbts
[    2.139814] KGDB: Registered I/O driver kgdbts
[    2.144582] kgdbts:RUN plant and detach test
[    2.165333] kgdbts:RUN sw breakpoint test
[    2.172990] kgdbts:RUN bad memory access test
[    2.178640] kgdbts:RUN singlestep test 1000 iterations
[    2.187765] kgdbts:RUN singlestep [0/1000]
[    2.559596] kgdbts:RUN singlestep [100/1000]
[    2.931419] kgdbts:RUN singlestep [200/1000]
[    3.303474] kgdbts:RUN singlestep [300/1000]
[    3.675121] kgdbts:RUN singlestep [400/1000]
[    4.046867] kgdbts:RUN singlestep [500/1000]
[    4.418920] kgdbts:RUN singlestep [600/1000]
[    4.790824] kgdbts:RUN singlestep [700/1000]
[    5.162479] kgdbts:RUN singlestep [800/1000]
[    5.534103] kgdbts:RUN singlestep [900/1000]
[    5.902299] kgdbts:RUN do_fork for 100 breakpoints
[    8.463900] KGDB: Unregistered I/O driver kgdbts, debugger disabled

...so I guess I'm a little confused.  Either I have a different config
than you do or something is special about your machine?


NOTE: In general I've never considered "single step" as reliable in
kgdb.  I mostly use kgdb as "after the fact" crash debugging to
analyze local variables / memory / other tasks.  If it worked that'd
actually be kinda great, but at least when I started using kgdb years
ago I learned that it didn't work and stopped trying...


-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
