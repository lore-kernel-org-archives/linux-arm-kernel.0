Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F7EC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:32:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436202146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QdisWwVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436202146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wyDQf3TyiccpWEuYHdN25glESPPiZ5J/3GqaR1aW4R4=; b=QdisWwVRaS7mZaRmLpK9uXknI
	um7vExV0jmJwDhJCbj594PPdTlqfTHrGTY4m6d8UKl5FaiJDCgdCtqxG5+94RQnSvVePGc5St6ZAe
	ESSJMphevgLyXBNuZ+B6erf5rJXeGqM+MqjRCAxPvPpx8y9wEpDwpFRrtdORj7qVw9m3nnqpUv+Gm
	D5tXgn3yfHJH/R9N8skyXs3QJy+c2S6/1oPuggKSNYIVK/f0z7TeZxa8RJ1idECAQFhGTItLxxLcB
	taHQSwhJeRcXY10fRjVT7gy9U8PY22Zcumo542ff5uKQDShEs9Rt7Ur+VxJ/UBukzbx3h0hD6u2zj
	L9/HzyZ+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gswiM-0000Lu-LN; Sun, 10 Feb 2019 21:32:38 +0000
Received: from mout.gmx.net ([212.227.17.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gswiJ-0000LW-5i
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 21:32:36 +0000
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnkiR-1haVrt3pap-00huCc; Sun, 10
 Feb 2019 22:32:23 +0100
Date: Sun, 10 Feb 2019 22:32:21 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock
 is disabled
Message-ID: <20190210213221.GC2061@latitude>
References: <20190207225211.GA17552@latitude>
MIME-Version: 1.0
In-Reply-To: <20190207225211.GA17552@latitude>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:XAXp9iHbCJQ7mYPC77Hpt85Bjyy367hPYeA+Kn1H0ZN+F868zxh
 7uhalFxjTqpXyBtZIZx/HDtdiWWjh930KrB6USs7vHY3XyijCCVwERMpoBv69iLgj0JhZc1
 qwJGeWaIiMJJ7CCYi4S5DsKZdJz2cKrA/Wl8OxFL4UnMehI05w6aFffPNQExdO/jgk7XQ/A
 XiPCbiqvRuZdWJ+u0TfFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mb9FXcvWVqI=:ABlsysEuGfRSqVP/X8VtVM
 2svwLi4pIlwOOSy9/uurp1HqoLl1cphCG31W/cUHh0eGfo6VkR21wFWOqNhA4eYOmiAGNZ+Mo
 4kLiJDwr1r+xr7bBK4tKT4UyLFp/ppEPVnVLqYvt99+5wGT2iQ5Akk90kxj2JefZD0TlWZ68a
 w2yKmA0IPnd9VToSRW8FN/sgSlNHSijiZuh5Mdh0W1gI/Ldgkf+mhc4+5Nr6I83s3gClTAP36
 R4mZPYjBDvasMJKFM7b6BWf2n6rA9FT94ayfTldGCmyGNUtwruksa/PXVvW4XUr7j9q046/Uu
 Ju6gUTdaB7/qFn9j1BIQo1zaB8bgdoZhz46uKSvl3xjPHvf6Ekk+demJWMojSj5JQb0Pi55/Y
 /cnAhmucZ/5ZngSL5VkiDiH3r53MSepKSnbQRvqG2bXWVga+Kr5Y6muE5DwDf9rm5y3UM3+uj
 P10pGqLXZTtLXwY5nAqEW7CyCcCNyuplNavnFc3ikMWBeBKo3/tcL7ymn+DinlQV5TIqzip6W
 TEfJ2yXChtNchZkGMwRyJtJTB5qaXG0pCSDoDLcqIE7LLBttbTqt6uI3CfJa3tFhNhooZR5ZT
 qaKBvLoY4LV5qEFYdvdIUcAn+TuNdBkX7+qnwxYJA3EvAyHP0l4PPn2tChmq9cNLy7ytU88zF
 eKVOpZuXHs2VYF1PkypNEsRMF9m2dKKntdBBKzb63afTH1PiZ+OcUFdSfT3SQUPxrUFf/2qRn
 YqoNs9l0lwPCrCwbOFkHvDdynedObf3q4WFaR4zDsaHVjBvkLhCYolmhkjwhmiPE0ya2L6CC5
 YPsgPR37Gp2pjIkF0oi+Y6SpAnC6Q3Rziv7ZNAtdbDsKYk9Q8BZ5cLswxAwiBrgCEzFV51+0Y
 VyUawdkAyuggmTZCYpqLz08GS3Hb5cJRczR+fmZ2tIyMg4ti8ECfiUQ0YMA9TT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_133235_511453_65BA24BD 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Michael Turquette <mturquette@baylibre.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7184002623262560004=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7184002623262560004==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 11:52:11PM +0100, Jonathan Neusch=C3=A4fer wrote:
> However, as soon as the mmc driver (sdhci-esdhc-imx.c) disables clk_per
> in sdhci_esdhc_runtime_suspend[2], the whole system locks up in some way.

I've traced clk prepare/unprepare/enable/disable calls and got this
right before it hangs:

[    1.280981] sdhci_esdhc_runtime_suspend: unprepare clk_per
[    1.283356] clk_core_unprepare esdhc1_per_gate
[    1.285191] clk_core_unprepare esdhc_a_podf
[    1.286881] clk_core_unprepare esdhc_a_pred
[    1.288568] clk_core_unprepare esdhc_a_sel
[    1.290220] clk_core_unprepare pll2_sw

I suspect that there is a dependency on pll2_sw that is not represented
in the imx5 clock driver. I'm comparing it to the Reference Manual now.


Thanks,
Jonathan Neusch=C3=A4fer

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxgmF0ACgkQCDBEmo7z
X9sINBAApuuzxXq9D6VZLxr0ABlrqGVUN9QMdqizhS4PcNi97B4Ax5J1dDGCXaJN
U1J1GwA9WQgC3/khCiP04XAc1qp6/2KkobDFl/IjBNPZRcBS/qeBemePKhAWH9Jh
ICqYCbKZCkxpcLD8zFpY4XtzC16fdk5CTeXEJLjb83JcWY+p8KBkLGCl0SQyJuJ5
pHS79Cgw1RhGYS4zF3a8AO8o4Llccl1PdshUlXNOZ4rFS3Ep68A03cBoWI+PWuhU
auF0HmYufLhajjeaDFaMv9uzBSM5vylxIsEtKJzxLChgOP5sAwIMGFxyo1sDAab5
A6GovivJ/jtQpK/mVSoHqazyt1226c0LXV2Sg6erImmCUkAzcHPAzRPeRJqqCt0Y
IUaLY7jWPQSUMmh+XjMuGUuDuJbuTetb/1TJBK94aAzndMn12fojEDRtOgtvpW3d
KaZKj2tk/250uC6q+GvQClF7iZEadl7bmu/QQfEpfMU61qH7IOmw7wrGFueQLelu
HDX+GRpoe0qsYdYtFOmsYYj5ocyLRgF/F8ycEyK9Ea+WOr76JS2+ycDkSit8uxcl
JiAHh3xMGQz7Mt0sTMdChfg5ee6ruxanfB/SzSeurpBmg4fmdCJmt7JYZbwC3NBI
CfjjX/RM10JpwYk4YVxxekG/ZOP+jO9JDIgHWZTIFkHt6oat234=
=Ejgh
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--


--===============7184002623262560004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7184002623262560004==--

