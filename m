Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F98FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:54:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3177820879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NDk7L8ph"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YSjClqDLsHTmnN4iogZeEsb078VvXKwqnjQd6rryaUM=; b=NDk7L8phhL9Dmu
	CfzWqfs2zSSUNuwbbUbspOpJHTxeXBaPFLr4yB8F9zdUlhQtvgjLp9A+bPJJjQ1u5KRGJdQSGYeE9
	f+IvHCxXOkQe+aIZz3Ljog0m2TkAzhUvbPcHuXFVzQmutdyvxOmruFKHKLQXLnVNhVRBg0fJMrVWB
	T7FlMT/UsfYBJFRXgRYmfh8MoJvoC2bkRSV2atTIlZaUZUL3AFmjRuFUNNucLh1Shfac3eMQvOx33
	TXbx0o93k4xGAhognEIFSOj5a44j//VWxHFkCPdweOymWyxetx9vz8m3mnM7rajK32lD5T9Aoo2tD
	b0yExDhiYXDYm0WJwf3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZUs-000801-4B; Wed, 05 Dec 2018 15:53:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZUp-0007yx-3D
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:53:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 310EE80D;
 Wed,  5 Dec 2018 07:53:44 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 CDE8D3F5AF; Wed,  5 Dec 2018 07:53:42 -0800 (PST)
Date: Wed, 5 Dec 2018 15:53:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: Unexpected variation in SYS_ID_AA64MMFR0_EL1
Message-ID: <20181205155339.GC27881@arrakis.emea.arm.com>
References: <e2130285-6e51-f1c9-7b91-6b0467a15de6@free.fr>
 <CAKv+Gu-cms32Vun16bdM+n_OkH7w7knf45S3eGhVjbG3VdFgbA@mail.gmail.com>
 <44c18e70-e4d9-5e4d-1326-aa1f88a16315@arm.com>
 <20181203153232.no5yiliofqtfelfu@localhost>
 <b56c3925-049b-0d6c-b892-9e10f6473a68@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b56c3925-049b-0d6c-b892-9e10f6473a68@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_075355_141988_7F57904D 
X-CRM114-Status: GOOD (  21.96  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, marc.w.gonzalez@free.fr,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 10:17:38AM +0000, Suzuki K Poulose wrote:
> 
> 
> On 03/12/2018 15:32, Catalin Marinas wrote:
> > On Fri, Nov 30, 2018 at 01:23:28PM +0000, Suzuki K. Poulose wrote:
> > > On 30/11/2018 13:12, Ard Biesheuvel wrote:
> > > > On Fri, 30 Nov 2018 at 13:15, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> > > > > On an APQ8098-based system, for cores 4-7 (little cores?), the kernel prints:
> > > > > 
> > > > > [    0.179055] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1.
> > > > > Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
> > > > > 
> > > > > TGran16, [23:20]
> > > > >       Support for 16KB memory translation granule size:
> > > > >           0x1     Indicates that the 16KB granule is supported.
> > > > > 
> > > > > Since this is a pr_warn, I get the feeling something is not quite right.
> > > > > Is there something to fix? Is it a problem that the big and little cores
> > > > > don't support exactly the same granule sizes?
> > > > > 
> > > > 
> > > > That looks like a false positive to me. We should only care about the
> > > > page size we are running with.
> > > 
> > > Unless you run a VM, which is going to use 16K translation. But this may be
> > > fine with the current kernels, where we emulate the SANITISED registers
> > > for the guests.
> > 
> > I think that's sanitised now for KVM, so we could downgrade the feature
> > to FTR_NONSTRICT.
> 
> Yes, the only caveat is we must make sure that the patch somehow reflect
> the KVM changes to prevent backports assuming that it is safe to change them
> without the KVM bits.

We can add a "Cc: stable # <commit-that-fixes-KVM>" to make the
requirement clear. We should probably also limit the Cc: stable to the
kernel version where KVM started trapping this register.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
