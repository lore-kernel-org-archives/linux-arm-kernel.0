From: marex@denx.de (Marek Vasut)
Date: Tue, 22 Jul 2014 07:45:05 +0200
Subject: [PATCH] ARM: dts: imx: Add alias for ethernet controller
In-Reply-To: <20140722052046.GW8537@dragon>
References: <1393588721-8598-1-git-send-email-marex@denx.de>
 <201407220700.49046.marex@denx.de> <20140722052046.GW8537@dragon>
Message-ID: <201407220745.05173.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 22, 2014 at 07:20:48 AM, Shawn Guo wrote:
> On Tue, Jul 22, 2014 at 07:00:48AM +0200, Marek Vasut wrote:
> > On Tuesday, July 22, 2014 at 05:03:38 AM, Shawn Guo wrote:
> > > On Tue, Jul 22, 2014 at 04:10:26AM +0200, Marek Vasut wrote:
> > > > On Monday, March 24, 2014 at 02:49:38 AM, Shawn Guo wrote:
> > > > > On Tue, Mar 18, 2014 at 01:37:09AM +0100, Marek Vasut wrote:
> > > > > > On Friday, February 28, 2014 at 12:58:41 PM, Marek Vasut wrote:
> > > > > > > Add alias for FEC ethernet on i.MX to allow bootloaders (like
> > > > > > > U-Boot) patch-in the MAC address for FEC using this alias.
> > > > > > > 
> > > > > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > > > 
> > > > > > Bump ?
> > > > > 
> > > > > Sorry.  I had actually applied the patch but forgot replying.
> > > > 
> > > > Hello Shawn,
> > > > 
> > > > I'd like to apply this patch for 3.14-stable , are you OK with this
> > > > please ? Shall I submit it ?
> > > 
> > > I do not see why this is a stable material.  But you do not need my
> > > approval to send patch for stable kernel.  The person you need to
> > > convince is Greg.
> > 
> > Without this patch, you will not get a mac address patched into the DT by
> > the bootloader. Therefore, your device will use a random mac address on
> > the network which is different on every boot. This is not a good thing,
> > don't you agree?
> 
> I agree this is not a good thing.  But it's neither a regression nor a
> critical issue as defined by stable_kernel_rules.txt.

If I cannot even properly boot from an NFS root with v3.14.y , it seems to me to 
be problem enough. Also, MAC address should be a unique identifier, if the FEC 
picks a random MAC, it will wreak havoc on the network (in the better case).

Best regards,
Marek Vasut
