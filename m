From: utx@penguin.cz (Stanislav Brabec)
Date: Sat, 21 May 2011 16:27:58 +0200
Subject: Disable CF during suspend
In-Reply-To: <20110521094326.GB26323@elf.ucw.cz>
References: <20110521094326.GB26323@elf.ucw.cz>
Message-ID: <1305988078.5824.14.camel@utx.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> Disable SPITZ_SCP_CF_POWER during suspend. Otherwise it eats battery,
> fast. Thanks to Stanislav Brabec.

If you can verify that your card turns off on suspend, then you have my:
Acked-by: Stanislav Brabec <utx@penguin.cz>

But I would line to see more aggressive power control, something like
spitz_card_pwr_ctrl() in old kernels - if there is no CF and no
(external) CF card inserted, then SPITZ_SCP_CF_POWER card be turned off.
If they are memory cards, they can be turned off even while idle.

-- 

________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx, ICQ 116020046, xmpp:utx at jabber.cz
