From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jul 2012 12:33:24 +0000
Subject: [PATCH v2 04/23] ARM: LPC32xx: Add DMA configuration to platform
 data
In-Reply-To: <4FFD393F.1070104@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
 <201207102136.35944.arnd@arndb.de> <4FFD393F.1070104@antcom.de>
Message-ID: <201207111233.24780.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 July 2012, Roland Stigge wrote:
> Thanks for the note! Looks like the interface consolidated to replace
> ch->cd->min_signal with sth. like cd->min_signal directly.
> 
> Accessing the signal id/number is/was quite convenient because as you
> can see in the 3 above cases that now get compile errors with the pl08x
> changes, the LPC32xx chip hard-wires those numbers, and the respective
> code is LPC32xx specific anyway.
> 
> So can we make an exception here to compare static dma channel numbers?
> Or is there any other interface to access the static dma channel numbers
> that I'm currently not aware of?
> 
> Depending on what we agree upon, I can then provide fixes to the
> lpc32xx-next branch.

I'm not familiar with this code, but I think the solution for now
(while we don't have a DT binding) is to do the same thing that
spear3xx does: pass a pointer to the global pl08x_filter_id
function and an identifier for the channel in the platform data
for that device.

	Arnd
