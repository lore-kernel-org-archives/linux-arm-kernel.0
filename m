Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:59:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7420A20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n5fM6Uns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7420A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Mime-Version:References:
	In-Reply-To:To:From:Subject:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KxYAnNn+2belrHs0YMy58rKPd97+0hvJRpmoufhEk2g=; b=n5fM6UnsUJAMuSwXWgti8ZfA+e
	Vi+cNRZK8kzyRP2lXTLqxUQvB33XqBfNsMAdk8zkFRTRVZWLRQ/zLvRP6MDRgj82r76G4HRSzf+5e
	4iEwBw5tNbMbyyWdxSMQRs3lmgUfHNY3DgHSDvo9ZFK6A4Tjqn18eMtMPTkmaGWLjJ1ZhQ1mH7OiX
	CZL1TcpbG3ZAwbOwyCR67bL+Gkh0IYsKhjYdMkzn7eR95yRpU6/MPWKh/9OiQ/KhAyVKWsuaqpeOi
	C0+5M67nqIfFIwgrINmQ0hHNK9at+NwHGO575EkInb+3PXnKUl/+Qn/NFy7Ja4LOIwZ5eTOUsHUu9
	RkufF7bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8ND-000783-Jn; Mon, 11 Feb 2019 09:59:35 +0000
Received: from mout.perfora.net ([74.208.4.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8N9-00077P-Ab
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:59:33 +0000
Received: from marcel-nb-toradex-int ([46.140.72.82]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LpvE1-1hYFoB38Mx-00fmOl; 
 Mon, 11 Feb 2019 10:59:17 +0100
Message-ID: <0bed49114afa5cb847a1f897296f41171b812fbd.camel@toradex.com>
Subject: Re: [REGRESSION] drm/tegra: hdmi: tegra_hdmi_setup_audio: division
 by zero in kernel
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: Thierry Reding <treding@nvidia.com>
In-Reply-To: <20190211080007.GA923@ulmo>
References: <87f8fd40b25e2842b547059a8d28295533e8c09c.camel@toradex.com>
 <20190211080007.GA923@ulmo>
Organization: Toradex AG
Mime-Version: 1.0
Date: Mon, 11 Feb 2019 10:57:01 +0100
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
X-Provags-ID: V03:K1:JS5uF92MkWCKaTRVOgCBTladSGsNdX15wg8aO9fLycAaCKMqdbM
 QGlcJzEgEuQS1bmBeD3zmIKeSmaUjkDC8XcLtfElLAfnk6cpomebjUZvLo922zQnx98rXVR
 5qIJJ78WZoPyTIf1PhzWtBfX+nIF7cVMO6GJVQLdsyXDw4nfMUYpRVk7sTwGS/9WI+Ebr9z
 ThgFHUsN6u+YN2UsYLeqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MtUYUgFhbjs=:xxEVxXd7pJsmZrvZBu5XXG
 hQ/UT93MnrUCs+rv6ulo6TO1iP4MBuW10Y4cIoF7JOX8gf57F7zEpoMhZbbBOBchJ9+bagxxK
 avIm4CBebvmQkmCwj1G8CuyMP8FZI9UUAKmxrd7JPF9INxm9bWzEYU5oTLdaUze9l0Be6tprm
 /i631RmCdql5lxYeTVEwrN8Ydu9etIBa5hg/hC64QL4sl21YHxHXVdBVKY3uRAqbMFNhUvKd0
 MMvYlNhqD1CtbmTXwQ+kEhZ9k7tUFuq9qBTPBYd+KiQ/k9N+wVE4G8ABLNPBC2ZEVBW3Ypwtz
 zJglQz20K2IwCfFqG9NzPKIpvsGg149qc6+3z+RNIkb3pTMIca2Y9wZmsHZ9UOmkxEPYkCG/+
 TbECkJ+B/ULE6yAcAT5BbQXLAgisGcSvYmFCPW/7QmTUSEecR49o06qq8BM2Q/7ZQ39orlTw1
 FO31nhWacq+0kx3kHZ0bBvA9mbv0UxUTAPgRuoT1u+zvnGCj5/Sp6cFRTWevp/EcJHCXtV1X/
 NCmqdgq5QTDehTgoHXH5kSX9XGeNv8jypzg+E1JyF/Sop+MRxV2Ro/C8Gv6kwRpsnRVvGfXtn
 0/A5TuZCO9ZzaufPVjfdQrmdff4MkEchODLOE9fkkTNZfh3tFALC50/Wv55VCgDtu18aaHP/n
 RLWyY3dtiu1Yo1SwwFKP+5WEshXWvk9b/53RgHih0zTez0F+fipzocG4uC20rx8MlVfyzUXb9
 D9hG4VToCtrLYeprVmBAX81lNSlTUJB9sg8GUcdjbGBRiu1if7Y9W/b0L7TZfKtiWD+uzRQIX
 drNKdbw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_015931_438001_03FB59C0 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "alban.bedel@avionic-design.de" <alban.bedel@avionic-design.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Thierry

On Mon, 2019-02-11 at 09:00 +0100, Thierry Reding wrote:
> What exactly was your setup like?

Setup was an Apalis T30 2GB V1.1B module on an Apalis Evaluation board
V1.1A with our 5.7 inch panel connected to parallel RGB as well as DVI-
D aka HDMI connected to a Philips BDM3270 screen. Via kernel command
line I forced regular VESA VGA as follows:

video=HDMI-A-1:640x480-16@60

> I think the only way that this could
> happen is if the sample_rate variable was 0, and I'm not sure how
> that
> could happen. I remember testing this on Beaver without ever seeing a
> crash, so I don't know what I overlooked.
> 
> Looking at the code it seems like the only way that it would happen
> is
> if the format structure was never initialized, and it seems like it
> actually is zeroed out and if nobody ever plays audio over HDMI it
> will
> remain that way. But that means that HDMI would always crash, and
> that
> is definitely not something that I've observed.
> 
> Can you specify what exactly your test case is and how I can
> reproduce?

I believe you once got such an Apalis T30 kit from us. I usually just
install our latest regular BSP e.g. 2.8b5 using the Toradex Easy
Installer [1] directly from the Internet then boot it up and scp the
mainline device tree (renamed) and kernel binary (compiled using
regular tegra_defconfig) to it e.g.:

scp arch/arm/boot/zImage root@<IP>:/media/mmcblk0p1/
scp arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dtb root@<IP>:/media/mmc
blk0p1/tegra30-apalis-eval.dtb

Note: U-Boot just expect a device tree by that name.

Note2: Once it runs mainline the eMMC will be mmcblk2 rather than
mmcblk0.

Upon reboot I stop in U-Boot changing the following arguments:

setenv stdout serial
setenv emmcargs ip=off root=/dev/mmcblk2p2 ro rootfstype=ext3 rootwait
setenv vidargs 'video=HDMI-A-1:640x480-16@60'
saveenv
reset

That should get it booting mainline. Once booted I rename the default
xorg.conf so it falls back to auto configuration using fbdev rather
then trying to use NVIDIA's proprietary downstream L4T Tegra X driver
which should then even get the LXDE up and running e.g.:

root@apalis-t30:~# mv /etc/X11/xorg.conf /etc/X11/xorg.conf.orig

Note3: For NVDIIA L4T R16.5 compatibility reason it runs ancient X.Org
X Server 1.14.7 which does not yet feature any modesetting driver.

However, the particular issue observed happens already during boot in
the kernel way before any user space is involved.

[1] 
https://developer.toradex.com/software/toradex-easy-installer#load-toradex-easy-installer

> Thierry

Cheers

Marcel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
