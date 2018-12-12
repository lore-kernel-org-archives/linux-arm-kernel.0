Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E32C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:13:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6858C20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="evR/7e50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6858C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:Date:Subject:To:
	From:Message-ID:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VwmSxJ7l5xEJQ3pVbSw3+YbOeoR9qQDTGafbICIg09k=; b=evR/7e50lGoYtX
	9A7vD8vT2/6kp7DMSdvEvjumWPhziiQ3lAj2W9deDinmYg8LXwqlEwBjZqT7QmV+D1vYjsHpVd8jZ
	UFlHPCUmFNiNkRaNjV/fta1p4M/amUuxNmwDYZVq2LrpqoPTAicONfLTngtrwQ5hJ9PdhehocEngK
	m/QCztwByCzoOdPBCf6B3WGKcsXjUdrjW0LrMfSKtKCzCHEmwk4K1HJeMWUwTGzEwXAeKcYIqNBr3
	lDTYfcFPnfldZ9NeSR64AafsuNcawcN9nviGepW2p3lTshz+idtHi5NpEFzp/O3Hde8AfSxj3W9eT
	/33b4Ke1p6O1jdmvT6sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX6Ci-00055K-EI; Wed, 12 Dec 2018 15:13:40 +0000
Received: from mout.gmx.net ([212.227.17.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX6CZ-00054s-9n; Wed, 12 Dec 2018 15:13:38 +0000
Received: from [91.14.90.202] ([91.14.90.202]) by web-mail.gmx.net
 (3c-app-gmx-bs62.server.lan [172.19.170.146]) (via HTTP); Wed, 12 Dec 2018
 16:12:53 +0100
MIME-Version: 1.0
Message-ID: <trinity-4ee13d71-22e7-4f95-a7b9-09bbefe7e6b6-1544627573309@3c-app-gmx-bs62>
From: "Frank Wunderlich" <frank-w@public-files.de>
To: "Florian Fainelli" <f.fainelli@gmail.com>
Subject: Aw: Re: [PATCH 1/7] [DSA] adding fields for holding information
 about upstream-port
Date: Wed, 12 Dec 2018 16:12:53 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <63046efc-820c-aabf-a6f9-9393550b7056@gmail.com>
References: <20181211193314.10695-1-frank-w@public-files.de>
 <63046efc-820c-aabf-a6f9-9393550b7056@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:XaahGVcb9eFEcnsZXHEyunB90lIfDK8Sg+WAqj22HRmu3CoaaBK0C1NuTHhrZan7rTg+s
 64kQVIrG49m3ufBmwxMuEWZlgsFUmm3kRf5JWQpkHn4GiJJCUaA/WOIuS79B8IP5EbXe4adktoi3
 HZkW1Uo+XZ8Ar7Su7m1wCST7jTrra0HDDnHNQEXefrPsMaVMFhaAz+JucoBD2mgoe3TR3H6HGASh
 rHz0WGjk3NM3zHeSo8cgG0q+2qq5w30rWI5dSPjIp6No1sgN4vpvz3xls752GdUnLEdpHFU2p6yM
 hw=
X-UI-Out-Filterresults: notjunk:1;V03:K0:UCKdhjoVNRA=:4T7KRoNxQwkqoJ7Ye6hoZt
 r2kOW4ScGK2q4hVivqsziODtnYPISOxIlRIrDQSm2im1ZhandccDroMI+qDH01FanUKaEDpv3
 XtieFlTEBpY6mayz+Hr3jee98BpcpgAh1bDOeU4vbINnDURTJl83qtxOGzDLDk5b5wb3gz9sv
 u1pURavq/70MLDqGm0Brzzi/T8IFNw3RpsPZ8Q5aSHtXJug5EgiCnKn10i+BVCaa2aMnbB2Iu
 pn2jlqDgmPNsacB6fNufrXglAJBiRdDnL/AcuSjherVSaRmeYOrGpUdAbKSe/IlO+LtxHIOf+
 W1NtEkJgIImFe7jlWn7IpPWPyyefhlGPC8cyCyLDkp1sK3MoaYLvG98oIS2kEJnIiv8jSF6Ym
 S4RGL8IVhMpfLeMPxFfAZe2tntNryUP0+3s3wUTuoWF/4Iqmt6mVVgpCI1YXDGnd72vZatNhW
 Mj7+jr6jC1smPf4WfCv7D/zjVYrN0+Qeh0uXfKGlSLa3aptFReiaDEmAj8X4Fks0aeANamX2P
 nArAHp5uV0+YmxO/mwGFX6ZRGmhDHeUVl5wGqVREtIxHnPANgiLmj4hZOt0Ciqr3l11YCMWaq
 XkH4QedSC/kTE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_071331_684699_A4C3CCFF 
X-CRM114-Status: GOOD (  22.13  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Vivien Didelot <vivien.didelot@savoirfairelinux.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Florian,

thank you for first comments. It was my first Patchset i tried to send ia git send-email. i had searched the Patch 0/x-option but had not found it. i will rework this.

- i did only a porting to 4.15+ dsa-core. how do i credit John in this series?
- maybe i need a fallback to current "first cpu-port option", this was not defined by john, but i can add it in next series
- should i include dts (bananapi r2) also in the series?
- i have a additional patch renaming dts-option to default_cpu instead of cpu (hint of Andrew)

regards Frank


> Gesendet: Dienstag, 11. Dezember 2018 um 23:37 Uhr
> Von: "Florian Fainelli" <f.fainelli@gmail.com>
> An: "Frank Wunderlich" <frank-w@public-files.de>, "Andrew Lunn" <andrew@lunn.ch>, "Vivien Didelot" <vivien.didelot@savoirfairelinux.com>, "David S. Miller" <davem@davemloft.net>, "Matthias Brugger" <matthias.bgg@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
> Betreff: Re: [PATCH 1/7] [DSA] adding fields for holding information about upstream-port
>
> Hi,,
> 
> On 12/11/18 11:33 AM, Frank Wunderlich wrote:
> > based on
> > https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0033-dsa-multi-cpu.patch
> 
> There are several stylistic as well as logistical/technical issues with
> this patch series, so please address those before we can start doing the
> technical review:
> 
> - this is a multi patch series, so a cover letter should be provided
> (can be done with git format-patch --cover-letter)
> 
> - subject for the patches should be prefixed with net: dsa: <subject>
> 
> - commit messages explaining what is being achieved, how and what
> problem/feature this is providing is mandatory, you cannot just take
> patches from OpenWrt and provide no context what so ever except from the
> subject
> 
> Please fix that so we can do a meaningful and constructive technical
> review of the patches.
> 
> Thank you
> 
> > 
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  include/net/dsa.h  | 4 ++++
> >  net/dsa/dsa_priv.h | 5 +++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/include/net/dsa.h b/include/net/dsa.h
> > index 23690c44e167..3efa81e08993 100644
> > --- a/include/net/dsa.h
> > +++ b/include/net/dsa.h
> > @@ -203,6 +203,10 @@ struct dsa_port {
> >  	struct net_device	*bridge_dev;
> >  	struct devlink_port	devlink_port;
> >  	struct phylink		*pl;
> > +
> > +	struct net_device	*ethernet;
> > +	int			upstream;
> > +
> >  	/*
> >  	 * Original copy of the master netdev ethtool_ops
> >  	 */
> > diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
> > index 9e4fd04ab53c..cc0cd7675117 100644
> > --- a/net/dsa/dsa_priv.h
> > +++ b/net/dsa/dsa_priv.h
> > @@ -81,6 +81,8 @@ struct dsa_slave_priv {
> >  
> >  	/* TC context */
> >  	struct list_head	mall_tc_list;
> > +
> > +	struct net_device       *master;
> >  };
> >  
> >  /* dsa.c */
> > @@ -188,7 +190,10 @@ static inline struct net_device *
> >  dsa_slave_to_master(const struct net_device *dev)
> >  {
> >  	struct dsa_port *dp = dsa_slave_to_port(dev);
> > +	struct dsa_slave_priv *p = netdev_priv(dev);
> >  
> > +	if (p->master)
> > +		return p->master;
> >  	return dp->cpu_dp->master;
> >  }
> >  
> > 
> 
> 
> -- 
> Florian
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
