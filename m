Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBD3C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:52:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A93F21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TdL5V4ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A93F21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=QfWF1jcNWXTz/YaE1GYzvll9Vys20J8scGL5t1fZDWs=; b=TdL
	5V4ngTMkP1fgrWQsQGpYNY/ha7JJaunU9FB8Kg9PpkxbrX5yUTILTQXaaiM7m8rUm9HFRgQGNiSq3
	dCIRBmFxfTk5LTgmO/gLpUldMFTW4XLLsZmuWxNaJg65Zv7NEfAPYF96i/s/eDUBwCjvvxMLSYdJr
	jB4HBlbUi9BCQwncFXDJCFiy4RaG4FJXwj3xGyuoGkRq7wCrlnNwuCe/mJT6NgOQc1gLK395r4tvQ
	8pRsfPzrUwGkWOKdNu03/n6mZ/V9YStSODug28nFEb2IJjG6Cq0/ymUDqep0iFkz+pz8IFyWy5Vz7
	cf115cU4wWjRZbm7cSe9mRH8pF65QbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grsX1-0001zV-4H; Thu, 07 Feb 2019 22:52:31 +0000
Received: from mout.gmx.net ([212.227.17.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grsWx-0001z7-DO
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 22:52:29 +0000
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPZuP-1gnjn50CK9-004hfV; Thu, 07
 Feb 2019 23:52:14 +0100
Date: Thu, 7 Feb 2019 23:52:11 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock is
 disabled
Message-ID: <20190207225211.GA17552@latitude>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:O80fzMqBwkceOe0HK0EW/J6FY/8R7YsENOH36pmH8//tggwlOoU
 /5ovsi39O5cCN+RihCe/jW89IXnBRyqJOIXO3B+DJdIwdm0hob8NAhG7etXo6r9zSOX2zO2
 ydC0IxqzHYV5WSXKz3eXuu36UdLaFIOkxoDoCjA6CtLfO0rlkSUxfLosdpMmb/6lSuQXYkd
 tXgxTNmLmvDksqMG/Wd2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FaDy3Aqasjk=:kFRF3ob9Ft9IDdvCXKSGO8
 OX5FPyXh4T1f9ZM+b3wM0kO1QVlAnmNbMEWXuBQKSU+ol4679nMBMrNNM92Vz9NSQVgIhpW2M
 CV7ZTmJ/NitEpgIl0Ruqjtznrt1c+ehWYIQBuYFSi9bKxXHDX0TTVOdQYiuJUx20YGtyPKJXJ
 uMs54OUsYjjtbv/kZrChpch9Tmy4wem38WRQSyLJHuXt4n6fyrbloxV+1wV1UPPjSohIotUVA
 Aq+a6pWGGL2Zrfn4ptd9LAkbgK0aUN7QK2T6ppv9TM1/tVBbyxcFaox0pd4Vx0BSJIOnMHowE
 nvTwaW3HNmER3kJ3Ur/g/ChsvJx2ipUtYM06FB575bw/t1n1oYePya7Mt9Tu/lCIV6uBurZ9v
 Wg4DcEL+zHvIknckjraf1+blVM+eFHLP3MnDgEyC075ZULItmWWSC+kb/BkSxwqiX9jlxz5RD
 WRjq6ydnOAEJm2Y0i3dXLBpr10ixqWt0/idd8WNz/u7pcrKfX8pGWAnTnjIpvnLfSiZsZcSs6
 hi/4zhFx9EgSuVv9JmlBDemx3LJhnuytSg4FqwyPVALLA37bCccgVS25gkBO2hwZYmXW5OoBS
 kGChxUfl0QMOryrQq2HN6hmbusEAz6Zb91om+FuOZWJhhbQJVkVw8h3+BRyCuGFyxtCzd4ijG
 Re88XHUsJOqjr5KKRi5rD3rugR+YwqF0XEigqGuKYeNkyvwbmOiUbEFw4tGSdLXXby38fonOq
 bhNmavIs5dEv6U5ZdHGi3JexEGbIWyoTWpfiHCV95jMXIQzT8rlYc7Ru5uW9tNUlF2/DI4ACl
 42emqYAbmQYWuACMDnQzrYjLKiTCFMTXK02W7RQJsU26nYG8Gxk8ldhEk0nKQACC6VFV6BJj+
 EDgA6vDRTmmh7dildX/jaMGbZCkIGUcgP4Is4jlQFn4h34ux8m4V+UdUiqbaIe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_145227_752667_AF24E35F 
X-CRM114-Status: UNSURE (   9.92  )
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
 Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@intel.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0725896704381766306=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0725896704381766306==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently porting mainline Linux to an i.MX507-based board
(preliminary DT here[1]). Recently I've enabled esdhc1 in the
devicetree.

However, as soon as the mmc driver (sdhci-esdhc-imx.c) disables clk_per
in sdhci_esdhc_runtime_suspend[2], the whole system locks up in some way.
Booting with CONFIG_PM=3Dn "fixes" the problem; commenting out the
offending line in sdhci_esdhc_runtime_suspend lets the system survive,
but leaves the MMC controller in an unusable state (of course it's not a
proper solution anyway).

I tried to compare the CCM's clocks between i.MX50 and i.MX53, but
unfortunately, the i.MX50 reference manual doesn't have the table called
"Output clocks from CCM".

Does anyone have any ideas or patches that I could try in order to
narrow the problem further down?


Thanks,
Jonathan Neusch=C3=A4fer

[1]: https://gist.github.com/neuschaefer/27cacf0acf5411219be9372d728d1163
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/mmc/host/sdhci-esdhc-imx.c?h=3Dv5.0-rc5#n1412

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxctpQACgkQCDBEmo7z
X9sCRhAAw9ITjTQEEXDivDeMdj/6i8kc+QsJ8gfnBBBykbRlr3Y9bgb1wLrJNKwv
+Ge6OSrQ3tlx3rSVrw2BQaLg6iCxjEuYdmklvOtJ/g58oNVGqi+ZHXz6g0I/2S87
K7TQY+OTbbEd5RU69wRwe5XUYc+sGGovHxDORRghMGfulVz5a9LpHbClqEnNF/GV
VeIkASq3D4xsRrMEoAHhqDWATLyBHxNvMp00BdXoAnswuxmVrNqFtkUOVF/D0F3I
Ex8iBvVuGPbM05zQUXEc7EcBPh+pYYZAhbtfwZxLDgnG+ua18gVJcD3JVvxI8Fys
4kK9Jf5yv45GPRwm0YmkA3edxqQBZEL+HyOCFnWVINzEd7+q4vS4PL7+zdPWuJnV
cxul84iPn0AuO8yFOrFdsG1K6ETU2l+jnc95kJcTV4Wh2R041ZO64RkZkaExznLm
alEL1eMHEZ9mQPdRmvXZsAIdE6OvBBOhsJnwnXShrGB5+CO6/QIl+clwaqTR5Prl
mns8K60gBXA1B2NS6p0QgjeD9DGhTUTANlMA3X3dw5KHxaxnk1Y/tr2JxvdqE6Yo
uliAwEFxFZUWFvUh6yi5oqunEY0bBUQmch5HPHWP2uXc4yuk4a05JjfhUjbczL2y
42kPZzU8rCBLkowsLewstnxgoXcHUTwBkIootFGocsJpjckvlXo=
=ajnv
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--


--===============0725896704381766306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0725896704381766306==--

