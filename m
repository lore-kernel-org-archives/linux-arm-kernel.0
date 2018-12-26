Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C69EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:47:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EBF214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rB0CYwOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EBF214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IUIkclnk0YNgLpodsTA2xXu/pCcw35ieWk0bKTq3EFI=; b=rB0CYwOXrCWghDAUEfPKRBqIL
	dzk3o4cdI+ei5wE16tMDnDJnwUNd3tPIbdMy+WWy8jHizfNYf4azFOpWsEEDo1pAxWTRYq+NRjmt0
	ui7dPUQ7VggnRNuIJgyVJWSCMObziXXwfozFm5T+q1clX6cIfvUxkKIRBvZQ8VJR0ZGzHa5ETMNRG
	ed/ZkXQ31hNsl5jbDZmjfhDmqVFskc3GyERNCdoKqH2BUpsHE8A5NSA0Lg0+zXLIXrKCSyGWHKPgL
	j7j+ChB5lAFh1NoIhYHtJZzsaO5y8bdNZ1Ya3Ku+cPznUyAG4hRZqTmx5WUGz8YL+jhfo8CDcDKy2
	FZFmHMhSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc7eO-0005tT-46; Wed, 26 Dec 2018 11:47:00 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc7eK-0005sR-Nz
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 11:46:58 +0000
Received: by mail-ed1-f66.google.com with SMTP id d39so13013531edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 03:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CGQn+i9wfBjYhMCNCjDuvQ8HTY47jfkrcjRlmkBqHcs=;
 b=iuORy8mjChYDrSG0nE7Bnk8WiyJQq+ZBCqkiQ1SIekMRwDx/x3+50qXcZ6SQ51X8e/
 GgBo2+GQHPjhnXy08M3jvqdMxM4bN9TkiLF+tLhEZlKvJpKc7VqUqxc5vWY9qVS+897v
 zqMsNaIKoA6/ncHUpt0e+qdpce7vgaaF//loKmyb4ddmpsNDOkZ1HQ2kPajJRnjRgeyn
 Z90AOL4V3VSVMxajp6j7jAz/wjghDjhRl2iMp8Ncm9s8eozMZQkN9tH7cCDYmVlJXF7W
 6QCcuElIZzJ7E2ttK4Zhxi6N9BlsOx/vWd0la8g90ZKkTWdMkKClGhvpHJuM1uoQX4Qe
 JW7A==
X-Gm-Message-State: AA+aEWaCpaMyqkSVXsbdcw7paMh1TGdYRubAvFKdWRVRkV3bLmvwAueu
 hfGon5ebU95PggmHmwWnM5Gt3YLUNTs=
X-Google-Smtp-Source: AFSGD/V9I3akP55ATp5Uxhi9MTaWNlJ4HmEfw7iND17e9HiViGSQAsL45gz9RbLYkLcDDAnykZNmwQ==
X-Received: by 2002:a50:9feb:: with SMTP id c98mr15416662edf.253.1545824802407; 
 Wed, 26 Dec 2018 03:46:42 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id d5sm10414455edb.48.2018.12.26.03.46.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Dec 2018 03:46:41 -0800 (PST)
Subject: Re: [PATCH v2 0/9] i2c: move handling of suspended adapters to the
 core
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUyxcYcT7uAhsQ0xa++yzi3TnBhNS90O6Achz3KD6E4dA@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5ffe2d98-696e-4cc2-51d0-9cc7dc936d7e@redhat.com>
Date: Wed, 26 Dec 2018 12:46:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUyxcYcT7uAhsQ0xa++yzi3TnBhNS90O6Achz3KD6E4dA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_034656_781714_C1342903 
X-CRM114-Status: GOOD (  21.18  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux I2C <linux-i2c@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux PM list <linux-pm@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 26-12-18 12:01, Geert Uytterhoeven wrote:
> Hi Wolfram,
> 
> On Sat, Dec 22, 2018 at 9:26 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
>> Here is the new version without specific I2C helpers but using the
>> 'is_suspended' flag from the PM core. I didn't like messing with the
>> flag directly, so I did a helper in patch 1. So far, I like the
>> approach. The diffstat looks nice, and i2c-rcar.c and i2c-sh_mobile.c
>> rejected rightfully too later transfers without further modifications.
>> Tested on a Renesas Lager board (R-Car H2).
>>
>> I dropped a few Tested-by tags because I think this approach is too
>> different from V1 to keep them. I hope you guys can have a look again.
>> Thanks for all the testing, so far!
>>
>> A branch can be found here:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/reject-when-suspended
>>
>> If this series is acceptable, I'd suggest to take it via my i2c tree
>> after rc1. And then I'll provide an immutable branch for the PM tree to
>> pick. Let me know if this works for you.
> 
> This breaks resume of the CS2000 clock driver on Salvator-X(S) (and
> presumable ULCB, too):
> 
>      Accessing already suspended I2C/SMBus adapter
>      WARNING: CPU: 1 PID: 1186 at drivers/i2c/i2c-core-smbus.c:551
> __i2c_smbus_xfer+0x38/0x66c
>      Modules linked in:
>      CPU: 1 PID: 1186 Comm: s2idle Not tainted
> 4.20.0-salvator-x-08442-ge5992c41ac706409 #264
>      Hardware name: Renesas Salvator-X board based on r8a7795 ES1.x (DT)
>      pstate: 60400005 (nZCv daif +PAN -UAO)
>      pc : __i2c_smbus_xfer+0x38/0x66c
>      lr : __i2c_smbus_xfer+0x38/0x66c
>      sp : ffffff8013413880
>      x29: ffffff8013413880 x28: ffffffc6f78b4820
>      x27: 0000000000000010 x26: ffffff8010cf6178
>      x25: ffffff8013413976 x24: 0000000000000002
>      x23: 0000000000000016 x22: ffffffc6f7872088
>      x21: 0000000000000000 x20: 000000000000004f
>      x19: ffffffc6f7872088 x18: 000000000000000a
>      x17: 0000000000000000 x16: 0000000000000000
>      x15: 0000000000029c80 x14: 0720072007200720
>      x13: 0720072007200720 x12: 0720072007200720
>      x11: 0720072007200720 x10: 0720072007200720
>      x9 : ffffff801100e6d0 x8 : 6461207375424d53
>      x7 : ffffff8011c825c8 x6 : ffffff8011c82000
>      x5 : 0000000000000000 x4 : ffffff8013414000
>      x3 : ffffff80134136e0 x2 : 00000046ee875000
>      x1 : 82c6d7c720d64000 x0 : 0000000000000000
>      Call trace:
>       __i2c_smbus_xfer+0x38/0x66c
>       i2c_smbus_xfer+0x64/0x98
>       i2c_smbus_read_byte_data+0x40/0x6c
>       cs2000_bset.isra.1+0x2c/0x58
>       __cs2000_set_rate.constprop.7+0x8c/0x134
>       cs2000_resume+0x14/0x1c
>       dpm_run_callback+0x15c/0x2d8
>       device_resume_early+0x98/0xec
>       dpm_resume_early+0x3b0/0x454
>       suspend_devices_and_enter+0x7bc/0xbb0
> 
> The CS2000 driver uses SET_LATE_SYSTEM_SLEEP_PM_OPS().
> 
> Suspend/resume of the BD9571 driver works fine, as that one uses
> SET_SYSTEM_SLEEP_PM_OPS().

Ok, so this is the same thing I noticed, the approach using
the pm-core is_suspend flag only works for adapters which
suspend during the regular suspend phase and as such that
approach cannot work everywhere.

Regards,

Hans

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
