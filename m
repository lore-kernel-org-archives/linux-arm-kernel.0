Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9A4C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:54:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05287218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lkeKwx9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05287218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I2RSpbFP0de+z2FlwjcgCLhohgjMAODFKs3Mr9IkLTU=; b=lkeKwx9vq7u55E
	9O0w9innK/zbbGgglu5Wyj7B/nVs4l0emIwpaMuLuY1LqTWxajG6PZGjsBZT/ganiQky2cMbOG7Zk
	uS+i7UHCEWe9bLo11fctGoIQqhTM31MSizgst3xcaH1TkkxXKUg/0YzYn8BMzNW8jQZytX1DFWtV9
	vXF/AvUiPQCNcNFtQHbjDmXP0KjzT+t5u0p3zGn3vY5vVY5xFMnFE3PYSMnwmysneKfKIa5yAzQC+
	rPOT8Rep5bLwfU2JgoucRlhj6l0mj1JuQxCiXsTp39goxNYf4BMlSCBAGVUMs+k4yaGPqgXPsOBRw
	4v2o2NkIqR6xWqktinJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5go-00076L-7v; Fri, 25 Jan 2019 17:54:50 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5gf-0006wh-3N
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 17:54:43 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id EF2652078F; Fri, 25 Jan 2019 18:54:37 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 by mail.bootlin.com (Postfix) with ESMTPSA id DC5BC20A15;
 Fri, 25 Jan 2019 18:54:20 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] cpufreq/armada-37xx: Parent clock issues after boot
References: <20190124103052.dvkg43uwieejoupo@vireshk-i7>
Date: Fri, 25 Jan 2019 18:54:21 +0100
In-Reply-To: <20190124103052.dvkg43uwieejoupo@vireshk-i7> (Viresh Kumar's
 message of "Thu, 24 Jan 2019 16:00:52 +0530")
Message-ID: <87imychbci.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_095441_452815_6B809773 
X-CRM114-Status: GOOD (  26.13  )
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, rjw@rjwysocki.net,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Viresh,
 
 On jeu., janv. 24 2019, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Hi Gregory,
>
> Ilias has an espressobin board and he reported performance regression
> while playing with cpufreq governors.
>
> I have tried to track it down in the last couple of days with Ilias
> testing the kernel with my suggestions. We strongly believe that there
> is something wrong with parent clock selection in the clk driver.
>
> Simple way to reproduce the issue:
>
> - configure kernel with performance and powersave governors, make
>   performance governor default and boot the kernel.
>
> - Run "sysbench --test=cpu run" and note down performance numbers.
> - Do following to force a freq change by kernel:
>   echo powersave > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
>   echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
>
> - Run sysbench again and you will see 20% drop in performance.
>
> The problem happens as soon as the kernel changes the frequency for
> the very first time. Probably because that's when we change the
> clk-parent for the very first time.
>
> Few more things I noticed:
>
> - During boot when the kernel adds the CPU clk to clk-framework, we
>   read the registers from the non-DVFS set as DVFS wasn't enabled yet.
>   So both parent and clock rate are read from there.
>
> - But cpufreq starts working with the other set of registers which are
>   available only after DVFS is enabled.
>
> - We call clk_get_parent() followed by clk_set_parent() in
>   armada37xx_cpufreq_dvfs_setup(). I am not sure what you wanted to do
>   here as these two statements may not have any affect as you pass the
>   return value of clk_get_parent() to clk_set_parent(). Because the
>   clk framework will match the new parent with cached value of old
>   one, it wouldn't change anything at all at hardware level. Over

This is exactly where the issue is come from. My intent was to use the
same parent that was used at boot time. And the trick was that when we
set the clock parent actually it only set the DVFS case. But I didn't
realized that it didn't match at all what it is done in clock framework.

>   that, this all is done before enabling DVFS specific bits, which
>   will make us play with non-DVFS registers and we don't want that,
>   isn't it ?

Well the idea was to modify the DVFS register before we enable
DVFS. Indeed modifying the parent clock of a CPU while we use it could
be a little tricky.

I have some ideas to fix this issue: I won't use anymore
get_parent/set_parent in the cpufreq driver and I will set the DVFS
parent clock during the initialization at the clock driver level. I need
to do some tests to be sure of the implementation and once it was done I
will CC you with the patch for the fix.

Gregory

>
> - We checked the divider values right from the registers before moving
>   to powersave and after moving back to performance. We are at
>   load_level 0, which means parent clock gets passed as is. So the
>   divider should be fine, only thing left is parent clock.
>
> I am attaching two files here, one of them is the debug patch I wrote
> to test this and the second one shows those debug prints during
> different phase of testing.
>
> Thanks in advance for helping out.
>
> -- 
> viresh
>
>
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
