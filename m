Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43BDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:45:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808482084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VZ0dh1T0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808482084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qjYJbPJlcbGj8R4EJQOU5k0eE2btm85pm/QAfiEjbRY=; b=VZ0dh1T0ToPDg/
	IvUdP2tUN26bIs0kh+BYGBuMJ+h5m0i0P0BU1ve6edS6Ve2WaCQsARZqAXIAzJ9vAP4aPFkNBLUmr
	hgsIHmMob0NkIg11KcSij1WqTEhGV7qUGdzJfvZ3CiJ+ZsFQqRoiEZgjdZYmipF6gAxKl4bqn4LLz
	xlvWNWGAFyD4Usn6jSRmei/fYbTjSKVtq8f5kcO25aHAcy0st86Ln288xhLAZucrCQd9Xhj5RFCGh
	G0cPTjnwVNOcPr2Ads9oo5wzyF7kWkM9hcN+ZOqaRDPvPENtszoBAeoFhtrhqTf+skE6o3HkciyUH
	4kD0EQdSmyVaif7BjmyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYh1z-0006q8-HT; Mon, 17 Dec 2018 00:45:11 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYh1v-0005Zz-Oq
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 00:45:09 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id BD1B980E7;
 Mon, 17 Dec 2018 00:44:57 +0000 (UTC)
Date: Sun, 16 Dec 2018 16:44:50 -0800
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org
Subject: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181217004450.GW6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_164507_850246_C3358032 
X-CRM114-Status: GOOD (  12.99  )
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
Cc: Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Marcel Partap <mpartap@gmx.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, omerlle@gmail.com,
 Merlijn Wajer <merlijn@wizzup.org>, Johan Hovold <johan@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 NeKit <nekit1000@gmail.com>, Michael Scott <hashcode0f@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

So the little elves have been slowly working to get voice calls
working on droid 4 with the mainline kernel. And just in time for the
upcoming holidays, it might be possible to call friends and relatives.

I've pushed out an experimental branch containing serdev ts 27.010
UART multiplexing support. That contains a serdev core driver for the
mdm6600 modem (that also now idles the modem for PM), support for Alsa
ASoC voice codec and mixer, and a GNSS driver for the GPS.

Where it does not make sense to do a kernel serdev driver, I've
exposed the rest of the available 27.010 channels as ten /dev/motmdm*
character devices. There's /dev/motmdm1 for AT commands to dial voice
calls, /dev/motmdm3 for SMS eventually, and I think there's also a SIM
card reader at /dev/motmdm10. Then /dev/motmdm7 seems to be just an
echo channel. The other channels are still a bit of a mystery.

I'll be cleaning up these patches and submitting them for review
when ready. If anybody feels like helping, I've added some REVISIT
comments to the patches. The patches are in a git branch at [0][1]
below based on a few Alsa ASoC patches for v4.21 from Linux next.

Thanks everybody for helping with comments and code to get the
various pieces working, below are some brief instructions too :)

Cheers,

Tony

[0] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-mdm-v4.20
[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap droid4-pending-mdm-v4.20


8< ----------------------
Serdev voice call and GNSS instructions for droid 4

1. Configure alsamixer

Speaker Right -> Voice
Call Noise Cancellation -> Unmute
Call Output -> Handset
Call -> 100
Mic2 -> 40
Left -> Mic 2
Voice -> 55

Voice call should get automatically enabled for the duration of
voice calls

2. Test a voice call

$ minicom -D /dev/motmdm1	# Then Ctrl-a-e to enable local echo
AT				# Case sensitive AT commands..
:OK				# Response uses : as separator..
AT+CFUN=1			# Enable radio
+CFUN:OK
~+RSSI=1,9,108,99,0,0,0
...
ATD1234567890			# Dial some phone number
D:OK
...
ATH				# Hang up
H:OK

3. Test GNSS

$ cat /dev/gnss0
$GPGSV,3,1,11,03,,,,05,14,313,,07,66,322,,08,32,106,*43
...

4. Known pending issues

There's an issue with gpsd not parsing $GNGNS packets, see
https://lists.gnu.org/archive/html/gpsd-dev/2016-05/msg00298.html

Sending SMS should be doable by writing to /dev/motmdm3 but I have
not quite figured out the message format

I have not tested with built-in modules.. There may be some
deferred probe issues remaining.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
