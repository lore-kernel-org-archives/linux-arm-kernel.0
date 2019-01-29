Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B79C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:09:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6F22175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ndhY4NKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6F22175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oilvjhQFbS5uBCUI0hOWV+zszqu6tsIq0qrRlSqjTh4=; b=ndhY4NKxXrPhyT
	I00/GpB44K/0PvUURd6sNn9k2/Vx10dgwa/AXd9dT8VxB/PHXuHRNWuSIN6sbZLpc5cfnka1Izhr/
	jKL7t2NmT50UCVWRWPIAtf3LgQEeSzv8y5q/T8Jw4Q5Geh6S+eEPdVItgLETPNAaVQ02vZNTDMo7m
	26atepbq5x2leaO4nFz9s0ezeqIihb3nAMJEuWRZn2k6cf+VVd8diVEQWyhBfDj4hFDs7Y0r6gaEq
	x7lM9PHMwHSiXw3K7ELOExeKHZYn93FM1SwIhYgfG6cLiLqywPo+x5hVZX2Ypu2MNzGpnoQDXOpBL
	BbGu3wQ9gXhTvXabI62Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goV12-0006xx-4Q; Tue, 29 Jan 2019 15:09:32 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goV0t-0006xY-IJ
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:09:29 +0000
Received: by mail-oi1-f195.google.com with SMTP id y1so16339934oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 07:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dBWLcVk2FKdoriSA6cBuTTloAIyPoayaHnUIXHy+MVU=;
 b=WNhi812UPSBTdvaDWcLE0QkRCEOQKDvsxvyi9Lq66vWh8OS29OiUe0/UqLJ6I8I/Rs
 IWr/xUmwV3LoYVxbswaFfWiOMS5e94xqAxh+/NK3zY/ZGEPczcHJnP+cclX9fAUBqFV3
 gGng5frkmai+V6jVIcE6ap5ZGsCvOCBAIgjnX56k95r1MldplDNPh9EOUq1G0jMSwpbd
 FvbTLVpiPa4Dj0/duf16L9LzYUDEuL1/K8VDSLf82ArMsF0ttzHshPTvzVzU9T30xEJU
 QynGOyy2IiiOAc2Irx5oF2GA42LViOH7K4h/f4fgpyHOnuByOnHn+LFCMpR9VOL1cnIW
 ElIw==
X-Gm-Message-State: AJcUukcuDnax8XhXCvQhwt4Ru3hZ0O6klBSRkrzPbua3OLvoP7WSHyUZ
 KmEx0CcKwYJ1WkFAv7NR60X6kjw8E+PBOemaf2I=
X-Google-Smtp-Source: ALg8bN41nyw/11NQDZx4GhvEABa4wfji3OY5KJXkzMkall32qSsQClytAxXFCK557gZVAF6zdgTgvV3cvDk7z+X/4MY=
X-Received: by 2002:aca:e715:: with SMTP id e21mr9747980oih.76.1548774562350; 
 Tue, 29 Jan 2019 07:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20190122150616.850-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu9Ya45KONSiTh1Nj=WEoiwJqqfhOJf6-PxhyHtOoBeiKw@mail.gmail.com>
In-Reply-To: <CAKv+Gu9Ya45KONSiTh1Nj=WEoiwJqqfhOJf6-PxhyHtOoBeiKw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 Jan 2019 16:09:11 +0100
Message-ID: <CAJZ5v0jcrP1KnKO3cNfz07UmMtita0xFzS67=_v9BVhJZiBP0A@mail.gmail.com>
Subject: Re: [PATCH] acpi: bgrt: parse BGRT to obtain BMP address before it
 gets clobbered
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_070923_600088_2B82F12A 
X-CRM114-Status: GOOD (  17.77  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Graeme Gregory <graeme.gregory@linaro.org>, Peter Jones <pjones@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Leif Lindholm <leif.lindholm@linaro.org>, Al Stone <astone@redhat.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>, "Hsiung,
 Harry L" <harry.l.hsiung@intel.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 3:36 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 22 Jan 2019 at 16:06, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > The bitmap left in the framebuffer by the firmware is described by an
> > ACPI table called "BGRT", which describes the size, pixel format and
> > the address of a BMP image in memory. While the BGRT ACPI table is
> > guaranteed to reside in a "ACPI reclaim" memory region, which is
> > never touched by Linux. The BMP image, however, typically resides
> > in EFI Boot Services Memory, which may have been overwritten by the
> > time the BGRT discovery routine runs.
> >
> > So instead, drop the handling from the ACPI init code, and call the
> > BGRT parsing code immediately after going over the EFI configuration
> > table array, at which time no memory has been touched yet except for
> > the .data/.bss regions covered by the static kernel image.
> >
> > Unfortunately, this involves a non-trivial amount of ACPI entry
> > point and root table parsing, but we cannot rely on the normal
> > ACPI infrastructure yet this early in the boot.
> >
> > Also note that we cannot take the 'acpi_disabled' global variable
> > into account, since it may not have assumed the correct value yet
> > (on arm64, the default value is '1' which is overridden to '0' if
> > no DT description has been made available by the firmware)
> >
> > Cc: Peter Jones <pjones@redhat.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/kernel/acpi.c        |  2 -
> >  arch/x86/kernel/acpi/boot.c     |  2 -
> >  drivers/acpi/bgrt.c             |  6 --
> >  drivers/firmware/efi/efi-bgrt.c | 80 ++++++++++++++++++--
> >  drivers/firmware/efi/efi.c      | 13 ++++
> >  include/linux/efi-bgrt.h        |  4 +-
> >  6 files changed, 89 insertions(+), 18 deletions(-)
> >
>
> Rafael, Len,
>
> Do you mind if i take this via the EFI tree (after addressing
> Lorenzo's comments)

Not at all, please take it.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
