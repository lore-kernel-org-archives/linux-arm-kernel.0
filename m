From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 13 Dec 2011 09:32:00 +0800
Subject: [PATCH 1/7] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <20111213012816.GB10437@S2100-06.ap.freescale.net>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <1323661352-10291-2-git-send-email-richard.zhao@linaro.org>
 <20111212054053.GD9572@S2100-06.ap.freescale.net>
 <4EE6666A.9040005@boundarydevices.com>
 <20111213005213.GA28768@b20223-02.ap.freescale.net>
 <20111213012816.GB10437@S2100-06.ap.freescale.net>
Message-ID: <20111213013159.GC28768@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 09:28:17AM +0800, Shawn Guo wrote:
> On Tue, Dec 13, 2011 at 08:52:14AM +0800, Richard Zhao wrote:
> > On Mon, Dec 12, 2011 at 01:39:06PM -0700, Troy Kisky wrote:
> > > On 12/11/2011 10:40 PM, Shawn Guo wrote:
> > > >>+	memory {
> > > >>+		reg =<0x10000000 0x40000000>;
> > > >>+	};
> > > >>+
> > > >>+	soc {
> > > >>+		aips-bus at 02100000 { /* AIPS2 */
> > > >>+			enet at 02188000 {
> > > >>+				phy-mode = "rgmii";
> > > >>+				local-mac-address = [01 04 9F 01 1B 61];
> > > >Do we still have no way to figure the mac address from hardware setup
> > > >(fuse or something) on sabrelite board?
> > > >
> > > >
> > > U-boot now has support for blowing the mac fuses.
> > > 
> > > i.e.
> > > imxotp blow --force 23 0019 ; imxotp blow --force 22 B800e1f5
> > > 
> > > for a mac of 00:19:b8:00:e1:f5
> > > 
> > > Most boards already have this done.
> > It's software issue here. When use DT, we don't still have patch to
> > read fuse and pass mac address to fec driver. Currently, we can use
> > bootargs fec.macaddr.
> > 
> Okay, if it's a software issue, we should sort it out right now.  Plus
> the fec phy fixup hook, I have seen two cases that we need to pass
> platform_data for fec driver, so let us do it.
right, I'm glad to see patch fix it too. but I think it's out of scope of
this patch series. The patch series is for enablement.

Thanks
Richard
> 
> Regards,
> Shawn
