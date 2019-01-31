Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD296C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:57:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A637E218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jZ0bjGVD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/+GlGEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A637E218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=baDHK5hN0uPdCIJWJJGZEA59aYa9RSrior+FbUB0M/I=; b=jZ0bjGVDhrhT2J9LExV1jCrMU
	43XC11Bb1sASoPbUbCEcbW4VgeCjSnYQsCe1Tg2Sg+pZfywkgzJ1/4llAlz1Q0bMp8d4gjaav1mob
	AWRUvCJJB4sDugdQYF4PbdfUHIxPCXa+RffrZFEFQ6HnQo1bq8hIE9w29nNK5BSQrFfJHTO3AJT94
	GOgdtbGzrQKZqiUFYbEWWjSBTE6bu2he8ixM7Z0A69q7xA/ssTGuCxaCMZxG7zuD7vFHYU+bKziVH
	NRtjCgwf70rF0l4UJ7mBTydnZ3kEZh8f9v5QG0URjEmt7P1TOGOOevY3tN2WZSImnXos4i7Nz2/wL
	YzRSDKq4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBuB-0001U5-6E; Thu, 31 Jan 2019 12:57:19 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBu7-0001TS-Bf
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:57:16 +0000
Received: by mail-wm1-x344.google.com with SMTP id p6so2459515wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 04:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xdrkkZ8zNkyyvwabg8/Kce1vs/Znds+4PLfa9cPBjTE=;
 b=J/+GlGEmBN+mGEThHz4QyaD8Q3fqc32W5wDJgC+SL3+e3N+IqKCRzG4A0lGK4alXla
 HDekhBH9KhrLADVyvrs2gbExXl5NDc7hijyJFPhlSCt3xFOO55wbE9c7pCPZvHY1J0FY
 mUyC1oAPU/qex6fU8aLSKW6lNLvxcCVsN1oS6w5yIshUmTEcxSbCGSM9uwYywgz/6bwK
 Kd+Vhs0qNlgDaBwJ9vgJyChKEL8skyV2SQ7DIi2wRWEJDzmd5BlG0rRz56JidS2uVnL4
 S0DyHnwU7a4nSD55ZEUelbjn8XPw2Mt9U/TNNILxtPeSAcNq9C5KRvRnPf0Mjd5M/HKX
 irWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xdrkkZ8zNkyyvwabg8/Kce1vs/Znds+4PLfa9cPBjTE=;
 b=MYh9AgIXsBU+PyEdeX+NUKfVlbQe8xjyrpWlqwjFBPLuxlbr5Y+aEYHsu2kZoIR1Vn
 j2xX1w2U+oKesuzzLJhr3QhX2n7CXGUd339gwcuKmhgujgJ0XkbcH38VGYATWIc5qTxN
 UcC9b4131SsgpvA7q6YjIOMIWdcOKtARaqVwZBjRW+qNp83jpOEchZJbOMmU8S7rRfk8
 jLQetPSdwYOKj/LirkoEcTTpIrRa7+rQ7dKB43mJU+9LZYSKn9xf9MYyKpxHFQJ2mVWw
 6TMpAAm1747Rd1u98gErG8KnzV6aQ/YkaopZlPVzfUEUJ9ldDk814kqxeRKzeOftRMkD
 Zm3w==
X-Gm-Message-State: AHQUAuZAcWte5pu2Pnr1d/1TYbijUqKjnJGt5K7/ApU+IGBUSGs0AreH
 eOZfq7M1r3mdbfNQK8gm42U=
X-Google-Smtp-Source: AHgI3IZKwyYinxH1QpCn8T++BYqKF/F0QBUlpXMajxfO7CiQPRgc97YSkFcSyPZT4Lfu+ARYxguLrQ==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr2180942wmj.145.1548939433307; 
 Thu, 31 Jan 2019 04:57:13 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id k15sm5821823wru.8.2019.01.31.04.57.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 04:57:12 -0800 (PST)
Date: Thu, 31 Jan 2019 13:57:11 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V4 6/7] arm64: dts: tegra210-p2180: Enable CPU idle support
Message-ID: <20190131125711.GL23438@ulmo>
References: <20190131092410.28222-1-josephl@nvidia.com>
 <20190131092410.28222-7-josephl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20190131092410.28222-7-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_045715_420388_AA9C5734 
X-CRM114-Status: GOOD (  16.43  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="===============6831676933274225653=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6831676933274225653==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gmhhrsDozM2n+uz5"
Content-Disposition: inline


--gmhhrsDozM2n+uz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 05:24:09PM +0800, Joseph Lo wrote:
> Enable CPU idle support for Jetson TX1 platform.
>=20
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> v4:
>  * no change
> v3:
>  * no change
> v2:
>  * no change
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/=
boot/dts/nvidia/tegra210-p2180.dtsi
> index 053458a5db55..d1a492c63e96 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> @@ -305,6 +305,12 @@
>  		cpu@3 {
>  			enable-method =3D "psci";
>  		};
> +
> +		idle-states {
> +			c7 {
> +				status =3D "okay";

Doesn't seem like the code currently cares, but the bindings are
specific, so this looks good to me.

Given that we need the timer in order to get out of this state, I'm
assuming that I should hold back on these patches until the driver
changes have been merged to make sure we don't regress. Is that
correct?

Thierry

--gmhhrsDozM2n+uz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS8KcACgkQ3SOs138+
s6F85w//ZZmfY0LXgFe/SNF2zAqb+A8PuEpwhY1vyW3fIlGZih2CcGLC5hqvP0T5
Mvj1dUpvwuTxWc03OK208/+HTPKlGaV7L2zsZFxETVZqEGNxSicUtdbSM6E0j7t6
swRUWgpDsG+5IBXFLSqhD7fJoZBlqVUSGs7Qi+nHGg+U9HKZjxGRZlB1SKZXSb79
4b50pyIQcXlIcxclIeKKWg6JhANqTcZz5biVIcSLRlF98TcMTwwkit7wrwBIFcN6
SbFo8VOoDD6mFGHbNylLNK4Ze/hTBB4/DrE+oy6FCJ9p5DrDrZZx4JCOTFKfYUYU
l/JTaxkNvZ7IvP8T3y0DqB8FMTflkdDlHi4jciPkUgiKYyNBhrSGojlO5SMRL5rE
dIeTTVMpJZi1MDvALazq5ldhe+iZnKWXmKYro+QCTaS5m4zxs3KK4F6ELN/h0AOv
NJzluQ3c/4QoCJ6aFr+a+hyU0yWn7BjGebGhaqsN2c9CGygX6LdFYuXy7O+jMGEB
rmFZf4oeyOPDdMt4wijTzpmhNyzQYhRpibktGhqDxpL2nlrAHLhsKDKocZEyeqyS
w/pNjVpLWlHBFbj6S+DfNN5atlIbQx5wgouEMrnWQgvwW4+Ko+kYzB7WcAsXJoWw
suhlLUGMS36clexmesvR14idfDLTmqM1r4O3LtTjarL8NCx+Bxc=
=NAvK
-----END PGP SIGNATURE-----

--gmhhrsDozM2n+uz5--


--===============6831676933274225653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6831676933274225653==--

