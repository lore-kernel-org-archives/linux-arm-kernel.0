Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C12C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:50:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B800E218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XOwDXuzq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSk0XIYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B800E218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=38u7frngR0KJ/9p9MMoPqBXuRPZrKPA00rZs2bGrpS8=; b=XOwDXuzqhcQlds8pitnMxrip/
	ZJ7UhkSbSMT+bDY4SW4HT5BbvfQww4BWx+VpnuCpOPdvkjua3aOlMg7Ly4RQUdT5dMv8Z28Ssnrbp
	HpIB7nHhTzJgNJPcpB/HEaQqd4VM9faAGLu+oB+oLF0LriLlmu8XIZ4jms89rTjoOy1chWjsNFQEO
	u5jwS6NOLrKS++E5qVFBLWHzf0e5dXerGzk4BkuYqBcUkmRr03xRhVH3YbNOF76I3wtXWV5HM6koq
	aZyO3cftKgXOkzxS2HAYlSKpkUWHmu9lzlQM5HCYVKK9WJqKD8OD6F7xJ3Scgd59t4/T8TBDuobIB
	4Z6pHjdTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga2So-0003E2-DE; Thu, 20 Dec 2018 17:50:26 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga2Sl-0003Cm-JK
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 17:50:25 +0000
Received: by mail-ed1-x544.google.com with SMTP id h50so2478170ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TUQTlyqc6f9mbz9aRI6ZWP4z0vW0Fjk9deB5vRyDbD8=;
 b=CSk0XIYKOwObwURHvhN60J4CJERe+WZxBVRlYLr/Fh5yltGDHj0RO8Mr33L8WCnN0n
 3MvCJx3xwyqrU2fo2gJVRpwNSCUDWD0ZjPvwiTaCNKhUFnG3Rs+2z13sgygnIT5ADo2s
 dsVWu5InSaFabM11L7LqJxajPh8SPcNL1dVpmm80i7LlzzaWOOM8TWus7eURmAZKJ34W
 MFwfY+ORSzGgPDxZweQfj4WWHl9+X+uXorEZmORfJIK+gM4/ThAxOQwn0RQMkT6ZXe9m
 c7oFSzxNTx3Fd8u/xNXfFhCJ4pugQ06x4C3bXEdgbGKb3QP+lNoYEfDW6hvjVdD8dpSe
 RHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TUQTlyqc6f9mbz9aRI6ZWP4z0vW0Fjk9deB5vRyDbD8=;
 b=uFFpsr59VLqhEZD61C9S4PB8lhgGh5vNRaUXhWl8BJDj1cj64jah/8k8gW73sNSma+
 C+nJrcsgrBBp+VOOaGS+r9PAR5hZSboa54CN7wEY3usq9OpngBDpYkmblDx4ifBn7BRh
 v1vi5bt0bHxK4DCN0m238zyXDWgGh1fNeX8aGfiRUDz+sdf3LkKE2q0dos2k4T6WPcvG
 u+fI2xEl0N3cuMCmDN3OBG9kRpdBQpW9CE8f8Fzu2qJsUEIIfZpHwDDA6GY3k72a7zgc
 Z8HIDUWXqkwJoltJP9RnIcLmGzEDkqvdSKPrrziEQsd3fWTwx/dA9K9GXeU1s4GYTR1u
 QvKw==
X-Gm-Message-State: AA+aEWY5ZfZouj3cqVs+VebtIU8vpsKa0ZFFHP4wV7PjsedFD6eFZ9RR
 hd6YaAc+cpLhghGmkK+MmHg=
X-Google-Smtp-Source: AFSGD/XlvvuHfiZCrBoZtfjTTj+clRp0f7moT4gbfvMhvlglGiu8+vAFto6P8hV1s333lx6h0X6wCg==
X-Received: by 2002:a17:906:515:: with SMTP id
 j21-v6mr12819054eja.39.1545328211161; 
 Thu, 20 Dec 2018 09:50:11 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id b9sm6594602ede.12.2018.12.20.09.50.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 09:50:10 -0800 (PST)
Date: Thu, 20 Dec 2018 18:50:09 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Hao Zhang <hao5781286@gmail.com>
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner
 sun8i.
Message-ID: <20181220175009.GF9408@ulmo>
References: <20181125161859.GA5277@arx-s1>
MIME-Version: 1.0
In-Reply-To: <20181125161859.GA5277@arx-s1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_095023_635781_3984D7F8 
X-CRM114-Status: GOOD (  16.57  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, maxime.ripard@bootlin.com, mturquette@baylibre.com,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, sboyd@kernel.org, wens@csie.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6672911300628498347=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6672911300628498347==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> This patch adds Allwinner sun8i pwm binding document.
>=20
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++++=
++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Docume=
ntation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..7531d85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,24 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +  - compatible: Should be one of:
> +    - "allwinner,sun8i-r40-pwm"
> +  - reg: Physical base address and length of the controller's registers
> +  - interrupts: Should contain interrupt.
> +  - clocks: From common clock binding, handle to the parent clock.
> +  - clock-names: Must contain the clock names described just above.
> +  - pwm-channels: PWM channels of the controller.

Why do you need this? In the cover letter you say:

	"The sun8i R40/T3/V40 PWM has 8 PWM channals ..."

Why does this need to be specified in the DT?

Thierry

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb1k4ACgkQ3SOs138+
s6EOyA//auHjqjKwvjCLwWgHXdVr26cFUnFn/Ml6ZHHRe+oLCiYsatv4AZfGFvZ7
CIGWN3zUu9c5YoDOd1isauQYgRtTsShWYC4gPxFFK9hWfb8f3o/wG60whkNDuvLL
1SAQ/KJTC01LQIEXfHlb60EPvKCtt4YUQG4PkTGBGOHSO+MhWQHRLy5aLaq+d3yH
KHaDZ0PuZvYNnFWi7W/ggraiIlRToPH8HanFzGew+gUfPjClrczjrGqgn8u0bAL6
MuKDMHLgjI/D8cs7XIaXc/OCPsp69B4JGrRJsxYh0KGKthaYDeKAUERpvsltDhGT
oTB55mJPZlriaiEOSwPrj+M0JQe9AnUIBVEiSIP2dSn8+rcSlWd10ysEjnCH/Ea7
ARkamiRCk2hgOhZlDZcm+hjh7VxnJinaYahGFXMszpVgCScHT/fjZKexGqX8NJa8
EWRJjeJaS1jLpLb7ZhM0iZrhzSC638G/5z3+1CWmyxwOvICb0FXzQDCTNSm1t8DO
NicV26tAWMIvDEW5PcTqrJaSvQmNrr4MiBiqocKs4N+ZA7Ey8JQW0oUFzwiwD6Ew
HaOuVXDlha1SZNK2tEnTDsTctXefl+eB7xeQ8MOHPp3yeKrpQlj4gHSyNOboEaXR
8el/ZC1gGYHPeFGPSgXTbRNFwNY8/9GKPfP5cUgLc+e1B7oWAHg=
=9v1O
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--


--===============6672911300628498347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6672911300628498347==--

