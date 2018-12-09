Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13484C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:52:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB94220661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fj7KBU3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB94220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iiccTpGREX2UdtMIKIvof3cBNBLoA1Hw2BpvhnGa3nQ=; b=fj7KBU3v5A+epmOG0LFG1lAcu
	qVhIq+yyeIn4C66z7iC0bdDNZ8PGG1q8jAyHGLZxX7GqkSokEdkEBklvYyvaG0APHUeYrDB/rPF3W
	q6PNhEMeOH3qJooiQgpZzA3dCvXaYFTbZPldLjwOj7rZsGnJdIA327AuylR3HF5cX3OrBGj2cR0d1
	sf819si1cyXiz3qDKD6Y1jmJAD/kQoR1bNu8pSdDILNezEmHuP/XhiFUSwWFTnxP+EVMKET/Wxlqo
	HJ1zPaGLfgcPsClCR2rZNon3ALr73+WEIvSNRGWlWOsQbzz8p377TPTyShMX52vKyG56f2ZDWR9ze
	gsY27eqfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW6zl-0004eo-2s; Sun, 09 Dec 2018 21:52:13 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW6zf-0004cp-Vn
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 21:52:10 +0000
Received: from localhost (p54B3357F.dip0.t-ipconnect.de [84.179.53.127])
 by pokefinder.org (Postfix) with ESMTPSA id 957312C6650;
 Sun,  9 Dec 2018 22:51:54 +0100 (CET)
Date: Sun, 9 Dec 2018 22:51:54 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH RESEND] ARM: dma-mapping: update comment about handling
 dma_ops when detaching from IOMMU
Message-ID: <20181209215154.GB5856@kunai>
References: <20181015105517.28032-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
In-Reply-To: <20181015105517.28032-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_135208_314961_5667B67D 
X-CRM114-Status: GOOD (  15.43  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3453430627953558494=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3453430627953558494==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 12:55:17PM +0200, Wolfram Sang wrote:
> Update the comment because we don't set the pointer to NULL anymore.
> Also use the correct pointer name 'dma_ops' instead of 'dma_map_ops'.
>=20
> Fixes: 1874619a7df4 ("ARM: dma-mapping: Set proper DMA ops in arm_iommu_d=
etach_device()")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Russell, is this patch in your realm? If not, whom should I contact?

Thanks!

> ---
>  arch/arm/mm/dma-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 66566472c153..e3b04786838f 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2287,7 +2287,7 @@ EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
>   * @dev: valid struct device pointer
>   *
>   * Detaches the provided device from a previously attached map.
> - * This voids the dma operations (dma_map_ops pointer)
> + * This overwrites the dma_ops pointer with appropriate non-IOMMU ops.
>   */
>  void arm_iommu_detach_device(struct device *dev)
>  {
> --=20
> 2.11.0
>=20

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwNjnkACgkQFA3kzBSg
Kba8Jg//RVZXpcefzwMK10YSzI6pXVYr6rrCsxnlj54ke0ZxWKEwjFOGS/EExTyZ
diClGz6hZGfbHw6sNYCWZVNM0gaGrYfOrAgjHSVIC5utBjp23t5cpJZ+qxphh4g/
9fYtBIXSamxWugLhvv7yBL5Z/ucP+TVINxwzkSwuplih5CWEnhM/J/8PVHqL1uxT
YJ/5AUoSh/nn651e0os9QLOzPmkS6S8wYpeKaPYmViJjo63mwtlOf70+k39rzN+Y
q3k/r2n4YweB9Xw0LH39C9yKvhHipGI/7NGUg0ZjIgSY1UR6T+fZriZ7okRUvxLj
wcCiqWHMd4GcSuryUaWFDnMKz/BIgSQCkvBVyxWBQBYj5rJO9Rw/Ej++j7guA5Dz
y4UELULL49kz6ofR/iWwnmr/KcF+k30iryzSwhJxKuY8GkhBZA+Cx3Y75aCyKOWJ
205j8fjGHUq3ufPG9UBg4YHB+vXMo0g2fNqZwzU2VaAX1IC2Y9MoQ6na2QrIKnp4
XcIRF/ip03W5G0h2cJXQDV6Y4n5HGbjCDcrMhXmvnDHW4CSwv3YoQaduAPmcsN9x
G5IASEOczFuhfddvwJvB1azo6dhAMfIG7TlTWnZHDdh3+7Fy3EFVbXD5nmVM7ha7
CB5eR6CTVzXC0NjaT32fbN1G6f6SNoy8mYVNCghaKGfkgfvQYMU=
=nRSh
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--


--===============3453430627953558494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3453430627953558494==--

