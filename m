Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96834C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:00:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6189220665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XU8gz6/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6189220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+4uiYGrJiZpbS3zmiJtDTrUYCxEudhzCy4RWbxHbU1g=; b=XU8gz6/aLIJqGa
	nNWweuVD9rxupMGcO6MszsHa0lOnDWcXuVWBIukPxHfYnQF4+yWhCcFF2LmXq1/zMqlMRsk79ZMJJ
	0KFGG98toqgShwBSgLaKBhGNQSX12TwsIQdKusJvbmZBBux9hwBsnmm83lQvZ6jY+kcSnRH5cpAzb
	oijx6AUOdKGUoQ5C5YWe+CpssFdIz0QfW9DfnPFq8Ruv7AnCdP5OsgbthaU4DlSZ75AA4wMY99Vm0
	to4y/18cmAiqvQQ0I5h9GC/wcX5KIYunV884OPfcBzmUxOIDlUiWoESNpP6BETYGgsILwXuGjoKxd
	2ZKaMZhGjEvOYPcxcDrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghgVR-000799-1a; Thu, 10 Jan 2019 20:00:45 +0000
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghgVN-00077q-6p
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:00:43 +0000
Received: by mail-lf1-f68.google.com with SMTP id i26so9217612lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 12:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IPmQEHAt+sKPcUs7anxfhO25G59A/UNlRVD68a8kfAU=;
 b=cool4hLRB0Uh/I2cwzyk3hheKM1nlfTO7+lwfWe+xgsKJ04WtEtquwsjoVKyjxRu6Z
 W8dpwwfef+Ra0IUdzweYLj3o4f5l7rFHgfvF/GY5kNWRTCTqkWGULlaWbW2FAjL4snZ0
 yvjJEdqypX4ry7XE1fLPjoY0Ev6TAC/D81nzPWW5xTwoKFlhtHNafmpRVoHQp9WAsBhW
 jn1hjO+Yzx97p5I+vTB5qy0g4guG/0muAc0Rv9ThR/kxzCHO7iH+P3eRSZnB3FjRainh
 1kU03EmZ57/8xgl10Z7x+itPm2uYaYpty+6Wa7GOvIypNbXNEZg83vcAqixvoBsKCdeq
 MVVw==
X-Gm-Message-State: AJcUukcKDn9um+sLdm1w8sPDvLsPxzeonZ0IEp5DPJJbcIAFKtYsG2Ru
 EubgRwLLrti6VRDFJzzT3m4LCI3aNEcbPhW+OiCqXw==
X-Google-Smtp-Source: ALg8bN6ZZ98td/Ac0ilRUDMoyEEhipPbBkGBBdNt1QINSZGIn/P70IOTrFhlCWqs3NMkNjVlvt5606j5IHAT+ci/Uik=
X-Received: by 2002:ac2:51af:: with SMTP id f15mr6312409lfk.44.1547150438890; 
 Thu, 10 Jan 2019 12:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20181213052259.56352-1-cai@lca.pw>
 <20181214040819.58625-1-cai@lca.pw>
 <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com>
 <bea04814-25d2-7bb2-0f74-0530fcd54210@lca.pw>
In-Reply-To: <bea04814-25d2-7bb2-0f74-0530fcd54210@lca.pw>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 11 Jan 2019 01:30:26 +0530
Message-ID: <CACi5LpPDzcgW9Yjx1MkdwbmVPFAToQ5hMAw7cAgEvsrB5KwKDQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
To: Qian Cai <cai@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_120041_242868_C3456CF5 
X-CRM114-Status: GOOD (  20.38  )
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
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 Kexec Mailing List <kexec@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Qian,

On Sat, Dec 15, 2018 at 7:24 AM Qian Cai <cai@lca.pw> wrote:
>
> On 12/14/18 2:23 AM, Ard Biesheuvel wrote:
> > On Fri, 14 Dec 2018 at 05:08, Qian Cai <cai@lca.pw> wrote:
> >> Also tried to move the local TLB flush part around a bit inside
> >> __cpu_setup(), although it did complete kdump some times, it did trigger
> >> "Synchronous Exception" in EFI after a cold-reboot fairly often that
> >> seems no way to recover remotely without reinstalling the OS.
> >
> > This doesn't make any sense to me. If the system gets into a weird
> > state out of cold reboot, how could this code be the culprit? Please
> > check your firmware, and try to reproduce the issue on a system that
> > doesn't have such defects.
> >
>
> I'll continue investigating those "Synchronous Exception" although it is kind of
> hard due to I don't have any source code of the firmware to confirm it is buggy
> or not.
>
> I did manage to reproduce this kdump issue on around 5 of those server running a
> fairly recent version of the firmware (07/01/2018). I don't have access to other
> large CPU machines.

Sorry I got busy with some other stuff, but as I reported earlier, I
am not able to reproduce this on my HPE apollo with the latest linus
tree as well.
Here are some details on my setup:

1. # uname -r
5.0.0-rc1+

with the following commit as the HEAD:
commit a88cc8da0279f8e481b0d90e51a0a1cffac55906 (HEAD -> master,
origin/master, origin/HEAD)
Merge: 9cb2feb4d21d 73444bc4d8f9
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jan 8 18:58:29 2019 -0800

    Merge branch 'akpm' (patches from Andrew)

2. I use the following kdump commandline:
Kernel command line: BOOT_IMAGE=(hd9,gpt2)/vmlinuz-5.0.0-rc1+ ro
irqpoll nr_cpus=1 swiotlb=noforce reset_devices
earlycon=pl011,mmio,0x402020000

3. I am able to run kdump successfully on the machine and also collect
the crash core properly:

.. snip..
kdump: saving to /sysroot//var/crash/127.0.0.1-2019-01-10-10:52:25/
kdump: saving vmcore-dmesg.txt
kdump: saving vmcore-dmesg.txt complete
kdump: saving vmcore
Copying data                                      : [100.0 %] \
   eta: 0s
kdump: saving vmcore complete
.. snip ..

4. I use the same firmware version on the board as you shared earlier:
# dmidecode | grep -A 20 -i "BIOS Information"
BIOS Information
    Vendor: American Megatrends Inc.
    Version: L50_5.13_1.0.6
    Release Date: 07/10/2018
    Address: 0xF0000
    Runtime Size: 64 kB
    ROM Size: 64 MB
    Characteristics:
        PCI is supported
        BIOS is upgradeable
        BIOS shadowing is allowed
        Boot from CD is supported
        Selectable boot is supported
        BIOS ROM is socketed
        ACPI is supported
        BIOS boot specification is supported
        Targeted content distribution is supported
        UEFI is supported
    BIOS Revision: 6.3

So, I am guessing that it might be a kdump command line issue at your end.

Thanks,
Bhupesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
