From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 14:38:12 +0200
Subject: [PATCHv4 0/9] Add I2C support for Allwinner SoCs
In-Reply-To: <20130612113849.GG16699@lukather>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <3315236.ZNXhyxmCRd@wuerfel> <20130612113849.GG16699@lukather>
Message-ID: <201306121438.12549.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013, Maxime Ripard wrote:
> The Marvell and Allwinner controllers share the exact same logic (which
> is definitely not trivial), based on a finite state machine that
> triggers interrupts at each change of state, each state being a state in
> the I2C protocol (like address sent, data received with an ACK, etc.).
> 
> The weird thing is that the only difference between the two controllers
> is the register offsets, and that's it. The state numbers, bit index,
> etc, are exactly the same.

Ok, cool. Great someone noticed!

> So yes, I think they both licensed the same IP.

I wonder if it's the Mentor Graphics Inventra mi2c block, which
would make sense given that Allwinner also uses musb.

	Arnd
