Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00BEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:27:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B864520881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KZ5aVJFl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTFZo5hI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B864520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uzNXU481TtleZUJ43IIO1tWMvZwY2hcVwfSxSNsyhT0=; b=KZ5aVJFlTbKLjn0t2OJRN0aqy
	6oMTeiOpSnexzLIDPCALZgszW76uTJz8Vt1hOnzDOYyAggXLsp9yt00XTkNJOHLRXWu+BnTuLGm6J
	v2A6Iw9ZEfUo1f4OPduNXogBJAhZe4xHza1+UvE3JSuooXx587e1S+/Z3ENGPQUNrP19r6uHesx32
	fpiuVAghRDAm5vo7wwZ8skZqDZlpUGtp43LDboO5ZRT3OXQHgpo8pkdGWzkfvMlNFChQxQYNZVolj
	4oidxAuJ+xUaUT8PWX9jgNBsfaeQg3hbY7Fe2uLhwgd4J623LPpyHSfxxWx1VLNqCvFyQEC7dRcjL
	74TipgErg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpAUn-00031f-9s; Thu, 31 Jan 2019 11:27:01 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpAUk-0002tT-GW
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 11:26:59 +0000
Received: by mail-wr1-x441.google.com with SMTP id s12so2866176wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 03:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Yp1UYm9tTXohwaujlcFwTfnSpZe9hbG7sald6QJOr6g=;
 b=eTFZo5hI9iQ9HnWX1kVYzX/9P2Zn1kUu5+FgPntJd50ZPM/iguzRroI7r1IQDSRhhJ
 o8+scDvVpgQqb6v//IkrBzsrZPmD84K0u60B67wAWRd1ch5xr5vWktw5UN0xHLVGObWu
 elScg0f6acVElWgyXPyhEmNvc9lzoYLXnmUbC/4kTLT2isZ9SyZ2Zz6ypj96wyfBC9Pa
 Lxhm6qKYqLgfgT586XTUahJ0oRX3aP3hd34YqoD+0lMRnnU9vkdoibcfsYIrHQ8tnXTM
 Q9KD7VWDNaCIiqVspZk7z5ACjtTT1wQ+WuaYwSurkmGYW6hvrWZoaZAbl4pGghI9BdQR
 G4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Yp1UYm9tTXohwaujlcFwTfnSpZe9hbG7sald6QJOr6g=;
 b=Hh1Jt7Zl3XZbaCJCPyogXcqBhbzjjHC+7E6cQePo5icJhKgg77rOHg8areRQy/wfti
 vL8/ZgrCUAXZ3vMILun0TTKmWIemmWwYCsqzwUOhSERImduZDkAaf0+wQk+f5R90ZQq0
 JCzVrWDnrqrCKJ6wx1iSD7FoKjwoN9jukpXeB8kU1kIgkdeSvnWlUIclEVCTpx5++Rig
 lbEKFZ1jPBdbw1yyTGfekIwEYZ6dYNRZSmJ0cuE5/z5tZk6Ua1zsG/oY0lFcAqQRKEHc
 buHZlaQ2CWQs2zHjiao56+LHy6An/KxL+WkfjWfAAeZSPeJUZnpx83CVI8l6iJPXQcXe
 iM5Q==
X-Gm-Message-State: AJcUukdritZZcwR4g/Drhc/DZ35igZfwnNvLU34BGyfTvJNClCeP/GjS
 4GOCikG0GntyACQWO75W7T0=
X-Google-Smtp-Source: ALg8bN6FSI20BzcFnqpLY2AT9BDybT8cdllx4zARuDYEmZg4j/begNmYW5rpM1r0ne9Xth4B4+i5SQ==
X-Received: by 2002:a05:6000:104b:: with SMTP id
 c11mr34606219wrx.303.1548934016697; 
 Thu, 31 Jan 2019 03:26:56 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id d4sm6346704wrp.89.2019.01.31.03.26.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 03:26:56 -0800 (PST)
Date: Thu, 31 Jan 2019 12:26:55 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V4 3/7] soc/tegra: default select TEGRA_TIMER for Tegra210
Message-ID: <20190131112655.GC23438@ulmo>
References: <20190131092410.28222-1-josephl@nvidia.com>
 <20190131092410.28222-4-josephl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20190131092410.28222-4-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_032658_577378_9DFAB878 
X-CRM114-Status: GOOD (  14.63  )
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
Content-Type: multipart/mixed; boundary="===============3969646089766168489=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3969646089766168489==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 05:24:06PM +0800, Joseph Lo wrote:
> The tegra timer is necessary for Tegra210 to support CPU idle power-down
> state. So select it by default.
>=20
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> v4:
>  * new added in this version
> ---
>  drivers/soc/tegra/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

So this technically depends on patch 2/7, so it would make sense for
Daniel or Thomas to pick this up along with 2/7, but you didn't Cc them,
so they're not aware of this.

I think you need to either resend the series and Cc both Daniel and
Thomas on all the patches in the series, or we have to make sure that
this patch is not applied before patch 2/7, otherwise Kconfig will
complain. If you decide to resend, this patch is:

Acked-by: Thierry Reding <treding@nvidia.com>

Thierry

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS234ACgkQ3SOs138+
s6Ha+g/+KksMkDLC2hmHrQkoFq3UeuPezAUmE3S5RGAUgg6/YsHdIfe2nyEWa9R9
CipRPytWvf8LarYPfrGVDLw2/xjPwaG5ksMPmYmbp7JTtFnIMjal4wD+E5gBMYai
vFqrzwKPyNBEpbuS00N+buJdPy8NbMr6uPmyQNBtYlpkFMEhXv5Nv5eHgECkX2i9
UY+sNcXRDSf7SaDK4y3ot3T8+K6hGfTPAhw9d0SwTmrxpUYfamOo8Y7qUJC83nac
705WMAG++oulqEUXuajZmvCuCMQXQ0NANjL/74j6i7hWb1RFCrS1OkgfgO0V1XD0
AzFYaHhPT0eFB2EkP3XBDhYZ9YtKEU88iNXjlnV+zt/Dup/CkojOM0C/28Z7JE+g
YYYTmEHXTCdY9ilPiyF4hgxI9EHpxj1PtwZLJSh/BxPGoIf7c7+w4uzmMIXzkcqz
nCgVsn8VTpEIW/dN749+BVWma40CtNPglJF7AnzV7zAuMfgnue4wknndd2+n7U8a
KFFUw4EbU4YM7msVtfz57i95X64h/HpVi+dkIR97znr+X+z78tE62c1TFBqRxEzL
x+Hxc/Zf0XgSxS90sx8nboxgnhVn/KVRgLhMXNv+Zi8PJ2QkfbXM207UafE+WC+e
dciyOw3hf2U7qHiqXQJ/VUYzFMpwzeZv3CaShkHPM6g6dbUJf4M=
=Y6zP
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--


--===============3969646089766168489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3969646089766168489==--

