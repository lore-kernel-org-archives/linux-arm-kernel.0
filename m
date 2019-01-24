Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7931BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:40:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F7B21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a5cCnpEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F7B21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rIZlUBs3hBU9yOxQ32xcR0WwZCCydbgb6sW1Q2Jg7dM=; b=a5cCnpEesX03kM
	sXOF9ABBd1Ihg/soMZPRMUPBz87PUSHDlvOFz/bbEitHpB9UnXh3FWhkLdNDyfK2ISqKL2KAzNHt4
	uIC6VEenxJ+9FskxkjwpMG/x/wpg277IdmUR6Mol5nkS0ChO7tWltZtJ+J5DFcx7rwT8dzEm6mME3
	+8bn8Go0Ektbx3A+vHBJeid4M+EnQ6XffzNwUJjxvH48gSk6SRNTUD2ZVRLbj1iQUfpY3L/vUzE8P
	BOuutNajF5QldlxPytUjQf3CMytURHIx7GXUryGgulbpYIzdRs/VKAh8NVlhdzaokkOwJPNtxbS16
	SrzcUmxe7cYli+6LdUNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmcQS-0006wW-J9; Thu, 24 Jan 2019 10:40:00 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmcQP-0006vx-41
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 10:39:59 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 892492084E; Thu, 24 Jan 2019 11:39:53 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr
 [109.213.9.46])
 by mail.bootlin.com (Postfix) with ESMTPSA id 46C5820798;
 Thu, 24 Jan 2019 11:39:43 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] cpufreq/armada-37xx: Parent clock issues after boot
References: <20190124103052.dvkg43uwieejoupo@vireshk-i7>
Date: Thu, 24 Jan 2019 11:39:43 +0100
In-Reply-To: <20190124103052.dvkg43uwieejoupo@vireshk-i7> (Viresh Kumar's
 message of "Thu, 24 Jan 2019 16:00:52 +0530")
Message-ID: <87bm46jq4w.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_023957_447648_191BE168 
X-CRM114-Status: GOOD (  23.37  )
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
>   that, this all is done before enabling DVFS specific bits, which
>   will make us play with non-DVFS registers and we don't want that,
>   isn't it ?
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

Thanks for your very detailed bug report and for your first
investigations. I will have a look on it very soon.

Gregory

>
> -- 
> viresh
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
