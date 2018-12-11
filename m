Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9C9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759F22084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qS3HSIZo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8jlE+BK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759F22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aX+wfSZsdFDBrNk7AseQCcx8eDDic+a2q41jIHRWiqk=; b=qS3HSIZoqfxUuZhErKQf0tSj6
	W/z/gOF3z9DQj/W4TVUPbcjG8R5PZFmxceOdYNyW8MMT/34asCGi+p2QbEbtFfToGIdKMUInfTh3g
	fPsNqiWobmZdkroq9P/Zy0TtN8nwJGYx+ut7hctF43ZsyOl31bRBmg/kFx34rMbIiZJhFEG2ReLIG
	dBtVo3uMXMLteAkHVUap3rpO/3E7ANzSzkKAWUbkx+iK/8rSOBYy8cgrN7NoUMIfT7IQ7ja3LBQhn
	sgPsEu8dI8/Onhupxh80LLV0k8OpPi+uJP1mRMR+AfCSUFHPtPVoYQNExDcNUr29Aa8KkPKvEm+Mz
	ih0ZpBcuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWWeW-0006HG-3l; Tue, 11 Dec 2018 01:16:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWWeS-0006GV-Ca
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 01:15:57 +0000
Received: from earth.universe (unknown [185.216.33.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D25F2084E;
 Tue, 11 Dec 2018 01:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544490945;
 bh=aazY6V5V8a6l2waAJw635Dkn+Xyx8to9f7CYaQIBDjg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P8jlE+BK91qdWG74VfSPZNGcCIwy/7x6LgJI0G9OyY/4d+P3LzoqkAQlPoCv8ZJUV
 eTeDbSQw/dgqx54VTkIYsDle9tXT8NDRN4yqm/nuwg3OsM4hFcvn9dQS5PVkfstZZ2
 Hrs3tat+5e/3dFpGaFiWxy1wvcuSg9UDRqaYwyXA=
Received: by earth.universe (Postfix, from userid 1000)
 id 28AEC3C08D6; Tue, 11 Dec 2018 02:15:43 +0100 (CET)
Date: Tue, 11 Dec 2018 02:15:43 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4: poweroff does not work? calls
Message-ID: <20181211011543.7b2ufljwm45padjt@earth.universe>
References: <20181209121318.GA24478@amd>
MIME-Version: 1.0
In-Reply-To: <20181209121318.GA24478@amd>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_171556_460725_A4DB9801 
X-CRM114-Status: GOOD (  11.19  )
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
Cc: mpartap@gmx.net, tony@atomide.com, merlijn@wizzup.org,
 kernel list <linux-kernel@vger.kernel.org>, nekit1000@gmail.com,
 linux-omap@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============8120305676137900969=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8120305676137900969==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bciqzcehawnaanau"
Content-Disposition: inline


--bciqzcehawnaanau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 09, 2018 at 01:13:18PM +0100, Pavel Machek wrote:
> Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
> seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
> affected. It is bad, because when your battery is low, you get into
> reboot loop and discharge it furher, which batteries do not like.
>=20
> Any ideas, or at least idea how to debug this?

I cannot reproduce (using 8214bdf7d3e6 + a lot of omapdrm patches,
that I'm currently testing):

droid4# poweroff
[ 1097.557434] printk: systemd-shutdow: 32 output lines suppressed due to r=
atelimiting
[ 1097.862670] systemd-shutdown[1]: Sending SIGTERM to remaining processes.=
=2E.
[ 1097.920715] systemd-journald[158]: Received SIGTERM from PID 1 (systemd-=
shutdow).
[ 1097.973022] systemd-shutdown[1]: Sending SIGKILL to remaining processes.=
=2E.
[ 1098.027008] systemd-shutdown[1]: Unmounting file systems.
[ 1098.034057] systemd-shutdown[1]: Remounting '/' read-only with options '=
errors=3Dremount-ro'.
[ 1098.136413] EXT4-fs (mmcblk0p2): re-mounted. Opts: errors=3Dremount-ro
[ 1098.170623] systemd-shutdown[1]: Remounting '/' read-only with options '=
errors=3Dremount-ro'.
[ 1098.190673] EXT4-fs (mmcblk0p2): re-mounted. Opts: errors=3Dremount-ro
[ 1098.201324] systemd-shutdown[1]: All filesystems unmounted.
[ 1098.202148] systemd-shutdown[1]: Deactivating swaps.
[ 1098.213226] systemd-shutdown[1]: All swaps deactivated.
[ 1098.213958] systemd-shutdown[1]: Detaching loop devices.
[ 1098.240692] systemd-shutdown[1]: All loop devices detached.
[ 1098.370880] reboot: Power down

^ phone is off at this point

-- Sebastian

--bciqzcehawnaanau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwPD78ACgkQ2O7X88g7
+ppr/A/7BHcRUOvED0dKt8cO5F3pj3qNnqIpsiZ1ng/fYuMCx0HnP7U384eEqm82
sQl9OfMkbvkUbtsBO/bylkG/A915wVfs1RuDCQSExjZHsreUADSre0LyKsUZyquW
yOximT6/JgTavgBN+x7CSsAMQtbiKbr1Fy9J40mQYWGHwipk61v3FxCXAC/VUXgT
7fItEvxBJ0B3k0SlTasBMBsubSnO727ozcmXBrRn53CbxOZ864FtUNjCbPq4VXii
9XtyE2wyE1/2RLRlKb6WenFgjNw0Df7ys/Weso3sJJWznPXRmETxdJAkAW89tYh6
S9RL6ISXFC36eUWcIYhhkmPmVzlMqq2nXyrOcZmvCEuoSa71MxSMt863hYp/YUR1
n30VkhXFPi1023+7PWkQdVdYqP+YvSzQnvLGDIvh0qwA56RacGKzlkVEcpean0fe
2FMNcRQe2k/eBSCFQi8/1rPWL3g7bQgrK6FZ8qQOjtM3SXQTc0i0FIt+D23OBD1y
MQM8AtG35bpOi3ulkb1s2KBbRnFztVUV0g7qzCiWYCenYOW5lvDnY5xBdQQr0U/U
aIaJEJnxp9mSO8HthQbK9j5V/bmP+b1ObPFnUOlCZVIKFysDpEZWXWAvOoOAEPw8
lgCp6mGFOAJLa224gTRf5k1Q5RFKwbHEZ23po9xAotovfg++rXU=
=aD9B
-----END PGP SIGNATURE-----

--bciqzcehawnaanau--


--===============8120305676137900969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8120305676137900969==--

