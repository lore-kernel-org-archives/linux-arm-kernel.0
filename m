Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE1EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:50:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1327D20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o9+7epXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1327D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yQBN4a/WeA9tsfCw0YOQHbgBY7cq0D+QkHqFTqK/mWY=; b=o9+7epXF7JBAIa
	6IO/0DIJPkpSsYgTM/Sc3LvhSjl8RwriAopY1+NrkA2Wr31gkzMXhROQ8U6FWisnfw8Q6Yy7mHR6X
	xWYHBhloFXrmbHLqxerbWPthT/HYxcSpjJelpOPfcWwnYDzDdi9I56MvPVqnLp5I9+deNkRldGA15
	anHCr7YOJe1yZCW3gRhdYebb7njMelMxQxHTbKkOy9rfFNgWYxuHiJDKVgtDPOzkgpP2E8MO8GMfI
	+NE1k09IhV8WWbUYvQ8dh1UtXFnilXfeytqa/uV0+k0yoS9xALsy0vEGqPR3oFtFgd/7Hfnce2TzK
	cTIIAErkpbzQBxv9lqHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCyM-000811-Jd; Tue, 04 Dec 2018 15:50:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCyK-00080P-Bh
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:50:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AFAEA78;
 Tue,  4 Dec 2018 07:50:40 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B07BB3F614;
 Tue,  4 Dec 2018 07:50:38 -0800 (PST)
Date: Tue, 4 Dec 2018 15:50:36 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH v2 00/23] KVM: arm64: Initial support for SVE guests
Message-ID: <20181204155034.GS3505@e103592.cambridge.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <875zwpi0sn.fsf@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875zwpi0sn.fsf@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_075052_405662_BFA0C7DC 
X-CRM114-Status: GOOD (  18.27  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 22, 2018 at 03:34:16PM +0000, Alex Benn=E9e wrote:
> =

> Dave Martin <Dave.Martin@arm.com> writes:
> =

> > This series implements basic support for allowing KVM guests to use the
> > Arm Scalable Vector Extension (SVE).
> >
> > The patches are based on v4.19-rc5.
> >
> > The patches are also available on a branch for reviewer convenience. [1]
> >
> > This is a significant overhaul of the previous preliminary series [2],
> > with the major changes outlined below, and additional minor updates in
> > response to review feedback (see the individual patches for those).
> >
> > In the interest of getting this series out for review,
> > This series is **completely untested**.
> =

> Richard is currently working on VHE support for QEMU and we already have
> SVE system emulation support as of 3.1 so hopefully QEMU will be able to
> test this soon (and probably shake out a few of our own bugs ;-).

Awesome :)

Of course, there are no bugs on the kernel side... but if you find any
bugs that aren't there I'd like to know!

> > Reviewers should focus on the proposed API (but any other comments are
> > of course welcome!)
> <snip>
> =

> I've finished my pass for this revision. Sorry it took so long to get to
> it.

Much appreciated, thanks!

(I missed this mail when myself when going over responses.)

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
