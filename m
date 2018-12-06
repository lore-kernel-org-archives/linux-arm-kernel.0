Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45990C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:26:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146A02146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iN+DZyWj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kMXVG/ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146A02146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6aOUTfSpSOYJ6WqtlhdcQW7bBF0li2geC95Jz44GDMI=; b=iN+DZyWjqZi6B4Rr7vJX7F6rb
	ncO5NaaLJKUMe/kObVzzQBvOCFQ4aQ93nL3FiUdW6Cc1iJBoJFbziW4Udk6Kzg6toaogK2QoynO6Z
	Cc5rsxggngDVqCJGxb6CtmplY1zWRS4kOmql/ObGES+QU62BqQTyPhDMvA46wSIfMHZRlR1y0FIhI
	ebKq/xoCUZeOOLudCybeuq4y1og3TbjBqGS0/XHo+f6FRNzVHg+oaJR49Dl12uGcp5oHHXnTVR5eN
	jchGSJiSuQVZeDb//X16IQFICDCtGXpqlVXJo/6cG5X+9KxfghLIgOPuzoyVkBGXz+LfZkmOUvBdz
	KRUHjN0zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV25t-0001Nq-3k; Thu, 06 Dec 2018 22:26:05 +0000
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1rK-000639-JP
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:11:13 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 439qYK1v0Vz9s47;
 Fri,  7 Dec 2018 09:10:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1544134246;
 bh=AfsUbMzsOJbvOiD5G1zbaCILSRJRp1HIcLW5c3haUFo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kMXVG/ri0FxASM2ZOKLQgP22/VKx+KejmHZ5F9iHvT2kAaowMqBcJecEDRdY8I4gm
 eHOPby5fdiUYRAZB56Vfq5z282/ToSUpMRK5o6jjCnAIiyOnP/YDH52I8fKglePmJ9
 UWZNDQMep05w+1ReIhJYc39Be3CjqgXYLIJgztaRH82Aw0iSrWuCuZAX2rPmg8DTJ2
 OqT3532pBqJREodM0mVbJ6dyKjf0bVY/XDbv3UOsbHuJi3rUxixunRBUGz0sH2yrMD
 R722p3wYxX3lIjZbHttnjitmaQNtRplbFxk+Zr0DF4XYr+/Y9evzkW/SRpH25kdCiV
 CvxCR7KFW1bIQ==
Date: Fri, 7 Dec 2018 09:10:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: dmapool regression in next
Message-ID: <20181207091038.4c1ce190@canb.auug.org.au>
In-Reply-To: <20181206163315.GL6707@atomide.com>
References: <20181206013054.GI6707@atomide.com>
 <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
 <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
 <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
 <9187bbd9-3aaf-c1b3-16a3-4e1b3356c52e@cybernetics.com>
 <20181206163315.GL6707@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141103_736311_7A7AB355 
X-CRM114-Status: GOOD (  26.60  )
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
Cc: john.garry@huawei.com, linux@armlinux.org.uk,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 andy.shevchenko@gmail.com, hch@lst.de, Matthew Wilcox <willy@infradead.org>,
 akpm@linux-foundation.org, linux-omap@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Tony Battersby <tonyb@cybernetics.com>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: multipart/mixed; boundary="===============0598762080416820511=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============0598762080416820511==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pjowFOcDvUZrEen3F3NXUo."; protocol="application/pgp-signature"

--Sig_/pjowFOcDvUZrEen3F3NXUo.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 6 Dec 2018 08:33:15 -0800 Tony Lindgren <tony@atomide.com> wrote:
>
> * Tony Battersby <tonyb@cybernetics.com> [181206 16:13]:
> > On 12/6/18 10:51 AM, Robin Murphy wrote: =20
> > >> Here is the prototype:
> > >>
> > >> void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dm=
a);
> > >>
> > >> With the old code, the 'dma' value had to be correct for use with
> > >> pool_find_page(), or else you would get an error.=C2=A0 If the 'vadd=
r' value
> > >> was incorrect, it would corrupt the dmapool freelist, but you wouldn=
't
> > >> get an error unless DMAPOOL_DEBUG was enabled.
> > >>
> > >> With my patch applied, 'vaddr' has to be correct for virt_to_page().=
=C2=A0 My
> > >> code also checks that 'dma' is consistent with 'vaddr' even if
> > >> DMAPOOL_DEBUG is disabled, since the check is fast and it will preve=
nt
> > >> problems like this in the future. =20
> > > Unfortunately that logic has a fatal flaw - DMA pools are backed by=20
> > > dma_alloc_coherent(), and there is absolutely no guarantee that the=20
> > > memory dma_alloc_coherent() returns is backed by a struct page at all=
.=20
> > > Even if it is, there is still absolutely no guarantee that the vaddr=
=20
> > > value it returns is valid for virt_to_page() - on many systems it wil=
l=20
> > > be in vmalloc or some architecture-specific region of address space.
> > >
> > > The problem is not that these drivers are buggy (they're not - the ar=
ch=20
> > > code is returning a vmalloc()ed non-cacheable remap in the first plac=
e),=20
> > > it's that 26abe88e830d is fundamentally unworkable and needs revertin=
g.=20
> > > Apparently the original patches managed not to catch my eye as someth=
ing=20
> > > I needed to review, sorry about that :(
> > >
> > > Robin.
> > > =20
> > Thanks for the info; the inner workings of the vm system are a bit out
> > of my area of expertise.=C2=A0 My first version of the patch series use=
d a
> > different method that didn't rely on virt_to_page(); I will go back to
> > that version, clean it up, and resubmit when I have time.
> >=20
> > Andrew, please revert all 9 patches.=C2=A0 I will resubmit the set when=
 I
> > have a workable solution. =20
>=20
> OK sounds good to me. I can test the new set easily when available
> if you Cc me on them.

I have removed those patches from linux-next for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/pjowFOcDvUZrEen3F3NXUo.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJnl4ACgkQAVBC80lX
0Gx8hwf9Eys9Y1e6TofQJ12L7yRTW2zqRzoeDtvjEjuSRNSTDvRftnGpQvTCx+ej
/MF/1LNHEv/zGZhx1TbwxXTR5nYTW5Wu2GoJiH1JPEeDBEtY3URX4TjP0HgIhRgM
/yg8q/CSY87kB9oZYRaBLBjqk5Fm9PyZ/Xmz2ESOQXwui/m68CLBXzKODCSNplZv
7I/aS0ftW5BMXv1OWZpA93DhVFXKs4ehPROxtsHSB6aGp6L+CDSp01M4Tha54vtF
dU4LMGnTI1INlgVBC5czQQ0IGqCv7NtqDiUnr+zCC/bQcJ4uQMfXzbqO4NpsyZ2Y
I5+XY2d0LYKN9BkVJoEuOf5H/hzzMA==
=YxiC
-----END PGP SIGNATURE-----

--Sig_/pjowFOcDvUZrEen3F3NXUo.--


--===============0598762080416820511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0598762080416820511==--

