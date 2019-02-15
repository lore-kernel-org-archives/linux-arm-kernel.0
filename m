Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE14222DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Az3N/hP3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUXmih3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE14222DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FCWSzbXGKFhxbtREUWTw/66Y8vYMlVHJBGkvbNXbaOU=; b=Az3N/hP3JuH1Rs5YOYm7CMdE6
	3/FXiIusuQBAZyE8LUkg04db1LbhIFmhQxC44PMjBUjDfSA8uy/+UFYQFDZejMQ2SJRrjsAAohO3a
	2jSeFL7KriuTP+WIC614KOYvj0tDAo7sphCTKePMIcoi/0LIWhiBedmbVI08uoVu0zo5FLifbNYn/
	kRUfUijA24FVi/Um3cQpMrUkXlBTIF0HCAAk/0ej+XH8l6dats+k721yi+8Fzd1qNlloXdRi0HB/9
	Ot1ZvZ0tEkxvG/Iarr6YfwEQuRloLgwiyQxDRLx1cK7E6YWkbuBmqBN9v2NTye8VBcc5J876flaIM
	kpbWPzAiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gulLW-0000mo-OT; Fri, 15 Feb 2019 21:48:34 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gulLT-0000mT-4y
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 21:48:32 +0000
Received: by mail-wm1-x342.google.com with SMTP id m1so11534819wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 13:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=H0UNeMGeog0sEpv5KWWrm4MAOwdmUcClX06pvDr0B0Q=;
 b=pUXmih3F36ep6IeZGA6mhE+paww7aVCZtRw9lzQdULcjK3eDpiVtxleZm0hce6NOtK
 TR1Y/ydTRibxlrlqD+wloi6WK7Q0lIgSHnceCQb15MWNoLEhlPIsHM/Er3E6lqiaXcUG
 fDD+P48Sw4SB7hCf0Xw2uevSapBE5EhfWgxEHd3UUKmggcvZxjC8bkfV9wej0RXowW38
 RyDlSMoZkbNoHnIPwEAp09dIcJGc8OAOqdhlWFFxgqdwfR98D8T2CCsBQgEpuPB+1kZ+
 STZayZ/0Kr6vUMQhl2cOB7Wvjg+qqRiywZ2/vSdMZEHQ/g3nK5eza5lsNORKNRDKgpfj
 Pw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=H0UNeMGeog0sEpv5KWWrm4MAOwdmUcClX06pvDr0B0Q=;
 b=mHs3/0K918jvb34A6aDG0CnefmfXXzkronJepKtoaFx/gz3gFYzzorGtLqgVSiRGhw
 TP+ia1cwEApdjujkhfRDq4nHGR8OccW8gA5DENIr1bkFRuBE6w8W1yMhFyjMKTF0f2I6
 QDcfJ7YZEtK8u4dd9iDudyXsffIDN3fLwMlGZzAMWrOdBkpOTv8h9TwYqjbUEq4gvjyH
 bgBGZdqQPcMhR8DKE+5P+nVqAJ9cbu8aekAhBSA13sx9g1SFbhhqdsFvbTeFxDE21xUV
 UcCk4lBN8XA3v+xMrkR7ExXA6BcWOWTSyAWJZeCCkxtKgY+0H/ZobAYAAN0oduumzeZv
 dhsg==
X-Gm-Message-State: AHQUAub5nFdJQ+1zTO13KBiHetQzVsbf/neRADiEUBqOZYlQ2ZqCnUSf
 ndg+fdwzhXelR2HcIlQ0osU=
X-Google-Smtp-Source: AHgI3IZAyr5wYFXclPV54PbA3mNQSQetnADv501PC2E2qS3Vj/M9t2bN+OceW2bzRD4Ymsao8PtPTA==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr7709588wmg.124.1550267308532; 
 Fri, 15 Feb 2019 13:48:28 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
 by smtp.gmail.com with ESMTPSA id y1sm7997192wrh.65.2019.02.15.13.48.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 13:48:27 -0800 (PST)
Date: Fri, 15 Feb 2019 22:48:26 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 6/9] ARM: tegra: Core changes for v5.1-rc1
Message-ID: <20190215214826.GB12838@ulmo>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-7-thierry.reding@gmail.com>
 <CAK8P3a2vDG97hP80i6rknqFnDdpoCGMBpmoy2Gp-jUWnGJ5VCg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2vDG97hP80i6rknqFnDdpoCGMBpmoy2Gp-jUWnGJ5VCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_134831_189419_8C86E5F4 
X-CRM114-Status: GOOD (  18.23  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="===============5530303226735087983=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5530303226735087983==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 05:48:25PM +0100, Arnd Bergmann wrote:
> On Fri, Feb 8, 2019 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> =
wrote:
> >
> > Hi ARM SoC maintainers,
> >
> > The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee=
500c:
> >
> >   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/te=
gra-for-5.1-arm-core
> >
> > for you to fetch changes up to 1c6279b49d3ffff38357e93d112512fecf3711a7:
> >
> >   ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+=
 (2019-01-16 13:22:04 +0100)
> >
> > Thanks,
> > Thierry
> >
> > ----------------------------------------------------------------
> > ARM: tegra: Core changes for v5.1-rc1
> >
> > This contains three fixes for resume from LP1 on Tegra30.
> >
>=20
> Pulled into arm/soc?
>=20
> Should these bugfixes have been marked Cc:stable?

I don't think that'd be worth it. As far as I can tell these have been
broken since forever. Backporting this would be fairly involved and I'm
not sure if this hurts enough to warrant the additional work, given that
it's not been reported in all this time.

Dmitry, can you clarify whether you want these to be backported?

Thierry

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxnM6oACgkQ3SOs138+
s6GKghAAvzjv7yHNObjctpQ+geAbVuYXlxI075X1apxWDzKOl8VmtitxcDvX5Jfa
4xNCfSVrvGGKaPdn/HV93VS2DHNnvjfqwvAbmBIswxfEyVR145hy5nSSoVZo3pC1
rb+GFgMouNo9K1hvVljo2LwxmS4rD3vDzwkULBb5P3JMarGXlx+LQ81piP0zuZ5R
C5r/L8sER/wX+Klff9QZIRlLtDPXeCCFHIDG5VIQzUaf3k+DU99F1Zd7x5oNVNmb
bxEfKMvmhrvWH1ThjGAwRRiYenraLo1isnnMLKH3r/V53Dh5OYdMqB6tFHaXlKbF
eGf1C2OFbHqL6ohsPPhx8ljIU/CWqxcoIYosMv4VVB3n/v0rPxJ4KmW4nme5J1An
2Dks/hPr/H7kqRxcLnJ4z+3d65k39PvuS2UkPrfc7VyX+zKatFynOyE9qv2D6IXw
rMYeRNNZW8bQKul0rN0G/gcFyOyT4T4x6C78lCfJwr1Y1ZLDMTquuRMrunALfyqY
MvWxBVg/qdqAbHR8dGaqnFBJDRqXeY8VpDN44yXDcjjXazMBsggERB0Ltnpj1tSa
YAg/aJwT+3z5HzdycbL43xjLpT3TxPPYwk1T8rt+TOiosZ7WNNckwde1TFoJKe1C
1WnFn/d1GSQJ0w8ZjX+yZ/Pm+9dcx9C2fEkxusKn1qH+1TVez1s=
=BIii
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--


--===============5530303226735087983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5530303226735087983==--

