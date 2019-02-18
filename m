Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B689C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:10:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBB921479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b6CTWpyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBB921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pg2lOIr8Q6q/CNnDo+mgX4l6IUE5mb1QMldvNMlZoEw=; b=b6CTWpyI8G7qrP
	oaZp5xHx2XXNnbpy7LfTvzsWPdLS8yQIu+fcnHhKuD8wVc00DKrVAWbKddp4VnGvgJ3pbgV8lNjH2
	Rcc3q5z0WCTBcMiEdoOk7HpeVTWJm8dn64LJ7IjHI2K+XAuaOCMGNk28dRUcyv48VB0T6Mu3mbuyN
	eV3LFwLFhLwKbN1QvjjgL/2sZs34Mn5FlujHL/5BV/Q4kss3sqGbWuQEFfTxKG4yqyZ1c4TDROoWb
	fCcAwErAttliNI0ZTFzxAL+y95qiFJHlVEgVuY/hrQDsdexwVRegkzysORC3W1CDJieGmZjrG+LBe
	WczKr0s7x7kpFJrcgHhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvr7g-0002ke-6C; Mon, 18 Feb 2019 22:10:48 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvr7O-0002V0-0c
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 22:10:34 +0000
Received: from oxbaltgw06.schlund.de ([172.19.246.12]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MysiI-1hHWw61PYw-00w01L; Mon, 18 Feb 2019 23:10:16 +0100
Date: Mon, 18 Feb 2019 23:10:12 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>, Rob Herring <robh@kernel.org>
Message-ID: <1591759260.588063.1550527812700@email.ionos.de>
In-Reply-To: <1245842044.588056.1550527701604@email.ionos.de>
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com> <20190218211035.GA28145@bogus>
 <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <1245842044.588056.1550527701604@email.ionos.de>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:jETn6HhGS0cIqrr4t3UqX3KcZyWyaXnBtD/hiP91znatfoeYtVD
 aFCABcy+W7ujbWpwPZX0U9Owsr3xLik7+hRiSWc6vkzQXsM+P3ZHsxZk/sKhM5EHka/er7Y
 sQjIvGJy+MiwZ6EsTy04s0i1ZbxyKW1QcIjmQh0bF+RkShIxjhJWflAQ+ygHmSgGkbSTFco
 523gsnyX8E7gikck5vyQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fb/pd/YD/lM=:XZTH8fYFp8HGLdhAbMvV3y
 S2EDsndEfqDAtVu1Hpgl49LbNwKWWm3QE+VWlO4Z584UR1Rfst/TiZTUHeMdWxazKEE1I+xBx
 M6XvVksa1SsCWJT2PBfUxuv7TrZ8sck1LuCU5vx7IuRP9BlU62CsXtLBvT8sFCxnljAY+84Rt
 tTQANiQ010wFE6B49DGMWPSgeOIo1mdwl4LKmpsTKHFEoRMGXQfUuhZ34lsd5eexbBN2nbsNr
 0hBL/IYRwx7V2bSwTYhJaFxW4V1T1It+ulSOaKz8uvqNvhLFzpBdQ0/rD1Hfixna3FFe9qUj9
 DP4P7jIl+jNjNWLM2l7sJqwDNDesYGztM/YKh1QBWLtNG+WI9/GK3cl8WB1VWqls1EPj7tJEH
 iUNoYNIp4HseMeLJ0aPxLEJIorYLqwmzsKVNB4RS9vKj5OMoqraDkKnGg3ArOiXSmcRU+y7Iy
 KeGVj5ktyWJpcqnx5Tk4gZplbOZCCloast7CAH7AIEVkbVUwxoAa6zkLtgfrf+DjRSv2DIuE4
 ks543x3HO32wBxTkIQSS+AJneYIUBrzkkkQhTYxQoI7dHDCD14B8N9SoTzLhWzxb7qymvelLR
 TcrWwJvSY6zuLNIVUDpy2wJRPhB3IOlgLMDLVzLYxvKLgPgvofpVjRgCv0hIiGrYqgDnRU4T8
 dnxvZYjsiJmjbhs/znCrF2r9sZ1fnnor7Z2N+Y5akiQhgLjBEAyE2wxfZ1OEvQCspdElbWFyC
 CJmJMSTKoomp6EWPBT3ZY6QIHU5cQyOsIs9CkOO8H41zA6Bw+sbl+QuNlxc=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_141030_752795_52E9F612 
X-CRM114-Status: GOOD (  20.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, beagleboard@davidjohnsummers.uk,
 linux-bluetooth@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 "David S. Miller" <davem@davemloft.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> Stefan Wahren <stefan.wahren@i2se.com> hat am 18. Februar 2019 um 23:08 geschrieben:
> 
> 
> Hi Vasily,
> 
> > Vasily Khoruzhick <anarsoul@gmail.com> hat am 18. Februar 2019 um 22:24 geschrieben:
> > 
> > 
> > On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > > > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> > > >
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> > > >  1 file changed, 35 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > new file mode 100644
> > > > index 000000000000..8357f242ae4c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > @@ -0,0 +1,35 @@
> > > > +RTL8723BS/RTL8723CS Bluetooth
> > > > +---------------------
> > > > +
> > > > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > > > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > > > +to upload firmware and change module speed.
> > > > +
> > > > +Required properties:
> > > > +
> > > > + - compatible: should be one of the following:
> > > > +   * "realtek,rtl8723bs-bt"
> > > > +   * "realtek,rtl8723cs-bt"
> > > > +Optional properties:
> > > > +
> > > > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > > > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > > > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > > > + - firmware-postfix: firmware postfix to be used for firmware config
> > >
> 
> sorry, i didn't noticed your great series before. David and i working at the same stuff but for the Asus Tinker Board.
> 
> I created a similiar yet untested patch version for hci_h5 [1]. Maybe it's useful.
> 
> Just a comment about the binding. It's really necessary to add the reset-gpio? Can't we use the enable-gpio with inverse polarity for this?
> 
> Stefan

[1] - https://gist.github.com/lategoodbye/79bac99d4f1158a719a48ea3c45eb7f1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
