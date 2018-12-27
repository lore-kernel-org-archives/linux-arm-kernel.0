Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F629C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:06:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC2220873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YAS5FNOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC2220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FiA1vJOpN/czrSaFkSgMPqWFMdZvxgOa/QvltfvxwIg=; b=YAS5FNOZ1wS3is
	uN5pv/m2H22ehPOJ6GZC5niwtBF/Kr4LOoXHZkgmC9UWvhd/JXKU+NYUGznJcz74aR4jmdkYOugNG
	K8jH1r90kdbXN0Ay6cTSlehupdXSmUF9AwuM3U1VxjuAYiYxJ0tBeqTjjmmggfzmFSxiI7+Pi/KNj
	kH3eFBC4f0rQ1REy6mfFs3c1VZ5cpPjIdXMibQL+8USglsFnMh4XwPWIpKiB/mGzsXPral47t3xjW
	w7n2GMjoeVg/La/90KIsACNt1VDxRhr+s3BxO3NGc1ZSuKf1EKNtq0FUQcw6GYg4MEIgz7zk1PdT8
	Bqx1i91lfj2BFLt7NHEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcWIK-0001ER-CP; Thu, 27 Dec 2018 14:05:52 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcWID-0001Dv-PJ; Thu, 27 Dec 2018 14:05:50 +0000
Received: from oxbsltgw01.schlund.de ([212.227.220.145]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3DaN-1gdsni1hE5-003g2j; Thu, 27 Dec 2018 15:05:27 +0100
Date: Thu, 27 Dec 2018 15:05:26 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Message-ID: <1232214204.268730.1545919526431@email.ionos.de>
In-Reply-To: <baa17fb765bf8b40fe6e91b4884b83af6fcf7641.camel@bootlin.com>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
 <1941132339.131316.1545481176339@email.ionos.de>
 <baa17fb765bf8b40fe6e91b4884b83af6fcf7641.camel@bootlin.com>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:bkHrRQSzEZAB3EkVyauNGzE9blzsvZJTbZfxiCMtNSBZBy1BzlJ
 0uyYAI8QNl9zetV7oJvwirP74XLhDur2QfBa0oc08bxPuAT6jSmFLFFhqR+vg3l4COSI52Y
 620kn9pOsA4TfrZHXk2CQzDuBkjLBw0cEcpxEhJOOl1aC+N0lfRwK1aoNAF9wAtXspiwt0u
 KTHjFZKcFuPEaC2L8YU9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r2FXzmONG+w=:MNB21GyzlDtQSWfAN9SG9J
 CeVhx5Sq5BeKlSRHRbbN10rR02+jWzrRVhHjAwTK9H9xaDiGHlIvgC2k+OWFp/t5Gghd++DPJ
 YD8tAKpUR31YQxytiOjotRUx/g+lXXlsQrvXAL7RpR4jukzgNy0HsV4hJKSWNYoSp519pPvvq
 ddqI/INFqs4MtlMzm/rL/G3PfNX1RSDHqrbBdaXSuAW503XTDA14ajsBmMJ0S0I61m6Gt7zhC
 Umb+ldN9X/Eivv3aRxy+xNj7dPhPgwJYEC1nf+saAVdPdtjuaYR52oFBRrjOHSb2cnicMxtqO
 74GfgeTMTyR07XFS+cN24KNoaBw3ZWBKepdwtXXey51RqA0TwLLTAMlXRsEXgqTGFKP7RbJOg
 7phGohipzXpJmJA+kS2KF47/K5bC8CH85FZFmeMEX4EKKe+kkHD+UDCJARrj6iAIegj0FD7ui
 sINT6kOBzGWD5JS64Ax6y5u0xLjdGst0EQ1a5ZkfkkYr2qrPduVBepNEv58GdU18gyDIHoFC7
 HjvK/D5M6eIB2abgG0vfoT/XH6MVXkYnOj06y9Fu0NLoNKZbuj/wSsYYZmJj0y1reJs1ZggyN
 v6TMDpU5y2xMSx6Hk/Zq+YamSlDmW4yLHBDKVpYCuDrepJ4qT5NiEgMDa3krMn3wLKhqVk9iW
 OO5SWf3+YSujHfcmO+lprspPDDOcMvBH7eObbTbgAZotB1Ua+KkDK4ta+0mdhKLQupwpHChl4
 82CWAPObpzwSAHcH7UPEdonfZgq6BNegCOml4RWRRMkSxPe7HwGS/kFiHpQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_060546_127759_85DBD442 
X-CRM114-Status: GOOD (  31.05  )
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
 linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Paul,

> Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 24. Dezember 2018 um 10:10 geschrieben:
> 
> 
> Hi,
> 
> On Sat, 2018-12-22 at 13:19 +0100, Stefan Wahren wrote:
> > Hi Paul,
> > 
> > > Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 21. Dezember 2018 um 13:11 geschrieben:
> > > 
> > > 
> > > The driver's interrupt handler checks whether a message is currently
> > > being handled with the curr_msg pointer. When it is NULL, the interrupt
> > > is considered to be unexpected. Similarly, the i2c_start_transfer
> > > routine checks for the remaining number of messages to handle in
> > > num_msgs.
> > > 
> > > However, these values are never cleared and always keep the message and
> > > number relevant to the latest transfer (which might be done already and
> > > the underlying message memory might have been freed).
> > > 
> > > When an unexpected interrupt hits with the DONE bit set, the isr will
> > > then try to access the flags field of the curr_msg structure, leading
> > > to a fatal page fault.
> > > 
> > > Fix the issue by systematically clearing curr_msg and num_msgs in the
> > > driver-wide device structure when a transfer is considered complete.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> > > index 44deae78913e..5486252f5f2f 100644
> > > --- a/drivers/i2c/busses/i2c-bcm2835.c
> > > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> > > @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> > >  		return -ETIMEDOUT;
> > >  	}
> > >  
> > > +	i2c_dev->curr_msg = NULL;
> > > +	i2c_dev->num_msgs = 0;
> > 
> > AFAIU this would reduce the chance of a use-after-free dramatically but not completely.
> 
> Do you have a specific case of use-after-free related to these
> variables in mind that this cleanup would not fix (except for the
> timeout case)?

okay i was wrong about the use-after-free. But i'm not sure about this scenario on the I2C bus shared with the VC4:

1. ARM core starts I2C transfer (bcm2835_i2c_start_transfer)
2. VC4 triggers a BCM2835_I2C_S_DONE interrupt
3. ARM core catches this interrupt before the VC4

Stefan

> 
> The msg_buf element (in association with msg_buf_remaining keeping its
> previous value) could also lead to similar problems, so I'm thinking of
> making a bcm2835_i2c_finish_transfer function to group all the cleanups
> and call that right after wait_for_completion_timeout.
> 
> > Btw: Why did you leave of the i2c transfer timeout case?
> 
> I should definitely have included it, actually.
> 
> Cheers,
> 
> Paul
> 
> > Thanks
> > Stefan
> > 
> > > +
> > >  	if (!i2c_dev->msg_err)
> > >  		return num;
> > >  
> > > -- 
> > > 2.20.1
> > > 
> -- 
> Paul Kocialkowski, Bootlin (formerly Free Electrons)
> Embedded Linux and kernel engineering
> https://bootlin.com
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
