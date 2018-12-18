Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC2FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:12:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9075721873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bUluf/PL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9075721873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GmJCgBv3g0jgoT/NQHkTswKrO3DXP1s0pHIYUD6lrQc=; b=bUluf/PLLrQ3fO
	xle6AXSQu34ZE48WphaAGLLyP6RAM//f/bkKCsychYCfEiWX2i7NOH2BTW4Gn9xZq7DjWYnaqia44
	L5DkMFvcANw1L2FlxrNtMIhReUIcp+4sfNAJyntxdynwTKVH2Vm7lr/UETHnslNWjRNP4uC0wo1sM
	gBDSyMuF2Z7z0TVeK8kFxYyk8u50Fr2adKbR9CiFcR7wtFlfkbMMccXSsUZOBtRfVpLDz79OAfSoN
	iQxmMKADtNYw/20v53Xmhi0Fl8oavftrfhVReVMB1h78AIe4MNXWNuq9RqgTCdpWw/KiVq1Bl1Rv2
	worrtrnYCD3Ks+Gnedbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZIuf-0005fQ-Dv; Tue, 18 Dec 2018 17:12:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZIub-0005dt-FF
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 17:12:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76BF815AB;
 Tue, 18 Dec 2018 09:11:52 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B42E3F5C0;
 Tue, 18 Dec 2018 09:11:50 -0800 (PST)
Date: Tue, 18 Dec 2018 17:11:44 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state
 support on Armada 7K/8K"
Message-ID: <20181218171144.GA17290@e107155-lin>
References: <87k1kowf7i.fsf@bootlin.com> <20181205101035.GA31059@e107155-lin>
 <877eg6hiv9.fsf@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877eg6hiv9.fsf@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_091205_517824_0FA54710 
X-CRM114-Status: GOOD (  24.23  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>,
 Jason Cooper <jason@lakedaemon.net>, Sergey Matyukevich <geomatsi@gmail.com>,
 linux-pm@vger.kernel.org, orenbh <orenbh@marvell.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 05:58:34PM +0100, Gregory CLEMENT wrote:
> Hi Sudeep,
>
>  On mer., d=E9c. 05 2018, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> > On Wed, Dec 05, 2018 at 09:27:45AM +0100, Gregory CLEMENT wrote:
> >> Hi Baruch,
> >>
> >>  On mer., d=E9c. 05 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> >>
> >> > Hi Gregory,
> >> >
> >> > On Tue, Dec 04, 2018 at 06:48:43PM +0200, Baruch Siach wrote:
> >> >> On Tue, Dec 04, 2018 at 05:21:25PM +0100, Gregory CLEMENT wrote:
> >> >> >  On mar., d=E9c. 04 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> >> >> > > This reverts commit 8ed46368776b3bc93d74c1f8f2bfb9fd8a9ad805.
> >> >> > >
> >> >> > > This commit breaks boot on Armada 8K based systems. Reverting i=
t makes
> >> >> > > affected systems boot again.
> >> >> > >
> >> >> > > Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
> >> >> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> >> >
> >> >> > I would like to know more about it because on the McBin I use the=
re is
> >> >> > no issue with 4.20-rc1.
> >> >> >
> >> >> > Do you observe this issue with the arm64 defconfig or do you have=
 some
> >> >> > specific configuration option?
> >> >>
> >> >> I tested the attached defconfig on Clearfog GT-8K and on another cu=
stom Armada
> >> >> 8K based board.
> >> >>
> >> >> Tomorrow I'll test Macchiatobin with this config and the arm64 defc=
onfig.
> >> >
> >> > I reproduced same issue on a Macchiatobin board with both this confi=
g and the
> >> > arm64 defconfig. The latter produced this splat:
> >>
> >> OK thanks, for this, I also got the confirmation by my colleagues. The
> >> only difference I can think of, is the firmware, but the surprising
> >> thing, is that I have an old firmware: 17.06.2 and that with a recent
> >> one, it doesn't work.
> >>
> >> So I will apply it in mvebu/fixes.
> >>
> >
> > Sorry if it's too late. But I would rather disable the states that are
> > broken on old firmware and see if it's possible for bootloader or boot
> > firmware loading DT can modify the status to "enabled" if it can detect
> > the firmware version.
>
> you mean adding status =3D "disable" on each idle-state subnode?
>
Yes indeed. Keep it disabled by default and can enable it in bootloader
if you can detect it that it should work with particular version of
firmware. Just a thought especially if certain set of platforms support
it while another not.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
