Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D27C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:24:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE6B2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O5NibhfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE6B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W/Fz6nRMdmSIPDwBp9UdgeV0Bf7yUAMvIy/wHHQVhEA=; b=O5NibhfU7RBCJWNxO7SMDFURE
	X7evysS+eeffvpmHvrXxlrnB98cnGMxeC0H9YGr3Ke1rCLwgeIRyaNPLztPpjMmbigoUPdYuadMio
	r15jASgaRoHM5/Rt3H9+cGKI2hAhUaQIyin5H6DwzKFDhMIFx2yncWsy+1XEQeFDVTqr0uwLQF0Ld
	14lbDq9HILBndKCnhS40z4zI+TxrD4V+VZPtZHi5SIuHy2kQROi33Qn7qVRllkFmej9nJ0Ei8CCId
	qNjJWShyXt9jhd/CLtVmCUA+ht5R9LuMVk9SFTxfOK0aBOWWsuWyvuA2KARv619NUmcONvh0u0a+E
	EQpGm72bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW2oY-000739-7O; Sun, 09 Dec 2018 17:24:22 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW2oU-00071I-HQ
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 17:24:20 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 3BC8D8076A; Sun,  9 Dec 2018 18:24:01 +0100 (CET)
Date: Sun, 9 Dec 2018 18:24:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4: poweroff does not work? calls
Message-ID: <20181209172404.GA4593@amd>
References: <20181209121318.GA24478@amd>
 <20181209164650.GX6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181209164650.GX6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_092418_726835_4708B9B1 
X-CRM114-Status: GOOD (  16.46  )
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
Cc: mpartap@gmx.net, merlijn@wizzup.org,
 kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org,
 nekit1000@gmail.com, linux-omap@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============0856357399617348955=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0856357399617348955==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-09 08:46:50, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181209 12:13]:
> > Hi!
> >=20
> > Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
> > seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
> > affected. It is bad, because when your battery is low, you get into
> > reboot loop and discharge it furher, which batteries do not like.
> >=20
> > Any ideas, or at least idea how to debug this?
>=20
> Hmm can you check if this is happening with usb unloaded or
> unbind? I suspect ohci or musb..

Ok, let me try: musb unbound, v4.20:

root@devuan:/sys/devices/platform/44000000.ocp/4a0ab000.usb_otg_hs#
echo 4a0ab000.usb_otg_hs > driver/unbind

(I hope I did not pull the USB too late). It rebooted instead of
poweroff. Now on 4.18:

root@devuan:/sys/devices/platform/44000000.ocp/4a062000.usbhstll# echo
4a062000.usbhstll > driver/unbind
root@devuan:/sys/devices/platform/44000000.ocp/4a062000.usbhstll#
uname -a
Linux devuan 4.18.0-rc4-88970-gf075a2c-dirty #764 SMP Mon Jul 9
12:51:47 CEST 2018 armv7l GNU/Linux

I get nice oops doing that:

[  170.705383] ------------[ cut here ]------------
[  170.710235] WARNING: CPU: 0 PID: 2371 at drivers/clk/clk.c:697
clk_core_unpre
pare+0xcc/0xec
[  170.718749] Unpreparing enabled l3_init_cm:clk:0048:8
[  170.723968] Modules linked in:

root@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.=
ohci#
echo 4a064800.ohci > driver/unbind

=2E.Hmm. I'm not sure how to unbind ehci. Let me try sudo
poweroff... no, it reboots, too.

Can you check if it works for you?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwNT7QACgkQMOfwapXb+vKzBACffSEF6vwWVha2uJMPdeAzqeP5
J9IAoJgKqEA/LXbRGiTz5NFIuF3I6xAG
=1Tt9
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--


--===============0856357399617348955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0856357399617348955==--

