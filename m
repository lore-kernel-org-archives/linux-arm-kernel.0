Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44788C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:09:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163402077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tnxpiBPc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fRHDZU2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163402077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GinGS9PuykVG+UgoHnqhx7a1ELVnCTh+Innh4yaGJh8=; b=tnxpiBPcqX0YcfVkqYvqB/Uei
	9LDFhtCQScKvyhrsy5yYtPaIvR9opdPBObl72JIJfHelp/VEuFRtrvkZ7IgILt5BGYbFgfFfl1yXz
	TqwEhDR6xitlBiJ0X8MVC+Aw1OTS6CrWu8ZIj8fNH8sDfA1sFuPkc/WlPlsyH0FqjzDT18/9bzIx0
	CjPkiDKdmBPAOeBsQlvWWOB1loJOcLxvZLIZvZfu+C4jQWlHoXg10hUur88LnGGmGcx8VERcDLWrY
	Arz0ropxQ58SqxXonE6ah6w9UapSe1mMBZhsdQIsabxXHQEQ4TtE0wfHiNfw4omRHtkcT9l14fyPL
	6+c5ixniA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvkXb-0005Ya-IT; Mon, 18 Feb 2019 15:09:07 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvkXX-0005Xj-16
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:09:06 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c6aca890000>; Mon, 18 Feb 2019 07:08:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 18 Feb 2019 07:08:57 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 07:08:57 -0800
Received: from localhost (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 15:08:56 +0000
Date: Mon, 18 Feb 2019 16:08:54 +0100
From: Thierry Reding <treding@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: next-20190215 build: 2 failures 19 warnings (next-20190215)
Message-ID: <20190218150853.GA21119@ulmo>
References: <E1gukSa-0003kX-JD@optimist> <20190218113217.GA10794@sirena.org.uk>
 <20190218120921.GA11524@kroah.com>
MIME-Version: 1.0
In-Reply-To: <20190218120921.GA11524@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1550502537; bh=wOon7tVfwFXQ0NyZMBRYUGNF2k7aW8+2gsFVJNQ/zeE=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:In-Reply-To:User-Agent:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Disposition;
 b=fRHDZU2N/rzZQooq7BgDVwKj428QibrvwzDz+0JFrpnEqyINvRMqBmuibGzksDk6J
 6ANmKlaJJw+gPdNhzumpHReus9ASsB+gWAGJOe/A4+P9MpFt+hBRTsWyT9dqy1XGnK
 /mG7/Ew3DqxwzySzBKeb0vpcRHip2XUGqgz/AdFg737RBY6e2rESziWKWBs+xD+RqT
 EIsoxoioc6An5zWhpB/h2KB0G+f446cDkdPquRTjdrJuWYSXpcJHZZ6ID0M7WfvdK0
 0jB3d8SuQkihNS7a4i3gLXoXzuBr9fedo0o3SLzeV9wI87IbKD02x+vs5y//qUtOvZ
 0k1zUXP5RdgPA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_070903_087212_DFFC17BA 
X-CRM114-Status: GOOD (  20.90  )
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
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org,
 Jassi Brar <jaswinder.singh@linaro.org>, Mark Brown <broonie@kernel.org>,
 linux-next@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5074390175044677547=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============5074390175044677547==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 01:09:21PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 18, 2019 at 11:32:17AM +0000, Mark Brown wrote:
> > On Fri, Feb 15, 2019 at 08:51:48PM +0000, Build bot for Mark Brown wrot=
e:
> >=20
> > The build failure with mbox_fush() in the tegra-tcu driver that was
> > initially reported two weeks ago is still present in -next (this report
> > is from Friday but it's also present today):
> >=20
> > > 	arm64-allmodconfig
> > > ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!
> > >=20
> > > 	arm-allmodconfig
> > > ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!
> >=20
> > Is there any progress on getting a fix merged?
>=20
> I can take the fix in my tty tree if I get an ack from the mbox
> maintainer...

Maybe we can do the below until Jassi picks up the proper fix. There is
no hardware currently where we'd want to build the TCU driver as a
loadable module, so that would be fine for now.

It's a bit of churn because I'd want to revert that later on, but it's
not too bad and would get linux-next back on track.

Thierry

--- >8 ---
=46rom 5086e2ac9359c8d24d88ce1beeb7651e00401e1e Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Mon, 18 Feb 2019 16:04:49 +0100
Subject: [PATCH] serial: tegra-tcu: Do not allow building as a module

The Tegra TCU driver relies on a function implemented in the mailbox
subsystem but is not exported. To avoid link errors in builders, don't
allow the driver to be built as a module. The proper fix is to export
the mailbox API, but until that happens, use this quick fix.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 72966bc0ac76..e46a285fb8bb 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -336,7 +336,7 @@ config SERIAL_TEGRA
 	  and better performance.
=20
 config SERIAL_TEGRA_TCU
-	tristate "NVIDIA Tegra Combined UART"
+	bool "NVIDIA Tegra Combined UART"
 	depends on ARCH_TEGRA && TEGRA_HSP_MBOX
 	select SERIAL_CORE
 	help
--=20
2.20.1


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxqyoIACgkQ3SOs138+
s6FavA//ZGQbR41Zzxv8ddgHuU1y7idmziGiXRwq674B42BoR0Q8EwjF0QIAvIbc
gub66MtH1VjnnWKp3cuLG4viwZARyerqYrgHkKFwEyPEEjvi5wTQTy4ZiQtktj39
CtazwNdXFXyNXuuQMS+/3IVg6zotewXvaezwFJ6699j7IN8a1GIT+IVO1AYTRotv
RCHupMM2rVkNRcX1dTUWVpcX4zmSIItGjd6R2nad5gi6Dj4wjwlxzMQC5pnFiAkh
QlCyGB03mogKEk0MKfyy0Xr/ohgIN6M78BGgunukFy3JixyJclpB+8zVJ6a+cKPj
EuN9E41OXGFXpVdCnhmmAR1scYdD0+MAEDl4bBc7Hp7O7A9qmHTNACLOqqTvhG02
8bpZU5sjjdfvAl8OqZggadad5UrS8aj3JBVcEX5LEy53EoIzfz3B2O215MCHj20W
npPEZL7Fk/6Op+Dzy4PCQHIF5Iw4EE/+3Ca6t124zESD0pWXbyIeTmRJgLDajX54
UyBIipZabLxCUVX2Pc8/oR3zaFaF/06r7R2ZQMNSOg1bhhS2Bq58/U6E43AHV4D5
6YVJ/wqhlG+k6e/o3AgWsrZ6zHKmjHvlDjEjx/CkWXmAN4FT4llwVRgJE/TYdGb/
ba3iVtbQJPZYUArxuAruZatntgSFVKzJ/R84CqLzUaltuPQj+JA=
=sPxq
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


--===============5074390175044677547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5074390175044677547==--

