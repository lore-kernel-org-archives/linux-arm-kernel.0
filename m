Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEB0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:13:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8FD207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TY6xDSpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8FD207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gQoSeCktk68YwFfbHXPglCMn/GXa/oIFg/snXJ5dTs4=; b=TY6xDSpwCxhZw/85YYxJHf7+n
	K6/SK4BeV316Fj1JHEyRthaO1bFezCU5qwSLQuHFZkF4jN7L6vIkloz+7wFqMSyOI4W53WqkoP2a4
	6FJMf+DW19xbZQ61lUBGv1OVO2gvOpoF96kiW4nP6LDsm7TfPwTc3z8Iqi1xrOXwAx99wlYm37KHA
	yKx79imu0k2Io13McoBgmajefKRHKIpZx2Xd83eQOHlLgyjKN57xRc/qiy+X5t02bFGdCtE2MdLnb
	vgVwD6I8RxoE8nloLcuq2sPpC2zbqaE24ykXL3wTDB6F7CS/pt1ZqMraUCVt8MuozSd6hxLXFJqNn
	+u/vbgHrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqcBd-0004RB-IR; Mon, 04 Feb 2019 11:13:13 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqcAc-0003To-F5
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 11:12:57 +0000
Received: from localhost (53.97-247-81.adsl-dyn.isp.belgacom.be [81.247.97.53])
 by pokefinder.org (Postfix) with ESMTPSA id 779D74A16D7;
 Mon,  4 Feb 2019 12:12:06 +0100 (CET)
Date: Mon, 4 Feb 2019 12:12:05 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v3 0/8] Add IPROC I2C slave mode and NIC I2C support
Message-ID: <20190204111205.GA2068@kunai>
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
 <746cf074-69e0-7bd1-034e-c8d3156b5506@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <746cf074-69e0-7bd1-034e-c8d3156b5506@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_031210_993653_794E4F9E 
X-CRM114-Status: UNSURE (   6.97  )
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
Cc: mark.rutland@arm.com, heikki.krogerus@linux.intel.com, vigneshr@ti.com,
 ajayg@nvidia.com, rayagonoda.kokatanur@braodcom.com, aaron.wu@analog.com,
 pierre-yves.mordret@st.com, kramasub@codeaurora.org, linux-i2c@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, jdelvare@suse.de, f.fainelli@gmail.com,
 eajames@linux.vnet.ibm.com, shreesha.rajashekar@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, geert@linux-m68k.org,
 devicetree@vger.kernel.org, arnd@arndb.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, rjui@broadcom.com,
 robh+dt@kernel.org, ccheng@broadcom.com, andriy.shevchenko@linux.intel.com,
 mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 sbranden@broadcom.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
 jarkko.nikula@linux.intel.com
Content-Type: multipart/mixed; boundary="===============3711363460110293173=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3711363460110293173==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> Just want to check if you had a chance to review the following patch series?

I am sorry, but for some reason they are not listed in my patchwork
instance, so they fell through the cracks :( Can you please resend them?

I will double check they show up in patchwork then.

Thanks,

   Wolfram


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxYHgEACgkQFA3kzBSg
Kbb0yg//WZeJC9fFYgn0TgSgaJtUKhbio5vIW5421FnnTqDXpsKgLCDLb6SPgMDO
yOCCUEO3YEMcT2I1lvNiifmlx6AKzJwew5OTBLu8tZsHmcuXvqRvitUkefUOwiyp
39KKZ0RVho6GrfO0u2C1vZ25zkl1t3ITiv+Uu/BiFcijQtDeDk3qc6vRc/V/HSe7
oLAMrqwkmeC21acAo+tUUv7iKMck0QVjCbRCoReY+fs3+wp32Iq6Swr0n51h9hvC
q7dYvYC7JOnIBULotb9p0hzDbH1luaEFEplt/vqiyo7cofWDvnS4MHRlxaLgh6y/
BmhZaUTlo9wXoYa27GYXcslYrPwcJBn4GDe11IYhb06UR1s6/SlHHHzu9GwJQvMy
wEYO/oD3UB4EHiyJLhrJ1zcX3YadeFL3kfTK0lly/EbQXGHpKrPC+RwMrv5MakZz
YHDD+oDSE7992/+5W1a4KcBRjrlWrp/Hn0H7H1dJqHOKBJIOlA9MUSFK/2qgYTID
ivkXla6Eh607+hztT4G7xkJMyQYQaJDicc0vhkDUxRQDUz3o83jTqVDgvjmCdP2o
d6lCkNHN835HWfbrQofxyuqgWh/mt4zlYEJvirfIS0QDECF/2Px0p/rPanxM5a78
S0V8Ldlx7l8rUzLaGHDRpQwOkpZKfTi8pWCOnqXQKPzFWmax/Ao=
=UhRC
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


--===============3711363460110293173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3711363460110293173==--

