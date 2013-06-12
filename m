From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 14:44:32 +0200
Subject: [PATCHv4 0/9] Add I2C support for Allwinner SoCs
In-Reply-To: <201306121438.12549.arnd@arndb.de>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <3315236.ZNXhyxmCRd@wuerfel> <20130612113849.GG16699@lukather>
 <201306121438.12549.arnd@arndb.de>
Message-ID: <20130612124432.GH16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 02:38:12PM +0200, Arnd Bergmann wrote:
> On Wednesday 12 June 2013, Maxime Ripard wrote:
> > The Marvell and Allwinner controllers share the exact same logic (which
> > is definitely not trivial), based on a finite state machine that
> > triggers interrupts at each change of state, each state being a state in
> > the I2C protocol (like address sent, data received with an ACK, etc.).
> > 
> > The weird thing is that the only difference between the two controllers
> > is the register offsets, and that's it. The state numbers, bit index,
> > etc, are exactly the same.
> 
> Ok, cool. Great someone noticed!

Kudos to Wolfram :)

> > So yes, I think they both licensed the same IP.
> 
> I wonder if it's the Mentor Graphics Inventra mi2c block, which
> would make sense given that Allwinner also uses musb.

The only datasheet or manual I have been able to find is
http://www.mentor.com/products/ip/peripheral/ip_interface/upload/mi2c_pd.pdf
which doesn't give a lot of details. Yet, from what is shown and
explained in the second page, it looks like it could be this IP.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
