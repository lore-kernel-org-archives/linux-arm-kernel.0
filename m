Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:06:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CC320879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rR7JJGIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CC320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U1L1GGioFhVrMvquOXWeURdCCrNUm/jCSLO+a7XE1v4=; b=rR7JJGITXSBCDQ
	0Mm5HC5JeKs5moBcpEi7Xf6Jhkctd7DGBUwInytfR20dMj2XOZxH6Y0ZLTIQTjryiOBiBwvvAc1a2
	QUpAUf5kC+fhUyGBS1t3xKPeLmAX32G7ng6UFZQlgLWjufmKubefydcmCg0D9qjfZGA46cpUttcgs
	ctzpc5i1s40JARvMXM6y7bPD6hHhXSyy3c9IS4Gtbj9sX7AXjeeRLmevaVUYicR3enjvet7wVOR2u
	s6SonanW5h5d3COU4Kjfjh18pwhyLa1q9VnyQ74ySAENn03rSCom1EuY4C7KvS8+0t9po57xnRc7p
	3gZIOVQoCHlSlpCOFRXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gctiZ-0005Dv-RZ; Fri, 28 Dec 2018 15:06:31 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gctiV-0005D8-Ky; Fri, 28 Dec 2018 15:06:29 +0000
Received: from oxbsltgw03.schlund.de ([212.227.220.147]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBE3k-1gUbia3HCQ-00CiqB; Fri, 28 Dec 2018 16:06:06 +0100
Date: Fri, 28 Dec 2018 16:06:05 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Eric Anholt <eric@anholt.net>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Message-ID: <513165257.381448.1546009565830@email.ionos.de>
In-Reply-To: <87y38abzu7.fsf@anholt.net>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
 <1941132339.131316.1545481176339@email.ionos.de>
 <baa17fb765bf8b40fe6e91b4884b83af6fcf7641.camel@bootlin.com>
 <1232214204.268730.1545919526431@email.ionos.de>
 <87y38abzu7.fsf@anholt.net>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:us9xatHzMPMq6vAt9kXYUHE+Be5QQSMjKmPVxFKjI43Nekr0dsf
 CcGbMfbvESd3HJ3K7G6FG2ocwqzkeFfJDgoluzOl8BdtxiO/2EFXS0yc+kzTWQU+JPnJUnQ
 nLy2iS5MY2HVcEnxszIPncboQV0BSLGMseiP6kxd++XPL4fbYzSk4/kqV4JXvoj5RE5o85E
 O4zPrctYyWGFYCqTR0Qfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W+B3ZzUNDLU=:bg65cl90U0SxqHUyq+SJy8
 tvHpJWVwb7o6TCz5VGzvUqvjltJ3j/DHpUwB4O6ISBQrSafZMib8gAHp97DZt9P8DpsdYEO2n
 +RAhLSsKi8Rkgo7wSOIwXaUN3GYVv6nTbzxBfzgJWip6IG6+jgP/MF5XDLJ4geyAoNU87NTeq
 DmRwbdTxPZpkRepPGQAVLpxhVWeyMZDVmysWH2h3ZGpDo5DodY+DjckZbNONZshy3oltL+Z2/
 ZP9WNbp/MftMRgAd5yxofnMitbmQRc8ftbzokZkFMGLTWcJvxZQUB7IBwO1FOSS3+1ahc8m9/
 B5YsYiMyCQN0V06XaGHe6IL4SinrlpPb/+P1LcK3mtIowgArruF5D864FPaPRJzN+6FdTAKC9
 0bKvVKm6+cBRFBjrIn2rO5Iq3zXc8LeNPd/tMi7W/PCH+SypTAof6S9qsxyq4zWYHuOgfCSTd
 xTM0tnVlcOJ8nY2t3unwB6rHbWlrxV/6mBvZpWcsVPVmlEy266vmyljRZH5UZW/jJT2GcS20Q
 lTqzTj6Y+oJnrxIQ6neG7oPHtHJPyUWfHvtW2EVCkVsB8B0mVRDY1ZHZUDY9Zg+rLHni09D6E
 tYduFu8LJkKxJIp+7e71MdSV3fwDFYIvgAxWG221fs/nzQ7TFat8oOFydHgokch2XL8+Wouip
 elU2g2u4PdHdxjtf3zzmeMZbEn74AXu6JEWQTllkN+iUR4q24T+9et4Hv0etooq5xIClfRUye
 DMseFRf/O3Ln+3BPFUgUt2uanpm4BUYyOQzXjPzojyvqZQgdsh/ZmbeS4O0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_070627_991116_EE80642B 
X-CRM114-Status: GOOD (  28.42  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> Eric Anholt <eric@anholt.net> hat am 27. Dezember 2018 um 19:15 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Paul,
> >
> >> Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 24. Dezember 2018 um 10:10 geschrieben:
> >> 
> >> 
> >> Hi,
> >> 
> >> On Sat, 2018-12-22 at 13:19 +0100, Stefan Wahren wrote:
> >> > Hi Paul,
> >> > 
> >> > > Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 21. Dezember 2018 um 13:11 geschrieben:
> >> > > 
> >> > > 
> >> > > The driver's interrupt handler checks whether a message is currently
> >> > > being handled with the curr_msg pointer. When it is NULL, the interrupt
> >> > > is considered to be unexpected. Similarly, the i2c_start_transfer
> >> > > routine checks for the remaining number of messages to handle in
> >> > > num_msgs.
> >> > > 
> >> > > However, these values are never cleared and always keep the message and
> >> > > number relevant to the latest transfer (which might be done already and
> >> > > the underlying message memory might have been freed).
> >> > > 
> >> > > When an unexpected interrupt hits with the DONE bit set, the isr will
> >> > > then try to access the flags field of the curr_msg structure, leading
> >> > > to a fatal page fault.
> >> > > 
> >> > > Fix the issue by systematically clearing curr_msg and num_msgs in the
> >> > > driver-wide device structure when a transfer is considered complete.
> >> > > 
> >> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> >> > > ---
> >> > >  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
> >> > >  1 file changed, 3 insertions(+)
> >> > > 
> >> > > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> >> > > index 44deae78913e..5486252f5f2f 100644
> >> > > --- a/drivers/i2c/busses/i2c-bcm2835.c
> >> > > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> >> > > @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> >> > >  		return -ETIMEDOUT;
> >> > >  	}
> >> > >  
> >> > > +	i2c_dev->curr_msg = NULL;
> >> > > +	i2c_dev->num_msgs = 0;
> >> > 
> >> > AFAIU this would reduce the chance of a use-after-free dramatically but not completely.
> >> 
> >> Do you have a specific case of use-after-free related to these
> >> variables in mind that this cleanup would not fix (except for the
> >> timeout case)?
> >
> > okay i was wrong about the use-after-free. But i'm not sure about this scenario on the I2C bus shared with the VC4:
> >
> > 1. ARM core starts I2C transfer (bcm2835_i2c_start_transfer)
> > 2. VC4 triggers a BCM2835_I2C_S_DONE interrupt
> > 3. ARM core catches this interrupt before the VC4
> 
> We don't share I2C buses with VC4, though, right?  That would just be
> totally broken.

All i remember is this comment on Github:
https://github.com/anholt/linux/issues/89#issuecomment-280111496

and currently all 3 I2C busses are enabled for the ARM core in bcm2835-rpi.dtsi.

Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
