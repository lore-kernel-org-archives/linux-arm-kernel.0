Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963C3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:41:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626B020882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y0vrpJvO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="vfYGx4D6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626B020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZBZdCOPQf4av3/TaMlMv5ueYmGNxPh+rj2IyKF0WzsI=; b=Y0vrpJvOWZM1nHmOLFsjewEOD
	T4wjbRxx51cSXeBSd35+7v+JzGHIfneuhKUlPLIZBDslk17jBQ58u0rrS+tHSW5QDfl/5f7WieLNj
	76P1VhdZ83Yc4DYFher8hH5pTZMGinx5j15uwQfMMz2W2Gx/3oYjbYbKTlBW5vHImggbFT2bEQREh
	8aE/q8aH3hyOvUqV75ZyeurPKSLygyUtj7z8BC0xBCyoAkMFjb8CJCFchQvpKf932VudIQHJ6shnw
	PM3IWxnV+t5fNrNC61BBNTlIE4kutSwZVcRVIs6VdurzwLzSWpN47N4WjY5ZJnrA1YjrhzYhU0t7L
	FafrlY1Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gob8d-0006ij-7S; Tue, 29 Jan 2019 21:41:47 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gob8Y-0006hC-Om
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 21:41:44 +0000
Received: by mail-qt1-x843.google.com with SMTP id i7so24011848qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 13:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version;
 bh=p8xnOvZSHMvDSgZGAc1wzQUwKncdi8WTrdqxIvluZ0o=;
 b=vfYGx4D6OZSneIa7NZOJF9VhGjHOCtSSkHQyiAvEeG4tFMUixTqqEVi5FzWSUxFiFp
 rg0/BVEs/WVS/SPPolQsI/UwEMXfc/FVCxrXW9W0SgM2jluoSUHazATW5bGRAvkRGMOp
 vM6vXENljThoz2uzjjCqj4puk3H9QKpEx22Z4lzi5tzczZC0NO5Hasbm00Ar5T74iZjr
 BW3BKxE0V85uSntDWII+gx1LClNcqmW4/0QLFE9bfIoRrQ/Ty2jynf47P/KwJ741iVCN
 7Oaf3VpNFfZ5DhGiVwj74XN9XBNi7co9RzeOwVtSZGNM+0weTI6+kDfe4yw8msHu4dzN
 bIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version;
 bh=p8xnOvZSHMvDSgZGAc1wzQUwKncdi8WTrdqxIvluZ0o=;
 b=RcuB8bd2h170YkM27rgfSzTVjrM4lyyQrWOqMwDMuvJacQ558HIEaUatSTcvFykV1c
 ypdvb5dDKoGozDoxhgARp1lftWntguUSxcO6dgZUUg2Ka5KUy/uBbpFbrmDDeraxfzGu
 AKbPcmayTyTJVdLeO97nqn0/YKOMY2rDLt2kxaklFFhs08jt0owWUeY+d9Xdr89625vi
 M/gT+J+DmLMl5ufpvydLf0EpDkIdStPOgDjSOURX2kXzaJECKmPjmDRoqUKkrOcqB0Ro
 Mo435g7PM9sEH3NE4prPsnMGAo5qkQ+Qcz4r5RF3yx5624BfwNIxc4Wm2tlBp+wXWSjK
 h9jQ==
X-Gm-Message-State: AJcUukdP7lCKwoctnOHFhXBiU1sNHxXaG2VmZeuNJ+wLhbrP5hzejQD2
 0v/RcGgrj8w+0fiebrbSEFsP7A==
X-Google-Smtp-Source: ALg8bN60yPISFL3544dT/MqkG6QDr9VICZrPdWezny+OX7W1Ga8ij8CSzpschO4sUxnVEu3jJff5pw==
X-Received: by 2002:a0c:d792:: with SMTP id z18mr26408815qvi.183.1548798098924; 
 Tue, 29 Jan 2019 13:41:38 -0800 (PST)
Received: from tpx230-nicolas.collaboramtl
 (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
 by smtp.gmail.com with ESMTPSA id r47sm84192955qtc.77.2019.01.29.13.41.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 13:41:38 -0800 (PST)
Message-ID: <2442b23d3b0a00c1bd441298a712888e016acf92.camel@ndufresne.ca>
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: v4l: Add definitions for
 the HEVC slice format and controls
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Alexandre Courbot <acourbot@chromium.org>, Paul Kocialkowski
 <paul.kocialkowski@bootlin.com>
Date: Tue, 29 Jan 2019 16:41:35 -0500
In-Reply-To: <CAPBb6MUJu3cX9A-E32bSSjxc1cvGP83ayzZzUxa5_QMf6niK4g@mail.gmail.com>
References: <20181123130209.11696-1-paul.kocialkowski@bootlin.com>
 <20181123130209.11696-2-paul.kocialkowski@bootlin.com>
 <5515174.7lFZcYkk85@jernej-laptop>
 <ffe9c81db34b599f675ca5bbf02de360bf0a1608.camel@bootlin.com>
 <776e63c9-d4a5-342a-e0f7-200ef144ffc4@rock-chips.com>
 <64c793e08d61181b78125b3956ec38623fa5d261.camel@bootlin.com>
 <D8005130-F7FD-4CBD-8396-1BB08BB08E81@soulik.info>
 <f982ef378a8ade075bc7077b93640e20ecebf9f4.camel@bootlin.com>
 <82FA0C3F-BC54-4D89-AECB-90D81B89B1CE@soulik.info>
 <c3619a00-17e7-fb92-a427-a7478b96f356@soulik.info>
 <bdf14f97e98f2fd06307545ab9038ac3c2086ae7.camel@bootlin.com>
 <42520087-4EAE-4F7F-BCA0-42E422170E91@soulik.info>
 <ab8ca098ad60f209fe97f79bb93b2d1e898da524.camel@bootlin.com>
 <CAPBb6MUJu3cX9A-E32bSSjxc1cvGP83ayzZzUxa5_QMf6niK4g@mail.gmail.com>
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_134142_953474_E85400D0 
X-CRM114-Status: GOOD (  30.18  )
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
Cc: devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Ayaka <ayaka@soulik.info>, Randy Li <randy.li@rock-chips.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-rockchip@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============9003124925935533088=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============9003124925935533088==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-2kunDr+ALQ68ZYgOww0f"


--=-2kunDr+ALQ68ZYgOww0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 29 janvier 2019 =C3=A0 16:44 +0900, Alexandre Courbot a =C3=A9crit=
 :
> On Fri, Jan 25, 2019 at 10:04 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > Hi,
> >=20
> > On Thu, 2019-01-24 at 20:23 +0800, Ayaka wrote:
> > > Sent from my iPad
> > >=20
> > > > On Jan 24, 2019, at 6:27 PM, Paul Kocialkowski <paul.kocialkowski@b=
ootlin.com> wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > > On Thu, 2019-01-10 at 21:32 +0800, ayaka wrote:
> > > > > I forget a important thing, for the rkvdec and rk hevc decoder, i=
t would
> > > > > requests cabac table, scaling list, picture parameter set and ref=
erence
> > > > > picture storing in one or various of DMA buffers. I am not talkin=
g about
> > > > > the data been parsed, the decoder would requests a raw data.
> > > > >=20
> > > > > For the pps and rps, it is possible to reuse the slice header, ju=
st let
> > > > > the decoder know the offset from the bitstream bufer, I would sug=
gest to
> > > > > add three properties(with sps) for them. But I think we need a me=
thod to
> > > > > mark a OUTPUT side buffer for those aux data.
> > > >=20
> > > > I'm quite confused about the hardware implementation then. From wha=
t
> > > > you're saying, it seems that it takes the raw bitstream elements ra=
ther
> > > > than parsed elements. Is it really a stateless implementation?
> > > >=20
> > > > The stateless implementation was designed with the idea that only t=
he
> > > > raw slice data should be passed in bitstream form to the decoder. F=
or
> > > > H.264, it seems that some decoders also need the slice header in ra=
w
> > > > bitstream form (because they take the full slice NAL unit), see the
> > > > discussions in this thread:
> > > > media: docs-rst: Document m2m stateless video decoder interface
> > >=20
> > > Stateless just mean it won=E2=80=99t track the previous result, but I=
 don=E2=80=99t
> > > think you can define what a date the hardware would need. Even you
> > > just build a dpb for the decoder, it is still stateless, but parsing
> > > less or more data from the bitstream doesn=E2=80=99t stop a decoder b=
ecome a
> > > stateless decoder.
> >=20
> > Yes fair enough, the format in which the hardware decoder takes the
> > bitstream parameters does not make it stateless or stateful per-se.
> > It's just that stateless decoders should have no particular reason for
> > parsing the bitstream on their own since the hardware can be designed
> > with registers for each relevant bitstream element to configure the
> > decoding pipeline. That's how GPU-based decoder implementations are
> > implemented (VAAPI/VDPAU/NVDEC, etc).
> >=20
> > So the format we have agreed on so far for the stateless interface is
> > to pass parsed elements via v4l2 control structures.
> >=20
> > If the hardware can only work by parsing the bitstream itself, I'm not
> > sure what the best solution would be. Reconstructing the bitstream in
> > the kernel is a pretty bad option, but so is parsing in the kernel or
> > having the data both in parsed and raw forms. Do you see another
> > possibility?
>=20
> Is reconstructing the bitstream so bad? The v4l2 controls provide a
> generic interface to an encoded format which the driver needs to
> convert into a sequence that the hardware can understand. Typically
> this is done by populating hardware-specific structures. Can't we
> consider that in this specific instance, the hardware-specific
> structure just happens to be identical to the original bitstream
> format?

At maximum allowed bitrate for let's say HEVC (940MB/s iirc), yes, it
would be really really bad. In GStreamer project we have discussed for
a while (but have never done anything about) adding the ability through
a bitmask to select which part of the stream need to be parsed, as
parsing itself was causing some overhead. Maybe similar thing applies,
though as per our new design, it's the fourcc that dictate the driver
behaviour, we'd need yet another fourcc for drivers that wants the full
bitstream (which seems odd if you have already parsed everything, I
think this need some clarification).

>=20
> I agree that this is not strictly optimal for that particular
> hardware, but such is the cost of abstractions, and in this specific
> case I don't believe the cost would be particularly high?

--=-2kunDr+ALQ68ZYgOww0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXFDIjwAKCRBxUwItrAao
HMH7AJ9In4tsGt+ueK2AiiooucvNAJ+86QCdFysjbjVAgW9gD81I6i2cYXI9afk=
=CPiw
-----END PGP SIGNATURE-----

--=-2kunDr+ALQ68ZYgOww0f--



--===============9003124925935533088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9003124925935533088==--


