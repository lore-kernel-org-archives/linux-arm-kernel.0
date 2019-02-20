Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECA9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:35:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D84F20C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G3dhByx7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+GlPal0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D84F20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rSnScmDWi7QKKgP3PDF2UFApoyPT9WuBrZFWQrsqxH8=; b=G3dhByx7pXbxgsUhom9ICCJEA
	1p3POi4f6s1AUAkvKij4sZw4NbopikVV02zRB8pjGimco/dChrLay9jjgYT1AjBRvzmlEyG0ymeqN
	ognAIHUrLRU5ygExZuHtSUHkIfGgIYAGxgVzRa3LUOlxm893u6XfqIttmH8T4pp6pj29vXnW8KX1D
	D+BMg1Exzeg5I5kswigaAlN777Gujgtle6DDsysv3l/PExTFWiGn4b1TsOYllwxxnipkbgXrBi2SH
	caA7jSDG/EMeZ/QFYhrU16ADUkfRoHYqqQ297EwPdFEWzYD50fQ9HJ7Z17l6dXzB8QC+cw23lhYeI
	K/iDnru/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQ9k-0003BW-Kf; Wed, 20 Feb 2019 11:35:16 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQ9h-0003B5-Ld
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:35:15 +0000
Received: by mail-wr1-x441.google.com with SMTP id o17so25580535wrw.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 03:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=134+tCMDWqvyLKFxQMs23/byxLcIpJQj2h/KnwWi4rc=;
 b=s+GlPal0HlzvtPTW1F0OqKS+JnjTOt2XX517uAcGfaPDrNIZx/D/NRJZiZCps6RU0V
 9RT6Eb5FDjbOFGuZuFNds608QF56v/IPoqo5kSpfzSt54GvXpG9YYVc+UdZmZbt/8IBE
 ubC2wEYrKuIcuxcFzOvp0IbMBfAwpitXX2oNUl1jRz5Vkx6Fq0xEo+D0cx4bMOPqGw74
 5ug2zcSm7MKvgOTlTGwsxBKATGVmMsSQxeCMAia5UCT3oIPj26TNqrnOHjEgPmnrugOx
 sVNDCGExpkQ9CoE5ZVxVDIE4qUrYBrQ+2BLA63ZBEb9yasYGIl8aizwSQ0Y4zBfVoyMc
 m4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=134+tCMDWqvyLKFxQMs23/byxLcIpJQj2h/KnwWi4rc=;
 b=AMKrQzbIveh1n5ymbQ0fTC4viGa0eqA3fbMCS+wGJY8eQa092rtQklwQPqEkq8sLfb
 xBj4vGYA/JyZ4p+/R4oUPZkkgZeblY4XJgsL6G6YlNV3l4eOSfPg8Zkbmi7sULDvkFMJ
 rjmFpMAQybOSCwXGgo68gGPwBG1iD8/myTXs5aUkB/Bsu/IW2YU7wjImaFsbr/w+rCUL
 kx9qr6DZMAbXxJ6SXztb8Ksrvrzn5UEXQCHNt0OK3SVHxwyG8ztqwYXT5ae9luCxC/Kd
 epfDTN7Z+VrETHji5KQpncAxq5p8+MRMO/a7GXLCqyNJCqOsokoaXGDZk9EINPHo+Rn6
 KaGw==
X-Gm-Message-State: AHQUAuaRYPrekQ0iEKiH0L4g8PhA+HACzNiHFY3A3NcfUFJ8L5h9OZyR
 ggMKcIOfyZ/hXtZMF14cLfY=
X-Google-Smtp-Source: AHgI3IaB20AbHkvC53VEi8ynVnvYvnIBO8KXdKEAj44hQBDyoCWX8s2EJvW+NCzrFufvSvLAvWM0pg==
X-Received: by 2002:a5d:5504:: with SMTP id b4mr21094536wrv.291.1550662510864; 
 Wed, 20 Feb 2019 03:35:10 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
 by smtp.gmail.com with ESMTPSA id u15sm6249271wmu.17.2019.02.20.03.35.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 20 Feb 2019 03:35:09 -0800 (PST)
Date: Wed, 20 Feb 2019 12:35:08 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: hisilicon: hi3670: Add UFS controller
 support
Message-ID: <20190220113508.GB7498@ulmo>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_033513_729821_4A1D7F1A 
X-CRM114-Status: GOOD (  17.90  )
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
Cc: devicetree@vger.kernel.org, jejb@linux.vnet.ibm.com,
 linux-scsi@vger.kernel.org, guodong.xu@linaro.org,
 Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-next@vger.kernel.org, robh+dt@kernel.org,
 john.stultz@linaro.org, liwei213@huawei.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 vinholikatti@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5791389136278519405=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5791389136278519405==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 05, 2019 at 12:58:58PM +0530, Manivannan Sadhasivam wrote:
> Add UFS controller support for HiSilicon HI3670 SoC.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Hi Martin,

it looks like you picked this up into the SCSI tree (perhaps
inadvertently). It's been causing linux-next to fail to build since
Monday (next-20190218) because it references a phandle (&crg_rst)
that's not available.

There's a patch on the mailing lists to add that, but I think at this
point it'd be better if you could drop this from the SCSI tree and we
let the HiSilicon maintainers deal with the dependency in their tree.

Cc'ing Wei and linux-next.

Thierry

>=20
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/=
dts/hisilicon/hi3670.dtsi
> index 6ccdf5040ffd..285219dd657f 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -654,6 +654,24 @@
>  			clock-names =3D "apb_pclk";
>  		};
> =20
> +		/* UFS */
> +		ufs: ufs@ff3c0000 {
> +			compatible =3D "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
> +			/* 0: HCI standard */
> +			/* 1: UFS SYS CTRL */
> +			reg =3D <0x0 0xff3c0000 0x0 0x1000>,
> +				<0x0 0xff3e0000 0x0 0x1000>;
> +			interrupt-parent =3D <&gic>;
> +			interrupts =3D <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&crg_ctrl HI3670_CLK_GATE_UFSIO_REF>,
> +				<&crg_ctrl HI3670_CLK_GATE_UFS_SUBSYS>;
> +			clock-names =3D "ref_clk", "phy_clk";
> +			freq-table-hz =3D <0 0>, <0 0>;
> +			/* offset: 0x84; bit: 12 */
> +			resets =3D <&crg_rst 0x84 12>;
> +			reset-names =3D "rst";
> +		};
> +
>  		/* SD */
>  		dwmmc1: dwmmc1@ff37f000 {
>  			compatible =3D "hisilicon,hi3670-dw-mshc";
> --=20
> 2.17.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxtO2gACgkQ3SOs138+
s6EQ4A/+IUN1SE3WaCK5xyaflGB+s9Z2NlJHtFZjA849/vp6tdyveL7I9ngv1n7i
+zwaR089y/jpfWvnbRl50/RTyyxHbyayXeG3PqU8zyE56TYdCcpmwPBxELOzkyQr
GERB7gcYZgl8r0g69Fc2I6bS0El9NLWBD6uhuvbBFV8Emy1+M2fF0JNvUmQTrmHL
q/IwCUDkr17jSH/dYan1rGMKmyPQ5v3uRC/nVqgnc8jYKBTMKkZ3M9oEqbK7Wr2r
Fgri+YPa0PkJ0A0hhBxP2nEslmStWuJ6EQfUYI2veFxMGS/xnTjlWg1qnWuiyh5+
/UYcSGiYYfmoAOPOyrJez9Gn70Phnk4GVujIKrWtY7LjWbQbZE6tpQwjeMhfesMm
IBE40J0OIPifoM9ve8sKwL5jHKI8nUvGS80wCFaC00/MzNIkL8V13uZgkLhZwV/M
9r4JHJs1XHbrBXNdiYnJGW/i9Ct9tFiIGi92rnuR/yAhlXUhkFEPqxEb1ZmupTwY
xB6BagYolo44WWdPm0MgNn7WEFjSu7dhWcAHRalV9MQYMhYuSYD6Sdej1PktvhdR
uYK9U32xsnsDVH/ZLwkDL/SkdMfUeVX4/0HZG70jJv8Tzji0BsBioHRpPomy5Rsn
FJmf52KkS3RWgw9MCwXU5Jqh98cbQqZBE6ooTY2f+h8aOarTY/c=
=JXaV
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--


--===============5791389136278519405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5791389136278519405==--

