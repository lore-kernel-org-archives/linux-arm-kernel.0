Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B03C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:45:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6912084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dDsN5ssI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osNGR4Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6912084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sBhPQ/wp6TJFXb4z6ktu0ajtES1a01Xr31V4szip6mA=; b=dDsN5ssIpNC7upMszrvestuP/
	DMrQV2rw7yaYxmBBiGGWI54w+tTc9kz+4lDouP1GXqSZBlWDRgao5sLIfzN60cGw1+LT1p6ChTbT0
	WzfRcQaaitf0Iwg/G193o5mWyoV7+zw+x49MOU4AlJNXhsKUDexPQnJTDsVkLsmCVKwKdRdZfsXJT
	25Qc4PoIDuxwhagkqAFdz8Vf2GBnG3KXn+LMfECTiMlEeMpFQLuTewh68899+IKSttq+OhtO+cLiz
	QbCTCohJVTNJ7BkC0qpYE94V6cwJY2ZcLSSsaktI9UUB7eFTe9cOktSQwFX6vWFoA/Erl2Gjskk4v
	vPsYJLeXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSR4-0000kM-Sq; Mon, 10 Dec 2018 20:45:50 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSQq-0000WO-Ug
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:45:39 +0000
Received: by mail-wm1-x341.google.com with SMTP id s14so52909wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 12:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mBYBny51b2QGsxhBI6fsx6CQbFCCmb0eG46R+wC3M2w=;
 b=osNGR4Sscx36A8Gs5bBbs5ynhBizyUDeFuhPDgsmOPbv25XIVuG17JSxl8JJKuXF4l
 lhNczkQhYsRnLqv+djlWEqiFcTr2PRehGPs3f0mCwy9e/+DHSyIHMR37sz8hrl83m+Jh
 Jcknh2ddGlaXyJEMRKsS2gtKbPWeBNp/auAvxtEX/IsxnN78Q3At7xnjq4kqJIYPx9hj
 LN/ABTKG1coRdOzgBcWgAWzvp+rMqRDmnBESiCWZZyuk8rUCuHXEhcLCZFA5kBo/UbjB
 GJZUxhZlDpRV70MGqGn7KY9QjwhvwAn8n0cTAvxX6EqkbOgZD89vmUeAc5Kfoy8du5Z/
 vSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mBYBny51b2QGsxhBI6fsx6CQbFCCmb0eG46R+wC3M2w=;
 b=BrEAFDGTsK1tF4PVfakaU2YNZgoZqxbJzyuoPe4DJPxAT8yNsrCVcnFexkv+OAVPod
 SD2hxhXMBbXdv3kAC+l4P/3nFXMq5CssV0j5AloAAkV0KnbnA1S/XbGtlDluVOSvm/RU
 TbvqssrN6zcNBX08PmknWYzfbERbDiBXfoFsrSocyzm07JmUxbDWNDtste7Cu9WCB/rn
 setvcaJCveDaSB/VnApCIkuXFDQI1AFoMzAouTwqKEhZz7pW8y+udlwnEP8GV712UlLr
 2q8zQkwTPc/7p8K5Lsxf4P2X2PZ//uIv2GZKqKFAuHMNHD2I7fRWKxwE9WouYev4jfoh
 uGcw==
X-Gm-Message-State: AA+aEWYbiS9YmR2RIBzmDpfxp9cU/4FmfpMWXrDnn26dcRGK4veNunsA
 hagjkh+7OiCkFuwbcRPbbUY=
X-Google-Smtp-Source: AFSGD/XPjETgww7WKs3PEzJUJVY89DfnvUlCaIhTQ3oGPeJfDmLdj4Wc9YW2viUUSMfgu9kuiuCGOA==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr11054794wmt.99.1544474725392; 
 Mon, 10 Dec 2018 12:45:25 -0800 (PST)
Received: from localhost
 (p200300E41F128C00021F3CFFFE37B91B.dip0.t-ipconnect.de.
 [2003:e4:1f12:8c00:21f:3cff:fe37:b91b])
 by smtp.gmail.com with ESMTPSA id t5sm8613wmg.43.2018.12.10.12.45.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 12:45:24 -0800 (PST)
Date: Mon, 10 Dec 2018 21:45:23 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Message-ID: <20181210204522.GA325@mithrandir>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <20181207113245.GA30719@ulmo>
 <CABb+yY2jVmzxFR7iqSyMMyE+XZtyHrAPAxM_KMEa7c2zzpSwCA@mail.gmail.com>
 <20181210095229.GA15154@ulmo>
 <CABb+yY2fNYYjh4cY69M5p0Yc-Z-wusDMQhjTgqb1Ag1QEm=T9Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABb+yY2fNYYjh4cY69M5p0Yc-Z-wusDMQhjTgqb1Ag1QEm=T9Q@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_124536_986446_74148C12 
X-CRM114-Status: GOOD (  31.66  )
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
Cc: Devicetree List <devicetree@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com,
 Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com,
 linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org,
 ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8169067990935336431=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8169067990935336431==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 02:00:48AM +0530, Jassi Brar wrote:
> On Mon, Dec 10, 2018 at 3:22 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> > On Sat, Dec 08, 2018 at 11:39:05AM +0530, Jassi Brar wrote:
> > > On Fri, Dec 7, 2018 at 5:02 PM Thierry Reding <thierry.reding@gmail.c=
om> wrote:
>=20
> > > >
> > > >
> > > > Secondly, I don't understand why you think this is an emulated cons=
ole.
> > > >
> > > It is emulated/virtual because Linux doesn't put characters on a
> > > physical bus. The data is simply handed forward to a remote entity.
> >
> > Okay, I understand. However, from a kernel point of view there's no
> > difference between the TCU and any physical UART. Once the data is
> > handed to the TCU TX mailbox, it's out of control of the TCU driver.
> > Whether there's a real UART behind that or some remote processor that
> > reads the data isn't really relevant.
> >
> That way there can be no virtual/emulated device ?

Virtual/emulated I interpret as purely implemented in software. That is
within the Linux kernel. Once you leave the domain of the kernel it's
no longer under the complete control of the kernel. So where exactly it
goes doesn't matter, it's pretty much the same as a hardware device from
the kernel's perspective.

But I guess you could define this differently.

> > >
> > > The 'flush' api is going to have no use other than implement
> > > busy-waits. I am afraid people are simply going to take it easy and
> > > copy the busy-waits from the test/verification codes.
> > > "discouraging" seldom works because the developer comes with the
> > > failproof excuse "the h/w doesn't provide any other way". Frankly I
> > > would like to push back on such designs.
> >
> > I certainly approve of that stance.
> >
> > However, I'd like to reiterate that the TCU design does in fact support
> > "another way". If you look at the mailbox driver implementation (in the
> > drivers/mailbox/tegra-hsp.c driver), you'll see that it does support an
> > interrupt driven mode. After you had reviewed Mikko's earliest proposal
> > that was indeed implementing busy looping exclusively we both set out
> > to properly implement interrupt support. This took quite a while to do
> > because of some gaps in the documentation, but we eventually got it to
> > work properly. And then it was discovered that it was all a waste of
> > effort because the console driver couldn't make use of it anyway. Well,
> > I should say "waste of effort" because I'm still happy that the proper
> > implementation exists and we can use it under the right circumstances.
> >
> > So, at least in this particular case, it is not the hardware or firmware
> > design that's flawed or was taking any shortcuts. It's really just the
> > particular use-case of the console that doesn't allow us to make use of
> > the right implementation, which is why we have to resort to the inferior
> > method of busy-looping.
> >
> I am not complaining about the hardware, but the firmware.
> It is essential we dump logs during early boot but the platform(Linux)
> doesn't have access to serial port. All the firmware allows is 24bits
> per transfer!! We could do better.

Hardware UARTs don't usually have much more FIFO space than that either.

> A smarter option could have been Linux simply placing characters in
> the shmem ring-buffer, while the remote consuming (and then poisoning)
> the ring buffer upon 'hint' from Linux.

I don't think that would've been much smarter, especially not in this
case. As we discussed earlier, no matter how large you make the ring-
buffer you can always run into situations where you overflow it. The
ring-buffer implementation is also a lot more complicated and error-
prone. Plus there is the fact that in this particular case we actually
don't want buffering because the buffer may hide important information
in case of a crash.

Thierry

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwO0FgACgkQ3SOs138+
s6FNwxAAks4atc+moEEvQlBD4akwevUhs5d+R4j/kfaLvYHl1FO3W+5WWubuGgEk
TmVH6qu4eMR5bdory957u+zFaHG7iv8sl4JRxZO1jAvqOhDGOLTkzAtkhMpo+YC8
uoh/nR+9Z60TMkQvY53rR2bL023f055Le2LnliTud9d6EPcYoms+XJATpI3PPcvv
fOraeGFHFYvj5DtScgjaTEDeNmFSHXwWhoW5MCfXvzxmGLsIy8iGPM2ssON/GCLy
JClKVMJTEhtwNzGfq5hSAWerEprjuPPrWWKGH5mBnw1n0jeYerL44Bq9Q5Q9sS2w
MaEH1tZj+chk+22+iwtWbaAr4+XztJBXq6xLpTLxix/WriM8N1HrjMkZLEv3/efX
g95ygwmf1N3XOXHVd5EZYpExdq9FCKjCQaJ+JDEQQgSdW2oTP0hrkrLswz+MPx9j
vA7HmununHhNO5m5mMQAKcuQCkSbBSJosHyzzpzrzVFwSYXUOJlncQgWhSxJyiIY
VuxAulqBQohfJ50LrgXjJBXiUZ1UGL2dBAt3pvDN0Vjjb4ZZ6qu9rwK1RYT3cQZ6
Hb1u7k21AD9tLyTCVBb+Bc8MBHN48LPh6bR3+nTSIVH0BEJoLyuPuMvHB6iyZBYI
WGlW8pO9YYRSqUnMZg9DV3u2xTJcDJjYejmkUvpchAo8DnKKLXk=
=yfoC
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--


--===============8169067990935336431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8169067990935336431==--

