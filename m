Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65600C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:20:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2737D217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gv0Duf9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2737D217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nk1gOGWeYd9OCTqE1x3fl1wzCkZ0HvWKGkkVkzWfWc4=; b=gv0Duf9JiVXp2J
	A8XpmKf1QUnHg8r56e+cX5rd9pmWFGW/sQYKKR7EP4ytq+b4VoQDa/s2V1e9+NiBBWd7t0n5h6+tE
	PQBMw+wPggnFfa36Uwf1uzGPLkgUlDfIYw2KN+nbyT5z6lfRlaZpsqXVDthtnOIlT8RzM2gEoP7FS
	1kXvty7i9usYZIBH/iYN14AaS/43bU2up6ChemIc9X/nnUQGrg9GMN1XdfmLhD1Ja9mLrbnm5aBcd
	0dktZtde6sULSaUCETLM/Xm0d1mShRPt5ES9RDmamEDQF1aW4tz/M6kk9uTUcswAbJDiEyb6shkZC
	OzPhOzeZzh+8WK2QDKAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvTqx-0005Y2-6K; Sun, 17 Feb 2019 21:19:59 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvTqs-0005XM-Gf; Sun, 17 Feb 2019 21:19:56 +0000
Received: from oxbaltgw66.schlund.de ([172.19.246.153]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MIxqu-1gc9U73xUo-00KM3a; Sun, 17 Feb 2019 22:19:49 +0100
Date: Sun, 17 Feb 2019 22:19:49 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: David Summers <beagleboard@davidjohnsummers.uk>,
 Tony McKahan <tonymckahan@gmail.com>
Message-ID: <1792591325.343876.1550438389249@email.ionos.de>
In-Reply-To: <4ef63671-f58d-3b16-9055-09e69314a0e6@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
 <CAERgokmpHQb2czJdx++qFoogFRmkvXZm=4BNOsVuCz-ZvgTEaw@mail.gmail.com>
 <4ef63671-f58d-3b16-9055-09e69314a0e6@davidjohnsummers.uk>
Subject: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:ZWKKZqH0uma38g46+bunOJ7MaJeH2Sr80HTftTz0l8W7efLPPoj
 sjwbm74jxBJjrTLQmH6i3DPqgBLdq0gMUnUY2KGoKI7k9zhjuGYf83hIfOyzu+zPZ+4T8cF
 unR/kxKh/I6zz6LYvZGlnkLvx/x0Sooxlav8v8VXtIkUM/mWkE1nqBizeBQAXpc6zQzpJis
 c8+M+v7VfQU6qSypO3McQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A1V1J3yFXXc=:qw/RS0WKjcHkSqw0/5yIiU
 i0IeSms7y3jYsh769uQY6g/W2+dy2PpVB7SD72pBS3xw3PzzhNQoa30X3mM3NY0dKw6pUiTQ0
 MFejle3CATkPvgv6724Q9/JYOdnVW/15Bo+WHIel/ATvHG05Zr8Ea6Er2UXHDoMeMCr8ojjS5
 ANVDAfCXElVL1FaI4tDVF5qlZ8yCRmbcYeSbi39SylVTVrG/UNu2UKEMrZlk8P2t5FttPhyeO
 eDWNYV97by7FIwcQzJPbtv93mJFVmn1cRJdoGVi8lDfv11hZdKn+twILeU6Rr2zUflWoNQ1L1
 VUrbrb+XFS9LKf7DcDmYg4EH7b6ifPmyj4WKdkq4FyL6BhP/c0/oZictyiuCHVoRcQhnV/h3D
 SMF+9OozKcLb/0rEIPyJqntDYvyFmVGCPJHhlM64twYnZzdBciRZzmZKVtUHxAdQc0+J0CyKK
 3ZBxZ1cP4kLj7Y8wXtzPjL8BY9qnDsRhjpEnMrE5OwfmCS85bUhhyORrLl8K0+3f7c2tB4Yyx
 6kfhUPEuDo6ciBA4yHGHr6bLxgpx+4rgM1jLyGpNpILoUa4wXEQwgTRz0KC6pKH5Nxl5f7/jA
 c6FriU8qQC0yIt1UHP1459G8wknCo0UZ4sbp7u74LzcT/DqvO7abQysyiEi0d4qEH7ZrIqzGf
 dTsPjNbknqiz6x9UjIAg89Snwj6fZJ0XAnkYCw+zFGDzPRTN4wUXgSwaap4Lop1baqu/vS0UO
 s/UVGGeQduWQNW1xvpufLiYzvlveL9vKm6BzQDB61OCXVaKmOo7Dwph4Io4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_131954_855699_01BDE054 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

> David Summers <beagleboard@davidjohnsummers.uk> hat am 17. Februar 2019 um 16:55 geschrieben:
> 
> 
> Stefan Wahren has come up with a minimal patch to hci_h5 for bluetooth, 
> that says the relevant properties can be read from the device tree. This 
> means that acpi is no longer necessary. Thats currently out in testing.
> 

this patch is more a quick hack in order to test bluetooth and don't have all features ( support for baud limitation, host-wake-up ). Also the patch [1] has only been compile tested (i don't have a Tinker Board), so please be aware. I created my patch before this series has been submitted, but Patch #3 doesn't work with this and needs changes.

Stefan

[1] - https://gist.github.com/lategoodbye/79bac99d4f1158a719a48ea3c45eb7f1

> Regards,
> 
> David.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
