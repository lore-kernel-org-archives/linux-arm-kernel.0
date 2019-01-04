Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:09:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C882070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f6KzZGMA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgvgMdWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C882070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fkgw0MaSwYt6xsr7V4iQs1Kt7A65tDOQRmPsY0o4tzA=; b=f6KzZGMAwWgsCD
	Nga69P1+3k7sUcVHrpwLOGW6+mtpKL5Hy8BH3LbdQGgwYBpEQNrIVJwZGXAhNb+Y6qqljgKxsRySH
	T2akQUWegsK74iy8Jto99NBZs1/PfCVyDMGduDeTAg9Lk0yMSgqEjcH2EmQNorRSD6g3g8QaiBhi2
	L/cAJn4zkA0uhUSM+9VJKxY6avae6kXQiEPIX3Z1BuXWHXRPJUklCezLTBBtaNLygOcjA1dTN90ru
	COOCw1oZP03Q0UuJ8qkLirU/LJ1OGIZsE4NF4kOFgbPyA5oe04oK8s0yykVGrMlROotUYLnHiBnzd
	PQWwhMIBX1ToBYWExGIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfJbW-00031Z-BB; Fri, 04 Jan 2019 07:09:14 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfJbP-0002uu-SV
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 07:09:09 +0000
Received: by mail-pf1-x442.google.com with SMTP id c73so17853287pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 23:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:references:date:in-reply-to:message-id
 :user-agent:mime-version;
 bh=HRv0iUk5pR3joIxtkVjpdH5C92C9WNAtwQYxciO341U=;
 b=YgvgMdWk29NU28m855i27IeSo4MM5z07hzYxQ6QgrGLKqeitTFHLvKlXv0ETsaglkC
 ADU2DQ3UIbDMf4iazF0QMihHzNIFw/5Ix0JLq3e/QqFwMe++nllxNdOl4dmjODKIF78Q
 jr2IF+R9O9e14QjG5ZW/H8U2Qxb/PIVIMzO8qphwcqRPDNnrq+bjMmF7Z6WXd+RxT689
 7V3MiJDkW7WY8lr1akZUcr7u1UFCBvMYyHqLcB7cK8LEJHOXwmmGSt/QB4GjV5fZV6AM
 zAU7h08l7sLE+O7cvV+qvVcS6SIL8ZRsRz0YGvNVCUqlKM7vYuh9vk6f0gJvxpdCUZ/Q
 VvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
 :message-id:user-agent:mime-version;
 bh=HRv0iUk5pR3joIxtkVjpdH5C92C9WNAtwQYxciO341U=;
 b=jnFM1fKKjYxrWWMhDxYvAI7mn3QQ7M0En4gEKNHGl3T0Nhzba+1TIBwAlcAtenXo8f
 FchQmu/mF9zPikpTE1ZF4K9PNY4XTYwgaJhZfKW6zryNSZeDWl3I+SHAL3rqzE78C8S4
 BFybUGoTVxoZu4Lq03hck8vNk+U/O6ZxHQ7blrQEo+824P+uUIocHKQ4JI/e5qpAL3by
 M8P4eXLmisOGXJ7XDqCv6mmmHTWnIvs9Ww8whOLjkhV45MZGVb42B9c9QBDBRtsyFaeg
 BIVpOMw41jCheElmG8KgYe8Eg8mectmgOxnwsyhzKmYntarqU3rGT4HA13mhV6iZwC+E
 jL9Q==
X-Gm-Message-State: AJcUukeubydbQ54TWxEbsrPY2r37OURvztE3kP/Je9gzPdeqKvQUlgTs
 l4s9U7KvlcWwMGDx/9mLx1I=
X-Google-Smtp-Source: ALg8bN6+h97sMhtZIuDGRXmuVGldQqWvaHw6td4Twp/MI9mxsgxas6NM+Ia5A5fPb5EQ9Un97+MYlQ==
X-Received: by 2002:a63:8043:: with SMTP id j64mr670893pgd.405.1546585746575; 
 Thu, 03 Jan 2019 23:09:06 -0800 (PST)
Received: from localhost (FL1-119-238-83-125.tky.mesh.ad.jp. [119.238.83.125])
 by smtp.gmail.com with ESMTPSA id
 b5sm136599648pfc.150.2019.01.03.23.09.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 23:09:05 -0800 (PST)
From: Punit Agrawal <punitagrawal@gmail.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH v10 0/8] kvm: arm64: Support PUD hugepage at stage 2
References: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
 <20181218113712.GA25383@e113682-lin.lund.arm.com>
Date: Fri, 04 Jan 2019 16:09:03 +0900
In-Reply-To: <20181218113712.GA25383@e113682-lin.lund.arm.com> (Christoffer
 Dall's message of "Tue, 18 Dec 2018 12:37:12 +0100")
Message-ID: <87ef9s292o.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_230908_344923_27F9F726 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: kvm@vger.kernel.org, anshuman.khandual@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Christoffer Dall <christoffer.dall@arm.com> writes:

> On Tue, Dec 11, 2018 at 05:10:33PM +0000, Suzuki K Poulose wrote:
>> This series is an update to the PUD hugepage support previously posted
>> at [0]. This patchset adds support for PUD hugepages at stage 2 a
>> feature that is useful on cores that have support for large sized TLB
>> mappings (e.g., 1GB for 4K granule).
>> 
>> The patches are based on v4.20-rc4
>> 
>> The patches have been tested on AMD Seattle system with the following
>> hugepage sizes - 2M and 1G.
>> 
>> Right now the PUD hugepage for stage2 is only supported if the stage2
>> has 4 levels. i.e, with an IPA size of minimum 44bits with 4K pages.
>> This could be relaxed to stage2 with 3 levels, with the stage1 PUD huge
>> page mapped in the entry level of the stage2 (i.e, pgd). I have not
>> added the change here to keep this version stable w.r.t the previous
>> version. I could post a patch later after further discussions in the
>> list.
>> 
>
> For the series:
>
> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>

Thanks a lot for reviewing the patches and the tag. And to Suzuki for
picking up the patchset.

(I was happy to see this while catching up with the lists after an
extended break!)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
