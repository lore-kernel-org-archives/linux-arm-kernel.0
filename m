Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17785C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:08:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1D92084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PUN4dilk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1D92084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1lJAQekEkYEam72Dze5JLrrE5f4p+D40XxTUlrFhUrc=; b=PUN4dilkksV/wf
	mcxmd2EesM1NB1jFX6hfMYeGQWiEdZgftGvqzWzMSplYIn6cl89cApHeZD0ECNP3yOUcryxu73ez8
	EXH9E/A7WhJzcXGTzCVFfZglRD0+o9IQveUi7huAyFnWCSCklpz6Y+30c/BnOEdo5oXxBjb25ii/r
	eMcz51aAhEYrCPBEmY0kgSH58yROD32U8I4ykk3gJgQofsOiJQ8nNgjXKfjjzkq+ySHax+i6H53hs
	eS28ChW43TgU68x17NGEV1wSpe4J8V/crgy1zCBDzDf0Xzn81DdBGqH6UBY1V44hhxfWTg3f4Aj0g
	sFJqVEEwhIWBsSn4ERkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl2XV-0002s8-M5; Sun, 20 Jan 2019 02:08:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl2XS-0002rk-AU
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 02:08:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AB1BA78;
 Sat, 19 Jan 2019 18:08:41 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4E823F5C1;
 Sat, 19 Jan 2019 18:08:38 -0800 (PST)
Date: Sun, 20 Jan 2019 02:08:31 +0000
From: Will Deacon <will.deacon@arm.com>
To: Kassey <kassey1216@gmail.com>
Subject: Re: arm64: copy_from_user access the last page of ddr has problem on
 4.14 kernel
Message-ID: <20190120020829.GA28576@brain-police>
References: <CAKwPUowmzZ2BNi-RmJm3=ENrZ5sxPf1SeT+b9A9iHHSCUQQAUw@mail.gmail.com>
 <20190116164817.GG1910@brain-police>
 <CAKwPUoyWy64-o2NgB5iPXNs4UR7bmYjmKk3Ub0X6DND40fCtPA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKwPUoyWy64-o2NgB5iPXNs4UR7bmYjmKk3Ub0X6DND40fCtPA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_180842_370925_F4B91738 
X-CRM114-Status: GOOD (  12.82  )
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
Cc: mark.rutland@arm.com, kassey@126.com, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 09:57:17AM +0800, Kassey wrote:
> hi, Will
>       it is hard to try on v5.0-rc2 kernel, since there is much port
> job to be done.
>      dst kernel buffer is looks overwriten by some same(fix) patter
> start with "mmap"    (0x6d6d7061)  see below code (data from vmalloc),
> and file is mmaped (include the last phy page of ddr.)
>      see below pattern and pieces of code.

Weird!

>      not sure if there is boundary issue for copy_from_user, please
> help to suggest if you got some idea from the pattern, thanks.

copy_from_user() doesn't care about the physical address, so I can't see why
it would matter (assuming we haven't done something nuts elsewhere, like
double-allocate the page).

The corruption you have is reasonably regular:

> 0079c00 6d6d 7061 0000 0000 0848 fd8f 0001 0000
> 0079c10 0048 fd8f 0001 0000 0001 0000 0003 0000
> 0079c20 2000 fd83 0001 0000 1fff fd86 0001 0000
> 0079c30 0000 0000 0000 0000 700f 0000 0000 0000

Here's "mmap" again, but the record is twice as long:

> 0079c40 6d6d 7061 0000 0000 f448 ffff 0001 0000
> 0079c50 f748 ffff 0001 0000 0001 0000 0004 0000
> 0079c60 3000 fd8c 0001 0000 2fff fd8e 0001 0000
> 0079c70 0000 0000 0000 0000 700f 0000 0000 0000
> 0079c80 c103 0606 0100 be00 1009 3b00 3b07 0607
> 0079c90 0100 5700 1006 e800 8c03 3103 0100 0a00
> 0079ca0 0000 cf00 bf08 0a00 0100 5700 1006 3700
> 0079cb0 3906 0606 0100 1600 0004 4700 9902 0207

And then the whole structure repeats:

> 0079cc0 6d6d 7061 0000 0000 f808 ffff 0001 0000
> 0079cd0 f1c8 ffff 0001 0000 0001 0000 0005 0000
> 0079ce0 d000 fff8 0001 0000 efff fffa 0001 0000
> 0079cf0 0000 0000 0000 0000 700f 0000 0000 0000

> 0079d00 6d6d 7061 0000 0000 f1c8 ffff 0001 0000
> 0079d10 f388 ffff 0001 0000 0001 0000 0003 0000
> 0079d20 c000 ffdf 0001 0000 6fff fff8 0001 0000
> 0079d30 0000 0000 0000 0000 700f 0000 0000 0000
> 0079d40 9407 0901 0100 5300 0204 b400 d503 0a04
> 0079d50 0100 0000 0001 0200 7309 0202 0100 0200
> 0079d60 5000 0200 7309 0202 0400 ff00 f7ff 94ff
> 0079d70 b400 0208 0100 dc00 0000 b400 5803 0607
> 0079d80 6d6d 7061 0000 0000 f7c8 ffff 0001 0000

Do you have any applications running with the name "mmap"?

Also, have you booted with "memtest" on the command-line, so that we can
rule out any dram aliasing issues and the like?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
