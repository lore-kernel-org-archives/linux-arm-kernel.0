Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCB6C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:51:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B178E2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FpsMA3LV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B178E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6TIoP/Es2F40pmxJllkx4+/8f8YwFg9rPvA7nEZPJjw=; b=FpsMA3LVgwb8/q
	6VBfd/SeZUBK/LxvEK3ZzDs3Za/ouBeXrvpMczWiUf3yShFqh/lRy/CeThnXAfHWnYo+IFJdiHUfd
	p8PyBCV+g+CbfbLF4c68rL3msoEwyHJpZkXA1sOEvQ/UXBT+aKrnkcD9B342UjkUPoWeZpM2Y/7YB
	73TOBNGm43sbKI2l8vgp0Uf+iLBnh2vk7lxKepeOGT51zgYtQjLa5t0FI6yn+sRVh6WUcgKi8neQg
	pJTIB5yfC0mypLs+g1NobKkXm+foMcO6XFEWNX1Ub0ELE7qsh0e2yVPZD9KGIZCoI3xZtGdZ8LJnx
	w1vQHxl4wl4kq9sljyMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7M7-0005zy-V9; Tue, 04 Dec 2018 09:51:03 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7M3-0005y6-L7
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:51:01 +0000
Received: by mail-wr1-f65.google.com with SMTP id u3so15175866wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 01:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZKVbcR4IStGL63pS+Wn8KIAgvCjxvVnFnBrE1QELbR0=;
 b=piElirmYl8r8XSXX8/hVVimq5ikWtdgpHcMYsU9SoP9upefF0jKmVjw9kIqbv5jPU1
 PZiQfnelQljS22eFerhqBawr5ju2oDeX0bI1I/Hkti5uLwa85ipZtL84FV8bt/M1jGeF
 TWchfa+SxZfXcptghT7dyBu6xvpfQpURVlD8k5mrGeyRO3+McHfKb7Q6REne2+OiXi5w
 2VD/ojGuRFLZgAcABuYTKafRIQZUxxWTYG++80teR2AQeFsWFvT12y/NfT5RvQOtuvPV
 YqE7PHcSpUaECHeS093a5uf+ENFyldg/xABm3IjBEqHyF/l8YPkoz9E3M+XzGmSiewMh
 wL0g==
X-Gm-Message-State: AA+aEWawtsXIVGeHaZi1c8KZbtzqzQ4i1feUR9lrNpWerb1TMD/uXJ5h
 jIACN5p4uw6exAh2XfUBaegzqg==
X-Google-Smtp-Source: AFSGD/XBNLYa2pvbHEB2Jl2yc78WIOzB7EbaXim1lqSLlGmhd5G5sYpAVmrr/9Ip/zXOzRo0izD5RQ==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr16819820wrs.290.1543917047226; 
 Tue, 04 Dec 2018 01:50:47 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id l202sm4698646wma.33.2018.12.04.01.50.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 01:50:46 -0800 (PST)
Date: Tue, 4 Dec 2018 10:50:43 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFT PATCH v1 3/4] cpu-topology: Move cpu topology code to
 common code.
Message-ID: <20181204095043.GD23553@localhost.localdomain>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-4-git-send-email-atish.patra@wdc.com>
 <20181203165833.GA27796@arm.com>
 <20181203171223.GD17883@e107155-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203171223.GD17883@e107155-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_015059_686932_B59EFB76 
X-CRM114-Status: GOOD (  21.44  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Dmitriy Cherkasov <dmitriy@oss-tech.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>, Atish Patra <atish.patra@wdc.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Anup Patel <anup@brainfault.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-riscv@lists.infradead.org, Ingo Molnar <mingo@kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 03/12/18 17:12, Sudeep Holla wrote:
> (Fixed Juri Lelli's email)
> 
> On Mon, Dec 03, 2018 at 04:58:34PM +0000, Will Deacon wrote:
> > On Thu, Nov 29, 2018 at 03:28:19PM -0800, Atish Patra wrote:
> > > Both RISC-V & ARM64 are using cpu-map device tree to describe
> > > their cpu topology. It's better to move the relevant code to
> > > a common place instead of duplicate code.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >  arch/arm64/include/asm/topology.h |  22 ---
> > >  arch/arm64/kernel/topology.c      | 303 +-------------------------------------
> > >  drivers/base/arch_topology.c      | 294 ++++++++++++++++++++++++++++++++++++
> >
> > Whilst I'm happy seeing this code moved out, I'd like to have an entry in
> > MAINTAINERS so that somebody can review changes from the arm64 side without
> > having to poll a load of different lists. I assume patches would still go
> > via Rafael and Greg, but if we could have Sudeep added as Reviewer for this
> > file, then I'd really appreciate it.
> >
> 
> Thanks Will for pointing this. I agree with you and like to be added as
> reviewer for this.
> 
> Since arch_topology.c was mostly added for ARM/ARM64 and by Juri Lelli 
> (who is no longer with ARM) and I did review the initial version, I would
> like to assume maintenance for this file if both Juri and Greg are OK
> with it so that I can keep an eye on this as we expect more changes to
> this both for ARM and RISC-V.

Sure, this is OK with me. Thanks for keeping an eye on this.

Best,

- Juri

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
