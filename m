Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014DAC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:17:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C1A2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hCvkfN16";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA4S29oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C1A2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KJ3V9YPwY0RvdEElATe/yqcRoEAiJHoPfU8zTCjo+xg=; b=hCvkfN16rUmQj4bFPMwR2PBKk
	L/Dx/rx9ju5xBEk8tgZzi4iu36kkwtqJoDyGLz71UnBnu3uga/356knBSx1CMfbWcBnAL8L4jGGza
	DKef9Ca07js/w7kf/nWYQQMF+zKmLycDMzF2gvNcVyJNq4elhZBK/5+YHR7XUCXSZ+4ajTmTtF6VK
	4v69lvPdJX3xIeWiLvcHSKhguKOnEqnUgYOrfMb7uiZYopdwRJXhuxwnT0wznlcbGNAJykx3N6Q5Y
	++z23Rh5tYhMS92WTq+Gm33GaTgtnU+XhXKxTZNVV4PcpKxWvDu7ac+0txAsJW1kHiNZtfTKgHuBg
	2tgB7Xzvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9bR-0002x3-Qx; Mon, 28 Jan 2019 16:17:41 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9bA-0002iL-Fy
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:17:26 +0000
Received: by mail-wm1-x32c.google.com with SMTP id g67so14527021wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VwVsEA2njTY9kmtgz8zYxOdAC1khnlriZ3fSWEOj6Pg=;
 b=TA4S29oowlIuR/wSOjVAJWHABKVmbfGKaJHNGPpARmmLW1HpV79Cd38WlzYikFerQM
 gBGg3ah88sJEs43r4Fr5y8/HOH9b1gjNjP4SRnFFZToHUpM/OTfDVE6K8rz7ZGuMEAeN
 Tn6P2p0BmTVbEtZOeoTctsboBTHxSV//1ifbVzqyyGOOx6Q8dFa1N45VEarWt+idixu0
 bWc+n8LK+SyHjjoE7zedtsqgbHqT+kY5jRUZNTb2P2+FLjflcCMnreLSRQDEDUkAR8K/
 WOoW69hCYH3lENT7MyWXQSgUWCcElxlDxRL3fB9AJ+XlGlpj9rodqhnX0/Jf+oCpFTop
 SZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VwVsEA2njTY9kmtgz8zYxOdAC1khnlriZ3fSWEOj6Pg=;
 b=fNM2iibpa3U1h3EckeueH/w1KsD5QnHDSNrEvwT2cHQcfbXqjsMLbUBE5bnaI39jUd
 MYOBcqR9/IRcwzz22fRoVDy9j/Is8yfRFc0VRj3yPlI0Ct6tguDCMRpdzQcLKHOaJJ4O
 vbCQHEWK2x5kIazxt3NVdlYY1NK7ICwzR0f5EzK3M3t6UZLnWa2kChnr9IPM8F2OQnpU
 GO/IcWlDG2qqWrfg6LVa1xvrTZ6TYzxDitT3QF3YxzEQUfF7sZkXD8Kqf0U18ulEjDgT
 sq2DevUQwpwa/VLnV6908hZkUjRMIJTaPy9ZFnvwnoYzBkrjF2ExXy2nQcf3NjKjbNU+
 TtXw==
X-Gm-Message-State: AJcUukcMrmaakc21MgBC3Xw+X7fF2P140HqTfKXqE/wIztquttDQ5SpH
 wnxbtFhOBiD0RG3tOiGoUVA=
X-Google-Smtp-Source: ALg8bN7BdFLsNlp1vWslEpMOoUN7x9MyLbXxytcmeKWEDcfRrsi4TerWrgUtvSOQqwVQpTEXmbjcVQ==
X-Received: by 2002:a1c:c543:: with SMTP id v64mr16903037wmf.123.1548692242563; 
 Mon, 28 Jan 2019 08:17:22 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id f14sm96752343wrv.56.2019.01.28.08.17.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 08:17:21 -0800 (PST)
Date: Mon, 28 Jan 2019 17:17:20 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Eugen.Hristev@microchip.com
Subject: Re: [PATCH v2 1/3] dt-bindings: add vendor prefix for PDA Precision
 Design Associates, Inc.
Message-ID: <20190128161720.GG26200@ulmo>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1547458584-29548-2-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_081724_550521_75BC76BE 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh+dt@kernel.org, Cristian.Birsan@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3498653039445537759=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3498653039445537759==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 09:43:26AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> Precision Design Associates, Inc. (PDA) manufactures standard and custom
> capacitive touch screens, LCD's embedded controllers and custom embedded
> software. They specialize in industrial, rugged and outdoor applications.
> Website: http://www.pdaatl.com/
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied to drm-misc-next, thanks.

Thierry

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPKw0ACgkQ3SOs138+
s6FjaQ/8Dz8ooo1Sw+gdDzpk+oaeVdeilOjCttAtRJpGhZkCnA12MCjqsVPrpn3M
kjEAYf+3mz4cK3Dbe1A4Cvjuog8kKvbpnVePdxky/A/QtIO6rsMlwvo9gX5kZJ54
IbmmYWO2szqXYa25QjqUCpUtRa7sdZQ/sOaaLHh60orWq7e5zavuuxUQNHr2+UGT
Mp5erO+18P1SdRyAKrf80Fzq4CYTbtLyvDt0hZiHoddC8fYy17L8i8a0VmdRMIcI
NXEwC7XA0XlRJsiqYXJZqizxKALkFfqzkHbFK22rdyLlb6bKkC/hHwTVk4Pua6BC
P0RYSH7ZHd3oyHJco8pTIvwWrHRwCgHjvzo1Bgun1uJZpFuIGRcUhWxVlyUG95i9
NuWJxkEXQA7mjXNmJOyvPB9CTGlXPF+UQ9WJ5/dTqHuZdIhYWGrtoCHlqlscuWws
Ewmjd1axA53lQQoL/WDJxNWIU8p8s7XIZqgGHv1WFDZwJCioKTlEcUPfnq2MixPR
QAo6WjFy1LGOlpZJW5ixf3OiftbD9Dup8S4/ZryDnC2mSB3AtzXZ/XuPo+MSrqhs
UuNSFSTo5NYB0TmaE3oq+d8ZnshuwH2qN3RZSNCgzELkiEmHdrFza2+nhIX3eLNP
v0lkzln3ZyN31aXoDmOK02tx/bl6YCVQBoNU+zWkuIdwEF8DOk8=
=/+Y0
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--


--===============3498653039445537759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3498653039445537759==--

