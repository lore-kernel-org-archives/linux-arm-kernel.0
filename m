From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 27 Jun 2012 14:47:57 +0800
Subject: [PATCH v6 13/14] usb: otg: add basic mxs phy driver support
In-Reply-To: <87fw9iv3h0.fsf@ashishki-desk.ger.corp.intel.com>
References: <1340260875-21934-1-git-send-email-richard.zhao@freescale.com>
 <1340260875-21934-14-git-send-email-richard.zhao@freescale.com>
 <87fw9iv3h0.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120627064756.GF21750@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 12:15:23PM +0300, Alexander Shishkin wrote:
> Richard Zhao <richard.zhao@freescale.com> writes:
> 
> > +config USB_MXS_PHY
> > +	tristate "Freescale MXS USB PHY support"
> > +	select STMP_DEVICE
> > +	select USB_OTG_UTILS
> 
> There should also be a dependency on ARM (or maybe even ARCH_MXS),
> because you're using writel_relaxed() here, which only exists on arm and
> sh4 and enabling it on other architectures breaks compilation.
Thanks for your view. I'll add
	depends on ARCH_MXC || ARCH_MXS

Richard
> 
> Regards,
> --
> Alex
> 
