From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 12 Dec 2011 15:50:48 +0800
Subject: [PATCH 1/7] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <20111212060832.GF9572@S2100-06.ap.freescale.net>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <1323661352-10291-2-git-send-email-richard.zhao@linaro.org>
 <20111212054053.GD9572@S2100-06.ap.freescale.net>
 <20111212054857.GB16350@b20223-02.ap.freescale.net>
 <20111212060832.GF9572@S2100-06.ap.freescale.net>
Message-ID: <20111212075047.GA13652@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > +
> > > > +	chosen {
> > > > +		bootargs = "console=ttymxc1,115200";
> > > > +	};
> > > > +
> > > Maybe we can start dropping this, since kernel is now able to get
> > > bootargs from atags even in case that bootloader can not pass dtb
> > > and the dtb is appended to kernel image.
> > kernel has a config "Extend bootloader kernel arguments". Does it help
> > such case?
> 
> CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
I don't like puting cmdline in dts either, but kernel provide
CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_FORCE, it's better to at least
let uart work. I don't quite insist on it.

Thanks
Richard
> 
> -- 
> Regards,
> Shawn
