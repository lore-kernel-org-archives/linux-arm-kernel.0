Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D05C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D18D20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gGX9cLph";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WqVNn4dy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HbbSoRZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D18D20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iVv6OHBgA+mUJk3RZ/SwnF/srhzP5K3OyvV7XabSbrs=; b=gGX9cLphH/YF2IkTxDnyKpjww
	ROW7+ctPnekH64hDge3ULFNkAEIYoa93uQtN3LM66cn+iinvrIRQQE1GZU3LCP0cX3ThtPuBYzKRF
	f4ROOboEsGZefdXOTR6yGroR1lfi42Kqo67kQKz0qke6WduphtiVvBST63GygVe+++z8BJx3VUhTR
	9OdLiarqtknmmAx2HYmfFfckrKkN/H4AhFu0gE6uGWMkgxJ3Cb+ADeLejleCRlTSU69THLGIdHNQw
	FJpBZiIyameLjbitMHQWarnASK8V3kkLb/Oe8cAqBsgOxhe+992rbIqpMYREoYGvqh1LYPyb7Q4Ne
	2r7Sy4+YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzWV-000434-OS; Wed, 13 Feb 2019 18:44:43 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzWS-00042c-N8
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:44:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 93FB2611E4; Wed, 13 Feb 2019 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550083480;
 bh=F87YOsPP9BTuLaqkEIDa5weDH2iiqGmOdN1YadkeJNE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=WqVNn4dybPH4L13jYtx3QeyJZ4eIrjVEaAG7eL7r29wHF1HFF6z04+Gp6fu3OJA9v
 CmqF28+rsil55xZP0WOoYTT2X51d3DpOLsgo/CgXFQ4GdWdVPnOGZ5kaw7yBzIveEC
 Mkc8bj2SnBizmvg3nVpbkkqWG5Hn8L2sY7ZRh4Z0=
Received: from [192.168.1.101] (unknown [157.45.221.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D09CE60C3D;
 Wed, 13 Feb 2019 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550083476;
 bh=F87YOsPP9BTuLaqkEIDa5weDH2iiqGmOdN1YadkeJNE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=HbbSoRZ5E3D57TggqaplIL+7LSjb29zLnCED9DNxSum0WaWnR7UFps049LRVuzIxO
 0/g57YacSkEb3vZzDguBsT2lVOq2Q1X2snOSqR/VPc1HoLb18wV+R4nhDVxcx3czm5
 XRF6NSeHQpW19w4XS0XWYsWnqge6xdSegmMHkJxM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D09CE60C3D
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/rwsem.c:65
To: Pintu Agarwal <pintu.ping@gmail.com>
References: <CAOuPNLgaDJm27nECxq1jtny=+ixt=GPf2C7zyDsVgbsLvtDarA@mail.gmail.com>
 <6183c865-2e90-5fb9-9e10-1339ae491b71@codeaurora.org>
 <CAOuPNLgUvECE6XBjszFggY3efmEBKywzKNWupjfQ2svsCMqd7w@mail.gmail.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <2c91af7d-4580-cedc-70ea-d38c2587c7bf@codeaurora.org>
Date: Thu, 14 Feb 2019 00:14:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAOuPNLgUvECE6XBjszFggY3efmEBKywzKNWupjfQ2svsCMqd7w@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_104440_791144_6FBD6126 
X-CRM114-Status: GOOD (  21.10  )
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
Cc: linux-rt-users@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 "Xenomai@xenomai.org" <xenomai@xenomai.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2/13/2019 8:10 PM, Pintu Agarwal wrote:
> OK thanks for your suggestions. sdm845-perf_defconfig did not work for
> me. The target did not boot.

Perf defconfig works fine. You need to enable serial console with below
config added to perf defconfig.

CONFIG_SERIAL_MSM_GENI_CONSOLE=y

> However, disabling CONFIG_PANIC_ON_SCHED_BUG works, and I got a root
> shell at least.

> 
> But this seems to be a work around.
> I still get a back trace in kernel logs from many different places.
> So, it looks like there is some code in qualcomm specific drivers that
> is calling a sleeping method from invalid context.
> How to find that...
> If this fix is already available in latest version, please let me know.
> 

Seems like interrupts are disabled when down_write_killable() is called.
It's not the drivers that is calling the sleeping method which can  be
seen from the log.

[   22.140224] [<ffffff88b8ce65a8>] ___might_sleep+0x140/0x188
[   22.145862] [<ffffff88b8ce6648>] __might_sleep+0x58/0x90         <---
[   22.151249] [<ffffff88b9d43f84>] down_write_killable+0x2c/0x80   <---
[   22.157155] [<ffffff88b8e53cd8>] setup_arg_pages+0xb8/0x208      <---
[   22.162792] [<ffffff88b8eb7534>] load_elf_binary+0x434/0x1298
[   22.168600] [<ffffff88b8e55674>] search_binary_handler+0xac/0x1f0
[   22.174763] [<ffffff88b8e560ec>]
do_execveat_common.isra.15+0x504/0x6c8
[   22.181452] [<ffffff88b8e562f4>] do_execve+0x44/0x58
[   22.186481] [<ffffff88b8c84030>] run_init_process+0x38/0x48      <---
[   22.192122] [<ffffff88b9d3db1c>] kernel_init+0x8c/0x108
[   22.197411] [<ffffff88b8c83f00>] ret_from_fork+0x10/0x50

 >
 > This at least proves that there is no issue in core ipipe patches, and
 > I can proceed.

I doubt the *IPIPE patches*. You said you removed the configs, but all
code are not under IPIPE configs and as I see there are lots of
changes to interrupt code in general with ipipe.

So to actually confirm whether the issue is with qcom drivers or ipipe,
please *remove ipipe patches (not just configs)* and boot.
Also paste the full dmesg logs for these 2 cases(with and without
ipipe).

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
