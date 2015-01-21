From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Wed, 21 Jan 2015 16:21:12 +0100
Subject: [PATCHv5 0/2] INPUT: Route keyboard LEDs through the generic
 LEDs layer
In-Reply-To: <20150102195350.GB27538@amd>
References: <20141226232116.GA5069@type>
 <20150102195350.GB27538@amd>
Message-ID: <20150121152112.GA24789@type.bordeaux.inria.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Pavel Machek, le Fri 02 Jan 2015 20:53:51 +0100, a ?crit :
> > Here is v5 coming, with separate patches for the kbd and the input
> > parts.
> 
> After booting with this, capslock led does not seem to work on text
> console.
> 
> input4::capsl/trigger was none by default, that can't be right, right?
> 
> I tried putting kbd-capslock and input4-capsl there, but that did not
> seem to help.
> 
> It works with heartbeat trigger, but not with input4-numl
> trigger. (But numlock led works ok with that trigger, weird).
> 
> vt::capsl/brightness controls capslock led, even when
> input4-capsl/trigger is set to input4-numl.

I have just tried what you described on a thinkpad lenovo T500, without
any problem, except that the thinkpad BIOS does a couple of funky
things:

- depending on the numlock bios setting, the numlock led will be
  driven by the OS (synchronized mode) or handled internally in the BIOS
  (independent mode).
- in synchronized mode, whenever the internal numlock led is lit, the
  right part of the internal keyboard acts as the keypad keys.

Samuel
