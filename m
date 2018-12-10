Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC6C65BB3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:48:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBF820821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bWVWX+3D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MK8l7UTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBF820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kuVgGYm71hHKfdJiFkgpR4NaahdIIbdqXDkH4xy/PDE=; b=bWVWX+3DaoKT5H
	UJLEmSxFa6VEoLsXPPvvHBOb08OtC16So05oM+d9scl0GGiVkrSYs1cUYa6z0jL6ZTuZ2224WWRrv
	iZcRcYGuyf4Zd/srQFibZ4ELYakQA/tEIlBaAAmXhomvSo1XwNn1FTFq0gkWNsV5QTU7vfXZhZaU2
	LB+BOfNbesJ2m3en44G1g7U5ZONEn/RK5wyYtIJK70fKDIX4Cm5y3LpNwMu0x9tP3bp2Bl26UTNn5
	I5QOEl1c4Kg4JMt+s/KwAgnvRMgCWGRoSyfSNai4bstbCwsCeKQQ0le57eFOrAlzk4df6nO5zybV7
	yPolDxmVfhcj+er2TdbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWNn1-00012Z-J8; Mon, 10 Dec 2018 15:48:11 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWNmx-00011X-Qj
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 15:48:09 +0000
Received: by mail-qt1-x842.google.com with SMTP id d19so12749747qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 07:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LCf9Z4VdxxL+ACTRPCvQ1wda3huFplaR4OdG4DSoMUI=;
 b=MK8l7UTs9njLHxQeiKhpqeRDvjmdksChzkMfgty8lnIPOBnjGcCnLrpHNkvOtcz9QF
 TkRBBvxLJBg/nMovERh55Tk672ONANtNgndFwtcYrNrveafQuu1N+HjX0hWmTquES0Zj
 l8Jt3EDSN5hCcOS2rxYMfbrpz1MOzA0OLu+mawLZ1Npo2939B037nnzUEma0858hQFtI
 skmmESHM0H//rhOuhNijAVmpHmh9A2g98oHj+G4aypA7Fo40Z8lWja1oRA9sdz6gbuhF
 SUUC8hWgajPlFvj/Yu3p9UIYmlImeBeAps2pPw59jJ3NKAngZrdY2sVuQQYAwmRGwPZn
 g+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LCf9Z4VdxxL+ACTRPCvQ1wda3huFplaR4OdG4DSoMUI=;
 b=c4bQwOaMKdu2E2PUxvMaPkLPhD4lOHUdRWHTW9+lISAns3tQ6QV5n6FrHHDFaoXTzd
 EpCmuAijf6bmwpZDzDzwIUdh2S4n5JAuB6LChcNDDNFKDH9Wi5utcmllN38KAihjDcnK
 QlSW8MmBjepygg3S9r/fhUJYfbLEWkkCd789g2qZEQa5Dj0kkinN7vLKRzKv1j8KJYRW
 0R+z3JwSg3FzsOir44c2jAHgbWdPf4fadWak8lr9SHj2EirD4Rt+hIUnz4DT5vTsWrOo
 AzYOFLGtU5WHv7ue1Br5pAFJoxcTk8H8fCvLEsw+fTjUZPY7YV8qUrWlIjC57cw8SyPn
 yTSQ==
X-Gm-Message-State: AA+aEWb53ofHM3MIrxGc/cZyilXkfvL/z8H88M3CRARK++ddGpt+XZJ1
 zsTom6wyLKc2jQC4ScB/+/ry5g==
X-Google-Smtp-Source: AFSGD/WzVOsT+FTzkS6a5OBVN1mhZ8uWPLV6dsu1Wxthq6TpRPsga8PU/vx6ChMsJQhCIRs99WaqcQ==
X-Received: by 2002:a0c:f212:: with SMTP id h18mr12274818qvk.106.1544456876413; 
 Mon, 10 Dec 2018 07:47:56 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id k189sm6196469qkf.64.2018.12.10.07.47.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 07:47:55 -0800 (PST)
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
To: Peter Zijlstra <peterz@infradead.org>
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
 <20181210135228.49751-1-cai@lca.pw>
 <20181210140703.GM5289@hirez.programming.kicks-ass.net>
From: Qian Cai <cai@lca.pw>
Message-ID: <929c17bd-1397-69d2-79c7-b81b9ae50346@lca.pw>
Date: Mon, 10 Dec 2018 10:47:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210140703.GM5289@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_074807_919691_71681A09 
X-CRM114-Status: GOOD (  16.25  )
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
Cc: mark.rutland@arm.com, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, mingo@kernel.org, longman@redhat.com,
 akpm@linux-foundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 12/10/18 9:07 AM, Peter Zijlstra wrote:
> On Mon, Dec 10, 2018 at 08:52:28AM -0500, Qian Cai wrote:
>> Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
>> warning.
>>
>> [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
>> [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
>> [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
>> [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
>> [    0.000000]  acpi_table_parse+0x1ac/0x218
>> [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
>> [    0.000000]  timer_probe+0x1bc/0x254
>> [    0.000000]  time_init+0x44/0x98
>> [    0.000000]  start_kernel+0x4ec/0x7d4
> 
> It seems to me we want something like:

Tested-by: Qian Cai <cai@lca.pw>

> 
> ---
>  kernel/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 91d5c38eb7e5..e1ee8caf28b5 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -313,6 +313,8 @@ void cpus_write_unlock(void)
>  
>  void lockdep_assert_cpus_held(void)
>  {
> +	if (system_state < SYSTEM_RUNNING)
> +		return;
>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>  }
>  
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
