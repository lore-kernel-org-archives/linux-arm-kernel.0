Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18445C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97FB2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qK9103s9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FE2gfRPw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aXPgz4Y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97FB2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eRKcUQyPR7MapExn5F7Tcjcniqrszk7qy9qWLFqdlco=; b=qK9103s94ZKj8P
	W4wy1+l2OsS7WjvGFwMduz1lpTVZ67Qg1oL5or8UzevOqtn7xPeJE02WkLMG6KExd6AQgzF8cvxUo
	RlBOBlqogKDLuauDhBPWNKgHNoid+In0x5zhLCoxS8c8UuZm87WgmJRjvy7peO5dlvvJ6+xD4+3XC
	ECQBlUpV/1fUIuml1ZjGgJiNEWvphXN2VYWc8aSQNDVy7HOQ8g/vufl82i2aqODmwKHGafWGGmBZ7
	PPMPbif08AzwrEhWLTHSUkJSgOHs9JDbZ9KGnBUf23sVZpj5jxvMOr9EXiYr4PQN34b5ujxyY6q6Q
	ihBNOEbC401FAv6jNxyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyN7f-0000ZX-VE; Mon, 25 Feb 2019 20:45:11 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyN6z-0000YZ-HA
 for linux-arm-kernel@bombadil.infradead.org; Mon, 25 Feb 2019 20:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LYt6QNtuPUERhVQOjDHliIhKCr9rtSWbkLNMb2Z1RTc=; b=FE2gfRPwNT+Opn/QhEcXiR+Ln
 mJ4TY5YwjvcUoVvgc/lHXGw9A2e3lyBxHvcIMwH/0bDemS7j7iNLi8QtmgYBqB8RSyX+z9SkTAXOD
 YeaM8wcoAgzy8IH5+Htw+w/s6ETIvq74KKGlxozUxJk5ViD7VBmYWOKQmLDyQ/txRFgWO1Ycvwcce
 DL24GzS9BAXPkl2Wf3WzQkc7/8U1dAaE9bBzitrJbIdaCa+qqXKcs2gA4JtVhSvi8wPRugKdAWvfd
 ClSTvyd/l13scM2gSDXW3ZZR4AV6RAd2qqVj2FxobcHM7vSVeXJ+CgEu2rKR6y5WIWU+9ICSXjb3j
 muN+kW7EQ==;
Received: from mail.skyhub.de ([5.9.137.197])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyN6V-0000MO-NW
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 20:44:01 +0000
Received: from zn.tnic (p200300EC2BC68000605C24440EAF7D3B.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bc6:8000:605c:2444:eaf:7d3b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CC711EC04F3;
 Mon, 25 Feb 2019 21:42:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1551127371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=LYt6QNtuPUERhVQOjDHliIhKCr9rtSWbkLNMb2Z1RTc=;
 b=aXPgz4Y1eB5+sRjy1ioiWFZ7XUKeFHgaP87+h5HZA/ahkY8evR6rBPdWVQx0oeHA4d56Zw
 wfkeihkIupmqDeaCh1onhyT+wO3qARoWUW3XXs/cFT1smVDx7TOhreIRCi6/ii3PB4MYWe
 RiFztsRJb5P8jf7m1Xr8ClZ0quJIsPk=
Date: Mon, 25 Feb 2019 21:42:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv2 0/2] Independent SOCFPGA SDRAM EDAC config
Message-ID: <20190225204244.GJ26145@zn.tnic>
References: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_154359_889045_8ED56E00 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: linux@armlinux.org.uk, linux-kernel@vger.kernel.org, dinguyen@kernel.org,
 james.morse@arm.com, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-edac@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 12:56:44PM -0600, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Most users want EDAC support so make it the default.
> 
> SOCFPGA SDRAM EDAC reporting was enabled by the parent EDAC
> config (CONFIG_ALTERA_EDAC) since initial customers always
> wanted SDRAM EDAC enabled.
> There are cases where the SDRAM needs to be disabled while
> the other block EDACs remain enabled.
> This patch set 1) splits out the SDRAM EDAC into a separate
> config and 2) enables all the EDAC blocks by default for
> 32 bit SOCFPGA.
> 
> V2 Changes
>   Rebase socfpga_defconfig against arm-soc/arm/defconfig
> 
> Thor Thayer (2):
>   EDAC, altera: Add separate SDRAM EDAC config
>   ARM: socfpga_defconfig: enable EDAC by default

Am I supposed to take the second patch too or is it going through Dinh's
tree?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
