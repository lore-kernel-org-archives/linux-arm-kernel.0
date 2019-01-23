Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6E0C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:08:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BB220861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ek8zHS+W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9Ydi6Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BB220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yxd1bC9511U2MTHgE0mcK9BH21ge3+wGyay6L2wYyrk=; b=Ek8zHS+WtG4Nd1
	e/E8pOUGFgHTOgftsGVHmpRvf1/i2n5QoiVe7WjxRqOp/18J/Od3BdGyluIShFKSg499MdREHE0mi
	Do54fXPl6B/yWzvXAkKf56XXPssAlv5r6i2+rMI082EDgpn/2G/+U63R8J4IrkXVCDlkamPLjMOX/
	qx/hnUAdofbM6Wb3fxlQk2m4GafaAy9NdF2pnjVcZ/0Sv/fdFUCEB/kFBSWTPN8lAyQZhPsH6YYmm
	JThXoRuf4Z31doIAgNsvyFSk0JcY3KVzm0v73ENcNmRWneu2t6sKrtXHgisFI4q8Q/pYhJ56ssS62
	Z6F6TXeCtG5nxfYc1AoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmEWU-0000dj-Iz; Wed, 23 Jan 2019 09:08:38 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmEWR-0000dJ-86
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 09:08:36 +0000
Received: by mail-it1-x141.google.com with SMTP id c9so1984203itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B3SLQAjcWFTSHuFKqdcoCiPl5duUwcMm1WoAe2zQCBc=;
 b=i9Ydi6CmBjJ7Qni4RNgJ7lVtnh7RArk6uu2wSuqNpqsad96ta1d0NpdiQ8BzSHc4bS
 JSqoFLKVsdEmvHnzmHhGGbByZ+V+aMxHR8SrW0V5DwK0TWDHR6fwuiK7ubFkstFD9yoW
 jIdGnPi2Kr0fLwvVBBPLZg3ugX1LDdyHHV+Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B3SLQAjcWFTSHuFKqdcoCiPl5duUwcMm1WoAe2zQCBc=;
 b=i/dS6aTwH55hOxsdxnbl7HspW/CWhv27bd66X3lNW139v+G2ltd7jVlFdZtPYEMs1N
 74Z8T+jWoc8k9jRWKROpC/OIlY5xzJmkqGRjMZ3hWCOloOcDL7MXQfP+Xe2bhjc4inKA
 RusJIOwRy+Ubcnloh9fJD+/ofjiIP1fB55XPX3XHRfDPAin39cvLDEkaMRSHapGcgCHY
 Y0Afysuu35fDg5B3bH8GAm1AZe7PlvYwGSSlvgv21lxQkSsnFahqN4mL7Rm+4jvah+kH
 dyhL22Fx85zounXDE0IAxS1g2h08fUlAm5v1X5qMON0FZHDk8uAypwXkLnHa1v6hZOpA
 Wqhg==
X-Gm-Message-State: AJcUukeT3SEqYn6BvRAYP3L6/ws9tkjCQVEeoaYRq/88x+VNtF0wbBlP
 SE/ehe0u8hxqIiBo8tk5v8kZveAUO6Ap1Pj0tXNEgw==
X-Google-Smtp-Source: ALg8bN4lk85uz0JceBO+AHKsHYOmxUSU7AKhBIG8KtUj87JvWhQZ8S5QHF2//QK6ItCYhNLvXzxgFQc5lPCkqkFW2vY=
X-Received: by 2002:a02:183:: with SMTP id 3mr834166jak.130.1548234513858;
 Wed, 23 Jan 2019 01:08:33 -0800 (PST)
MIME-Version: 1.0
References: <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
 <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
In-Reply-To: <20190123071521.GB20526@infradead.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 23 Jan 2019 10:08:22 +0100
Message-ID: <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_010835_295352_84335C3D 
X-CRM114-Status: GOOD (  22.41  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Junwei Zhang <Jerry.Zhang@amd.com>, David Airlie <airlied@linux.ie>,
 Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 23 Jan 2019 at 08:15, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jan 22, 2019 at 10:07:07PM +0100, Ard Biesheuvel wrote:
> > Yes, so much was clear. And the reason this breaks on some arm64
> > systems is because
> > a) non-snooped PCIe TLP attributes may be ignored, and
> > b) non-x86 CPUs do not snoop the caches when accessing uncached mappings.
> >
> > I don't think there is actually any disagreement on this part. And I
> > think my patch is reasonable, only Christoph is objecting to it on the
> > grounds that drivers should not go around the DMA API and create
> > vmap()s of DMA pages with self chosen attributes.
>
> I object to it on various grounds.  While the above is correct it really
> is a mid to long-term fix.
>
> But even in the short term your patch just maintains a random list of
> idefs in a random driver, pokes into the dma-mapping internals and lacks
> any comments in the code explaining on what is going on, leading to
> futher cargo culting.  So it very clearly is not acceptable.

Fair enough. It would be helpful, though, if you could give more
guidance on what you do find acceptable. You haven't answered my
question on whether you think drivers should be allowed to reason at
all about the device's cache coherence.

In any case, I think we (you and I) could easily agree on the correct fix being:
- introduce DMA_ATTR_NOSNOOP
- implement it as a no-op for non-cache coherent devices (since
nosnoop is implied)
- permit non-x86 architectures to override/ignore it if not supported
- rip out all the explicit vmap()/kmap()s of DMA pages from the DRM
drivers, and instead, set the DMA_ATTR_NOSNOOP attribute where
desired, and always use the mappings provided by the DMA API.

The problem is that we will need the DRM/radeon/amdgpu maintainers on
board with this, and until this happens, I am stuck in the middle with
a broken arm64 system.

So, given the above, what /would/ you find acceptable?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
