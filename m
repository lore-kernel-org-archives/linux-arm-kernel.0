From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Apr 2014 20:47:11 +0800
Subject: [PATCH] ARM i.MX51: Add Digi ConnectCore devicetree
In-Reply-To: <1396440407.634334403@f167.i.mail.ru>
References: <1396075706-25384-1-git-send-email-shc_work@mail.ru>
 <1396439100.597907550@f167.i.mail.ru>
 <20140402115612.GI8753@dragon>
 <1396440407.634334403@f167.i.mail.ru>
Message-ID: <20140402124710.GC10283@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 04:06:47PM +0400, Alexander Shiyan wrote:
> > > > > +&weim {
> > > > > +	pinctrl-names = "default";
> > > > > +	pinctrl-0 = <&pinctrl_weim>;
> > > > > +	status = "okay";
> > > > > +
> > > > > +	lan9221: lan9221 at ce000000 {
> > > > 
> > > > How does 'ce000000' in the node name comes?
> > > 
> > > This is a WEIM CS5 start address.
> > 
> > Hmm, shouldn't the unit-address come from the 'reg' property of the node
> > somehow?
> 
> I'm not sure. Here is the real physical address of the device, in the case of
> using an address from the "reg", we get zero address.
> 
> Just imagine, that we have a second LAN chip on the start of CS4.
> Two identical devices?

The node name should be 'lan9221 at 5,0' and 'lan9221 at 4,0' respectively.

Shawn
