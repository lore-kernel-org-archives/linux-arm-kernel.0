Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256E4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:23:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB29020820
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n2yjTEAU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psY1cC0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB29020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RWi5dGUPdRVEIK4djziCs//u4NyynVBPM5nU3N1N9L8=; b=n2yjTEAU86NZXjaoGqxCqU+Vm
	yJbmSCDVwdjjkA522rQnWSKgr7mHBi5EjxeW9Rf4ltqdhGbeGIJQWDbYCgvRAPxfCtYLIAN0hkwmA
	D4nc6dHSSM0FPAMzFXzdTxvAN7gWwFviUGtxz2+EC0QbFKMUU9q24ko01QLYF2+c8G3vHXCWsZGyO
	fxpI7pmD8OInlwnP3POs2ilaY7H9uk2a1Ny5F4wH5Osz855J3V580yDuGEWJXLtOOzZ/7Hh6Qdwaf
	ra1KQpA5SY1dP4G+sm2RKDQ5XkNC73GkGMVoKeOa92XGeZOpyDgKAs13OWUS1133gaSUv+nUyJNrk
	N1/uQb/5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpARj-000162-Kh; Thu, 31 Jan 2019 11:23:51 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpARg-00015c-Dp
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 11:23:49 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so2791199wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 03:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QAzHz2lgPibHLBj7Nb6iWwJlAWoldG8Zl0ALZrbS5sI=;
 b=psY1cC0ukcvlFMT0p9LcU46M89jbCTFGiPsWlSEKvTenG0FdBIf0K9vTcbC02cSIFL
 BwIiB7f+WJZe8v00uGTVPzCqz4688i6/Xl2yq4t1nG9rn3MC1+0odf1vaF1zpaKXtlim
 Oe7QZnLnq7cjYhYTOFrRyrQNgfwMh+DoizGiItrW2Qqwt+rd70uB4DcNXuoTRvZi5tE2
 SAQfhr2kkIaYLhmLWiYB/CGk++pIXAnqMIZMeUoEQqM6YBBAU8gtGl1AI7VEDp6pJSXB
 H2GmgUDh1xsdmJI2TSVuUOjgibcRJaD0QMJPdx0RKcF6coWOeBrGPhBK6ShbYvX1a6fe
 gdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QAzHz2lgPibHLBj7Nb6iWwJlAWoldG8Zl0ALZrbS5sI=;
 b=Y3I0NERdnTLhKJURV0N2ROpPvMKLlNphhHbQZAWGdGdWNasQA7WFYRB3Lj6Iq4bspw
 3m0ImeOeHYeeq+Jusgy6LyvpXkOrVBIZVf6cPJEJ8b57oBJzv16+lTviJbUHVBKqyMGx
 vK6RtZz8u/rq+lib35GI+/joZpLQvfWXF9wbNpP8Mv8qvJxRDZNdD9JkGvj7Z8z9p5NV
 oHl0lbFBJGoP82hU9+BMhjq2U/uqbnckfXiO/1CbK5A7CZUywx9QZJ6X6Giv5/fDmnLH
 g1qHSGGYqtgu6T5tfdRWKEYfiEsZQVHOJVk8gubj4J27E3y69OYvUR6Z/tj6uwWZDuiE
 FRiA==
X-Gm-Message-State: AHQUAuaMNq+6sKJJkcGWOF71MAgOUkIt1spHoNsiiASrA4TTzJnROYau
 vOXzqN/k3cfG72TDU+B17dJvLWrVEEU=
X-Google-Smtp-Source: AHgI3IbNnTGvLdOr4Pp0o+JLRXs+An9jsP+/K3kuAFKn1cgkCBTqb0cSiyAIFPJJl+COeX8EIXakog==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr21503051wrh.267.1548933826303; 
 Thu, 31 Jan 2019 03:23:46 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id 199sm5111604wmh.21.2019.01.31.03.23.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 03:23:45 -0800 (PST)
Date: Thu, 31 Jan 2019 12:23:44 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V4 2/7] clocksource: tegra: add Tegra210 timer support
Message-ID: <20190131112344.GB23438@ulmo>
References: <20190131092410.28222-1-josephl@nvidia.com>
 <20190131092410.28222-3-josephl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20190131092410.28222-3-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_032348_461955_23EEDC49 
X-CRM114-Status: GOOD (  15.01  )
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
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4952983216885255390=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4952983216885255390==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 05:24:05PM +0800, Joseph Lo wrote:
> Add support for the Tegra210 timer that runs at oscillator clock
> (TMR10-TMR13). We need these timers to work as clock event device and to
> replace the ARMv8 architected timer due to it can't survive across the
> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
> source when CPU suspends in power down state.
>=20
> Also convert the original driver to use timer-of API.
>=20
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> v4:
>  * merge timer-tegra210.c in previous version into timer-tegra20.c
> v3:
>  * use timer-of API
> v2:
>  * add error clean-up code
> ---
>  drivers/clocksource/Kconfig         |   2 +-
>  drivers/clocksource/timer-tegra20.c | 369 ++++++++++++++++++++--------
>  include/linux/cpuhotplug.h          |   1 +
>  3 files changed, 272 insertions(+), 100 deletions(-)

Looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>

Thierry

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS2r4ACgkQ3SOs138+
s6E4kw/+KIr1/qDOYKPC0vig58FLCc8MiVQkfgBHJc6+1ItsalgY5BQsUbedis6k
hHROsupsiqkLH4u7KWL/kxeJeG/bxkyqjSw3QKE7ql+UOa/h0HVTaKBqtRFAoq3b
Dvrve2WDgczk1+4XXaqbwh3s6pprOsH+T85vUDR2OT7yVeiWuXyvIS/mwoxFpOLN
w8kGBcW6Lo0QDMND50ZJ2gJJyk3CHQhqeUVqQMtVGG/+qG+dbKvwiR9BLA3gekqG
KUoTSJnpmc02jYxIct8WHBBD6SckJtcBvLi5bBG5Zg/16SLOFxSLVVWPKEXaMnzP
/Bd6GYCbVu/8CVFH8lLU377YK4Ca14MWS2lXhCgWGenvXPa+DEP5Pq5Hedxauanl
HQ6Gzc6QHtNQeaLrHasJ8QLDYyUhw2sL2Vwjs+Xn4gWcsy1/T7i+l08bmjEXWLvU
cvQwO9KP3vg0BWXqB63JhvZZTkfKsPWgdQppon9GMxKwQEmI4smM8d3PGLoY9xl5
i+GBTffLp45DXlDyXTi2AE+9OMxCh6NGqnUVgysOEi6OLHz+VmsG0IE+yNHRuII3
BzLnzE2R0eeptzEBy7qaQo6v1CmOhb6Vk3Cez7TUzBVen9hmnazkSfx3t1+1Li2f
oggvSwpAqz6rlGNd6byY5MuLpQXB97R3WjGbzjZSxOnPNDs/y+I=
=JPuk
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--


--===============4952983216885255390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4952983216885255390==--

