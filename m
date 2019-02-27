Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C2BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:30:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8B120C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KKWS+jgc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ph1yj7zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8B120C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eXWe9WjflhuueomXISm4nnEcmJ/2yJvijEG5g8xLJIs=; b=KKWS+jgczlGNbC
	lcjPxznFj9ixz1EwJ73MUFGhqk+BXpFrNZXCfjo/y2yvxxnIqNeoYvsovcGPHubyyMfytf+KwTRif
	syLC6llv9AIKnbXYEf5p6GJONJTrBuXdsYz2et+k99P+oDqOlu+Reb7ZYIbs4LgP0kcRIBrGgF8DZ
	RWX5HWFs+pOV91SC+ApbQb9hyTGx0d/Mo38l0MPQ6FkspVNC+nRS9xFNTTK86MJzQ73eRdFmrWtyP
	vUi5MG7YMHk4GJaIYeqey3fbilqTyrJAXzCTYGVEGaJO0j3ohcoC17GwtHy6xXLvko59JW0G5Q9sD
	U3vOsUBfn7gxgccnFZGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz31u-0005Zi-2A; Wed, 27 Feb 2019 17:30:02 +0000
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz31q-0005Yg-Kw
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:30:00 +0000
Received: by mail-yw1-xc44.google.com with SMTP id c67so8727621ywa.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 09:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dSSmuG4mKdZqfAxPKCJsdtWMhnsZAqHY97PjvphoIqI=;
 b=ph1yj7zWvRmQCYCm4VsH/94vAD9eny0ts8vH/3dkLnUO2LcPhYR3R9a1mDOEu5MlH7
 6GCEDYQDvs9N4oaU49m5RXkJksem6SdA6MZA9zRr1YyYs5wgnW2bS9TCoqpVjQ9CanbJ
 c/ns0vyML3r89aD+pRHb5rFY4DSU/ZIr6TiZ5N2nEyC5hg1A0Y3hW5+G2PxlHM/hh5yp
 mEze0/MOPGnG8xjfyZW73ZWDN3WTwb3HmpfRg5jE8G75K5GhvH9IfQ6OCu+WsuaKInP3
 V2Rdbs0NpfPrkiTZ22zln0qu+dPzqNo2P2qZRLw6Y12uiYgcEBZ6RXokCqHjgmL6aQKM
 B+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dSSmuG4mKdZqfAxPKCJsdtWMhnsZAqHY97PjvphoIqI=;
 b=Qf9R93ng6IAA2XrfF/GE9uGQN4vCS6f1DfKtRf7O7tiDXt+ARW94gcxLI/pSEzZEiH
 Grze8l6c3N/ekQDCMcI30+m1Iy+h0UgbWuh70vLfaZBC0JEEVSypmxrm8hLWOUPiFj28
 1c79Ba9keQVwK8FHpeKuIpv233qyrFHWcpazDmY4kcFh4FqrHd5NBeNgRsisaIiK8P21
 v01NYEiq6bZS7Qst6H2Q/6i/HjWyxJNw43VDXUYAJDAQMb+oSWgu7YNoNRt95c287kGC
 0eq8IEYGAgEyrnNLejRjzg1c78Zz0RLwis+eatSU7js0W4W23yIK6DRWCMQOy962wC9P
 nO9w==
X-Gm-Message-State: AHQUAub5K544bKlkfNluDeoJ2xbQaCm4BfUbIbIXLxHTun2cYJ2j5iTh
 S5bzWugV7rO++hZsWz+4TVB+Q0K2n+74B4KrGYk=
X-Google-Smtp-Source: AHgI3IajeGjzc7JjBBbd/HnJnbRx3bFug1NbTzdtCFYI5K+mLSoTjKT583kzUbbV0c0iVxLFQ5xbozrcXnPTOGQt+cU=
X-Received: by 2002:a25:8703:: with SMTP id a3mr3045476ybl.445.1551288596863; 
 Wed, 27 Feb 2019 09:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-24-steven.price@arm.com>
In-Reply-To: <20190227170608.27963-24-steven.price@arm.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 27 Feb 2019 09:29:45 -0800
Message-ID: <CAMo8Bf+W3o+ZfTztNyCJVs1CDshB_=3hhCne6MY6v=PD=GqLUg@mail.gmail.com>
Subject: Re: [PATCH v3 23/34] xtensa: mm: Add p?d_large() definitions
To: Steven Price <steven.price@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_092958_711160_DDE09D21 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Chris Zankel <chris@zankel.net>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-xtensa@linux-xtensa.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 27, 2019 at 9:07 AM Steven Price <steven.price@arm.com> wrote:
>
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
>
> For xtensa, we don't support large pages, so add a stub returning 0.
>
> CC: Chris Zankel <chris@zankel.net>
> CC: Max Filippov <jcmvbkbc@gmail.com>
> CC: linux-xtensa@linux-xtensa.org
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/xtensa/include/asm/pgtable.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
