Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCEBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:50:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C3E208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pu2XE34m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3izsvzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C3E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M7LgN60lHLxrk7/TL3xN9IunCtXiRh3h8Cy0pg9zENw=; b=pu2XE34m53tn37l2PgC0Rn5Dh
	KxI15ED2DK0wakIfizpUn98SuJsZqBDIZvxDnyctn+bxBWma4o6KOaLektacobhXXP2EdHNeUUAr7
	5D7cTjYGJGBDLvP3DQy5YPG5yZchGdQscxAwOeDFVMKVJnQlvLata+zQG2NdpR9A3DCEB63qp6DaR
	fYqXvGk7GEgYxYUI+HzFALMAxmiRRtNHW8biVPTGbqpY98056eLnveK7VlihoTDEN5CYVGcKAspfx
	V6bQ/LEgHU93Mp4xueFnDciiajvULUSCrCFnIKeD54NuPPikM4kCGoMxv2Ivw1zrMhFaA0RSHf3Q8
	iLlyRXIbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6Pg-0008Pz-3f; Tue, 04 Dec 2018 08:50:40 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6Pc-0008N7-2p
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:50:38 +0000
Received: by mail-wm1-x342.google.com with SMTP id g67so8366548wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 00:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dkJecG6Gs8OQOTcX/RyiNwbjIH69LOnMZTRM0sVUBTE=;
 b=l3izsvzK4RpMVqUuQS11T5fHqltc4HIXZUkhMj1ow7YCknZc3UyLuN6T26GSKgB7fc
 Sy9PZW43JDHo2wDFgwtIjmxa51RTgmJplzf4kSrxIUqjBsQe86AnGDSsuVzlZ9P1gvV3
 oJ5ZXKsye+jYx7npN5s93SMgbsFJ+uZ6SACyiiBdn+jLDn+xCjg7poM44d6v7QksDHCW
 U7fA0Fh7PYuyotoJ+L7LHMbJ1z0BDwUa7PER6k+5a95ucP9Y9Nx02AtDDT37/Km6jitw
 MLrgJgRD/1/FjxfjaRQ8sPQ7FZik1D+qQQ0k+79aTtmu2kqbEiQQisATZJ/5JwXeKgED
 hhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dkJecG6Gs8OQOTcX/RyiNwbjIH69LOnMZTRM0sVUBTE=;
 b=H/KMebpeC3coTzmS6okgZ/2Tuj2Q9Bc46ksfdWm1T9vBpmVObEVh7nBIdojcQo6ecU
 JSteXM9e9x/pBPB4Nfg53mewWAxftHmLBBPY0NSwucoHmLiKtKWK/kSjz/eM4hMQFplY
 0agT74SxDHcmVxkxhBofy8jzEE4eWStqVA1pf2wi4BJT5ACZmOFFbDts0GV53l4nDA5w
 7eQC2WgfWiOYH9zzopmHCkAfV+LmEj24SkLw2JpMdVLwR5HRSs4Vy+/o0aSRFLXGxYxN
 6asSDUunCUq1z94e843mMFBCjMJV6pym8pz+O7sye8E83Vj/7qFZf6Suv4vtnAi7vOI8
 ShgQ==
X-Gm-Message-State: AA+aEWZsuJF47hz0P0sGLgT3NrkNOqkrJM5Z45U+ERPn7ITPVGmiEH27
 cAIAzCBPsSnrvDw1YPnJHWo=
X-Google-Smtp-Source: AFSGD/UCk0KkmagSSrE74B+GVNujcPbet0SyYa/t+3VqcmqMIQzUCwpCtDmgB+5SabYaMV/BGpvQhQ==
X-Received: by 2002:a1c:7616:: with SMTP id r22mr11412356wmc.35.1543913423872; 
 Tue, 04 Dec 2018 00:50:23 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id c10sm13844029wrw.49.2018.12.04.00.50.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 00:50:23 -0800 (PST)
Date: Tue, 4 Dec 2018 09:50:22 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 30/34] dt-bindings: arm: Convert Tegra board/soc
 bindings to json-schema
Message-ID: <20181204085022.GB25962@ulmo>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-31-robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20181203213223.16986-31-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_005036_134475_72479D15 
X-CRM114-Status: GOOD (  19.28  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Grant Likely <grant.likely@arm.com>, linux-tegra@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5105058782161721879=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5105058782161721879==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 03:32:19PM -0600, Rob Herring wrote:
> Convert Tegra SoC bindings to DT schema format using json-schema.
>=20
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/tegra.txt         |  65 -----------
>  .../devicetree/bindings/arm/tegra.yaml        | 101 ++++++++++++++++++
>  2 files changed, 101 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentat=
ion/devicetree/bindings/arm/tegra.txt
> deleted file mode 100644
> index c59b15f64346..000000000000
> --- a/Documentation/devicetree/bindings/arm/tegra.txt
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -NVIDIA Tegra device tree bindings
> --------------------------------------------
> -
> -SoCs
> --------------------------------------------
> -
> -Each device tree must specify which Tegra SoC it uses, using one of the
> -following compatible values:
> -
> -  nvidia,tegra20
> -  nvidia,tegra30
> -  nvidia,tegra114
> -  nvidia,tegra124
> -  nvidia,tegra132
> -  nvidia,tegra210
> -  nvidia,tegra186
> -  nvidia,tegra194
> -
> -Boards
> --------------------------------------------
> -
> -Each device tree must specify which one or more of the following
> -board-specific compatible values:
> -
> -  ad,medcom-wide
> -  ad,plutux
> -  ad,tamonten
> -  ad,tec
> -  compal,paz00
> -  compulab,trimslice
> -  nvidia,beaver
> -  nvidia,cardhu
> -  nvidia,cardhu-a02
> -  nvidia,cardhu-a04
> -  nvidia,dalmore
> -  nvidia,harmony
> -  nvidia,jetson-tk1
> -  nvidia,norrin
> -  nvidia,p2371-0000
> -  nvidia,p2371-2180
> -  nvidia,p2571
> -  nvidia,p2771-0000
> -  nvidia,p2972-0000
> -  nvidia,roth
> -  nvidia,seaboard
> -  nvidia,tn7
> -  nvidia,ventana
> -  toradex,apalis_t30
> -  toradex,apalis_t30-eval
> -  toradex,apalis_t30-v1.1
> -  toradex,apalis_t30-v1.1-eval
> -  toradex,apalis-tk1
> -  toradex,apalis-tk1-eval
> -  toradex,apalis-tk1-v1.2
> -  toradex,apalis-tk1-v1.2-eval
> -  toradex,colibri_t20
> -  toradex,colibri_t20-eval-v3
> -  toradex,colibri_t20-iris
> -  toradex,colibri_t30
> -  toradex,colibri_t30-eval-v3
> -
> -Trusted Foundations
> --------------------------------------------
> -Tegra supports the Trusted Foundation secure monitor. See the
> -"tlm,trusted-foundations" binding's documentation for more details.
> diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documenta=
tion/devicetree/bindings/arm/tegra.yaml
> new file mode 100644
> index 000000000000..66493892ffc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/tegra.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

Could you explain what these are? They give 404, so I assume they are
more like placeholders and not actually used?

> +
> +title: NVIDIA Tegra device tree bindings
> +
> +maintainers:
> +  - Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +  - Peter De Schrijver <pdeschrijver@nvidia.com>

Not sure how you got that list, but probably from git history. I think
it makes sense to replace Marcel and Peter with Jon and myself.

Other than that, looks fine to me. Some of the enumerations below look
somewhat hard to parse, but I suspect that it will become second nature
in no time.

Acked-by: Thierry Reding <treding@nvidia.com>

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - compal,paz00
> +              - compulab,trimslice
> +              - nvidia,harmony
> +              - nvidia,seaboard
> +              - nvidia,ventana
> +          - const: nvidia,tegra20
> +      - items:
> +          - enum:
> +              - ad,medcom-wide
> +              - ad,plutux
> +              - ad,tec
> +          - const: ad,tamonten
> +          - const: nvidia,tegra20
> +      - items:
> +          - enum:
> +              - toradex,colibri_t20-eval-v3
> +              - toradex,colibri_t20-iris
> +          - const: toradex,colibri_t20
> +          - const: nvidia,tegra20
> +      - items:
> +          - enum:
> +              - nvidia,beaver
> +          - const: nvidia,tegra30
> +      - items:
> +          - enum:
> +              - nvidia,cardhu-a02
> +              - nvidia,cardhu-a04
> +          - const: nvidia,cardhu
> +          - const: nvidia,tegra30
> +      - items:
> +          - const: toradex,apalis_t30-eval
> +          - const: toradex,apalis_t30
> +          - const: nvidia,tegra30
> +      - items:
> +          - const: toradex,apalis_t30-eval-v1.1
> +          - const: toradex,apalis_t30-eval
> +          - const: toradex,apalis_t30-v1.1
> +          - const: toradex,apalis_t30
> +          - const: nvidia,tegra30
> +      - items:
> +          - enum:
> +              - toradex,colibri_t30-eval-v3
> +          - const: toradex,colibri_t30
> +          - const: nvidia,tegra30
> +      - items:
> +          - enum:
> +              - nvidia,dalmore
> +              - nvidia,roth
> +              - nvidia,tn7
> +          - const: nvidia,tegra114
> +      - items:
> +          - enum:
> +              - nvidia,jetson-tk1
> +              - nvidia,venice2
> +          - const: nvidia,tegra124
> +      - items:
> +          - const: toradex,apalis-tk1-eval
> +          - const: toradex,apalis-tk1
> +          - const: nvidia,tegra124
> +      - items:
> +          - const: toradex,apalis-tk1-v1.2-eval
> +          - const: toradex,apalis-tk1-eval
> +          - const: toradex,apalis-tk1-v1.2
> +          - const: toradex,apalis-tk1
> +          - const: nvidia,tegra124
> +      - items:
> +          - enum:
> +              - nvidia,norrin
> +          - const: nvidia,tegra132
> +          - const: nvidia,tegra124
> +      - items:
> +          - enum:
> +              - nvidia,p2371-0000
> +              - nvidia,p2371-2180
> +              - nvidia,p2571
> +          - const: nvidia,tegra210
> +      - items:
> +          - enum:
> +              - nvidia,p2771-0000
> +          - const: nvidia,tegra186
> +      - items:
> +          - enum:
> +              - nvidia,p2972-0000
> +          - const: nvidia,tegra194
> --=20
> 2.19.1
>=20

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwGP80ACgkQ3SOs138+
s6F1lBAAqWmjjJqzXAlRqT/zeIxORQ/tP15oBBfsyT07n9XQ3qEnuR4sq0B24TBl
l63/fZ+81/lpv8Ile8LcnKIJs0ojIbSqo4RhDks0NkOID8+LhFRBQ6TlMAonqN99
VvtBXYCQTFWs0tk7qyz7/Nj5rsrJgpkKnKmmlRL+g0+tjz4IgrJWFkt4IJcJ9C8h
FWXB67whBSkXxeXR2GPY/6tYoAzgJWo2f6YxeRbXKZNaLV+cx3nUSrp60zIvRjgn
qdd3Hxj9OkIQ2vybA6+QPEz5AVsR+IhK4rcMj99gYswPykQ1xsc0r+L9iBn/9XwF
pwQZI2Bq/axHmqx6w2xW76tE78Dkb8K/t2N1J00ygr+z+Y4DTYtSkwvp1F18gSbK
FZQX1ymsc9qbA9MzBJGgLJ63szn5nIOFIb4wuP+fLYjbwj5MFO07oe5ArB0du2H1
Ciy1BLTTu5aqCXgTRnk24vE4pl1KaZNKdBwaNdhdrNQNAHDK30caNlqxrF5i7HGi
WFjlJr0M/Hf6duGWU0FBGtNLKaEPtVxHggjMeQV28gLm93Rw0P2yeqOcBquRgCfp
mEfmzvKLreReUfkH0Z58U9YESrsnM8FHn7HEJg736hTHjrzTmpSlOpWGy5KahXIz
cikPOjKsTP01LJEJ6/2D31XkAOGD55md3v8n38tI2LxxurUapD4=
=MF5A
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--


--===============5105058782161721879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5105058782161721879==--

