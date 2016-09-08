From: jorik@kippendief.biz (Jorik Jonker)
Date: Thu, 8 Sep 2016 10:02:13 +0200
Subject: [PATCH v4 4/8] dts: sun8i-h3: move uart1 pinmux/peripheral
 assocation to DSTI
In-Reply-To: <20160908062317.GD8913@lukather>
References: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
 <1473235141-12768-5-git-send-email-jorik@kippendief.biz>
 <20160908062317.GD8913@lukather>
Message-ID: <20160908080213.GA32547@carbon.kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime, Chen-Yu: thanks for taking the effort to go through my patches 
again!

On Thu, Sep 08, 2016 at 08:23:17AM +0200, Maxime Ripard wrote:
>On Wed, Sep 07, 2016 at 09:58:57AM +0200, jorik at kippendief.biz wrote:
>> From: Jorik Jonker <jorik@kippendief.biz>
>>
>> Users using this UART without RTS/CTS should override the association in
>> their board specific DTS. All (1) board using this UART uses RTS/CTS, so
>> this breaks nothing.
>
>Using RTS / CTS is very rare among the boards. Forcing it down the
>throat of every user doesn't seem like the right thing to do.

So, I'm going for a v5, with these changes:
- rename uart0_pins to uart0_pa_pins (as there could be a pf)
- associate uart0_pa_pins with uart0 on all H3 board DTS files
- put rts/cts in seperate pinmux sets for uart1 (2,3: see below)
- associate rx/tx for uart1-3 in H3 DTSI (this is the only option)
- associate UART1 rts/cts as pinctrl-1 in sun8i-h3-bananapi-m2-plus
  (to prevent breakage for existing users)

I am a bit in doubt if I should include pinmux definitions for the 
following things, as Chen-Yu said to only include stuff that is actually 
used in a board:

- uart0_pf_pins, since there is no board using it
- uart{2,3}_rts_cts, as I agree RTS/CTS is a bit exotic

Maxime/Chen-Yu: what do you think of this?

Best,
Jorik
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/6efb4bf1/attachment-0001.sig>
