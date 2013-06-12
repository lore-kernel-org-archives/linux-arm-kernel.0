From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 13:29:07 +0200
Subject: [PATCHv4 2/9] i2c: mv64xxx: make the registers offset configurable
In-Reply-To: <20130612105431.GS16502@lunn.ch>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130612105431.GS16502@lunn.ch>
Message-ID: <20130612112907.GE16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Wed, Jun 12, 2013 at 12:54:31PM +0200, Andrew Lunn wrote:
> On Wed, Jun 12, 2013 at 10:07:11AM +0200, Maxime Ripard wrote:
> > The Allwinner i2c controller uses the same logic as the Marvell one, but
> > with slightly different register offsets.
> > 
> > Introduce a structure that will be passed by either the pdata or
> > associated to the compatible strings, and that holds the various
> > registers that might be needed.
> 
> Hi Maxime
> 
> I don't think this change is bisectable. It assumes the platform data
> passes the registers, which is not true until the next patch.
> 
> Please can you re-arrange the order. Add the extra information to the
> platform data, and then make use of it, not the other way around.

Thanks to Tomasz comments, the next patch will be removed, and the whole
regs passing in the pdata as well, so it will become bisectable.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
