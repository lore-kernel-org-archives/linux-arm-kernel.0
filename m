Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A187C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:07:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E9E2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P9ZgXJ6C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPqfeNwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E9E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sev28YpdzWBJ42IazOUWwwzNpcgvnRd1vuECKeLkRtU=; b=P9ZgXJ6Cuqi40M
	OHkjpqm1g5JKHE8l2tQqoxYJwaDrIYhKgovizSs07+83DJGI8VYyCYCaWn4GYhSTek06speTyiXju
	FnRgbZc6soQ7ClpPU/4fUKTF8eOCnfHwDmzFtARnPsnORw4JjGlxaSsfI1SqXEFuGBwmI//3gK2y5
	3DDcDxiMT4a/XP7TOJIRuCMYdm3tMWqLiMqai6BUcX6mKTWq89Gqejt80KlqxM/7I/zakGH8CD4ft
	80fZYkFe+8aHF3P+9m3aELmzzWK5zIM5EZuPL3vG+CYdV1jzPnkAPrna4N6s8HWkPj3q3+sMo+YPA
	3s9gC/ys/xWcrROdqygA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggoIV-00016z-OU; Tue, 08 Jan 2019 10:07:47 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggoIS-00016S-4C
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 10:07:45 +0000
Received: by mail-ed1-x52f.google.com with SMTP id d39so3580015edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 02:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=bkaMWtTpESawvoOLxRuAs8lIKhxRNP1HBs58Vo4C1QM=;
 b=GPqfeNwAKNwodLKf/pfdqR49wJuUJQPvD1xpvI4/sFB4gMKaVr4gZai73bfaGwMTan
 Cg1II7X0VG/mc+c1t6usWm/ck2qZhu9bLqGYeB/cGkpoaOBRvm7267Ei0A+1NPPaNngF
 29da1q2DbXimE9UI34kqJ5EKAWcPocMBxCkeuM4dJ85Jr7uNQ7JiEWLfaVDQ56QgeqWr
 +e5Q29gdrzg1ND97D1fpsQjTD0bUrw0kEhtvYU4QaVxk4fPppRfI6m84rrIOHetvWAi2
 7JWrfJsnTy7fw6saNbeluLT1Yg0dv9AzaiXikvrwJr+KX9oAQ3vClw5yM73+LuJDVpHv
 kvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=bkaMWtTpESawvoOLxRuAs8lIKhxRNP1HBs58Vo4C1QM=;
 b=rXv/0tMld2rudVnnA5F7fK8lGQXfBgS+jteTUDIQoNazQ0utuah4RYo3snI5qanPuF
 if/d+NSZM2iYqXQwUgWt0tAuqEMiuDb39srXpQJ/rljUWR8ZDd1HINat6HExC57do2u2
 dcyQX++QqzQa+lnlKsM9mGL0UL+QnO5uFJtBMxfhhRVd/yMBMm13zWZ/OtxqhyUrq7xh
 /iEHBclhLCs9FA78esY8sh/a2mu7omdc908/92fT6YrhIsUW9BkXYCFVReXKmaupgI8Z
 uk+T4jYb2hWN1gNfXoUA2GuPUHfavf6zTmclT7O5tseFR8DYgREafcEAkAehxJIUZoB6
 7pAw==
X-Gm-Message-State: AJcUukf9yu9BSPLfe5mRubJkdOOZfXhqUflYFRQswoEmjrkV70QK+lQ3
 G7tezwf7tr0/HDQPmtBhU86xPuk9
X-Google-Smtp-Source: ALg8bN5DeSWxRNZMEg8PuT7ZMJIXr1fzs5j2dUt6exhANSdEK8DwfZ8sJ2+IQsThc/lb9HUYR7kX+A==
X-Received: by 2002:a50:94b6:: with SMTP id s51mr1477306eda.22.1546942061663; 
 Tue, 08 Jan 2019 02:07:41 -0800 (PST)
Received: from localhost (rytm-gw1.ter1.ncp1.par.cust.as8218.eu.
 [83.167.32.99])
 by smtp.gmail.com with ESMTPSA id f6sm38146550ede.53.2019.01.08.02.07.39
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 02:07:40 -0800 (PST)
Date: Tue, 8 Jan 2019 11:07:39 +0100
From: Arthur LAMBERT <lambertarthur22@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Subject: Handle pwm with sysfs with recent kernel
Message-ID: <20190108100739.GA9046@arthur-bzh>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_020744_171004_5779DAEA 
X-CRM114-Status: GOOD (  10.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I am trying to update my kernel bsp from v4.1.X to v4.19.8 but I have some regressions
when I try to use pwm through sysfs from userspace. I have three pwm declared as
follow in my device tree :

	leds {
	     compatible = "pwm-leds";
	     ledred {
		pwms = <&pwm1>;
		label = "red";
		linux,default-trigger = "none";
		default-state = "on";
	     };

	     ledblue {
	     	pwms = <&pwm5>;
		label = "blue";
		linux,default-trigger = "none";
		default-state = "on";
	     };

	     ledgreen {
	     	pwms = <&pwm6>;
		label = "green";
		linux,default-trigger = "none";
		default-state = "on";
	     };
	};

First I have an issue with duplicate name :
sysfs: cannot create duplicate filename '/class/pwm/pwm0'
CPU: 0 PID: 653 Comm: XXXX
Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[<8010dda8>] (unwind_backtrace) from [<8010b468>] (show_stack+0x10/0x14)
[<8010b468>] (show_stack) from [<8025ef0c>] (sysfs_warn_dup+0x58/0x64)
[<8025ef0c>] (sysfs_warn_dup) from [<8025f200>] (sysfs_do_create_link_sd+0xd4/0xd8)
[<8025f200>] (sysfs_do_create_link_sd) from [<80458d6c>] (device_add+0x1ec/0x5d4)
[<80458d6c>] (device_add) from [<8040b5a8>] (export_store+0xfc/0x17c)
[<8040b5a8>] (export_store) from [<80456904>] (dev_attr_store+0x18/0x24)
[<80456904>] (dev_attr_store) from [<8025e604>] (sysfs_kf_write+0x44/0x48)
[<8025e604>] (sysfs_kf_write) from [<8025dcb0>] (kernfs_fop_write+0xe8/0x1d0)
[<8025dcb0>] (kernfs_fop_write) from [<801eaaf8>] (__vfs_write+0x28/0x144)
[<801eaaf8>] (__vfs_write) from [<801ead88>] (vfs_write+0xa4/0x164)
[<801ead88>] (vfs_write) from [<801eaf54>] (ksys_write+0x40/0x94)
[<801eaf54>] (ksys_write) from [<80101000>] (ret_fast_syscall+0x0

I was able to fix it by revert a patch : https://patchwork.kernel.org/patch/9971821/
It is normal that this revert patch is not currently apply on last 4.19.X tag (last one
seems to be 4.19.13)

Then I have another issue when I try to enable my pwm :

# ls /sys/class/pwm/
pwmchip0  pwmchip2  pwmchip4  pwmchip6
pwmchip1  pwmchip3  pwmchip5  pwmchip7
# echo 0 > /sys/class/pwm/pwmchip0/export
# echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
-sh: write error: Invalid argument

Is there a new way to handle pwm in recent kernel ? My old process is now deprecated or something ?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
