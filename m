From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 31 Jul 2013 10:32:36 -0400 (EDT)
Subject: [PATCH v2 26/42] USB: ohci-at91: add usb_clk for transition to
 common clk framework
In-Reply-To: <51F8C31B.1020305@overkiz.com>
Message-ID: <Pine.LNX.4.44L0.1307311030260.1546-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Jul 2013, boris brezillon wrote:

> Hello Alan,
> 
> I don't know if you remember but a few days back I sent a series which
> included this patch ("ARM: at91: prepare transition to common clk 
> framework").
> 
> It was decided to move this patch out of the "prepare" series to avoid 
> backward
> compatility handling.
> 
> Things have changed a little bit.
> 
> I was asked to split the "ARM: at91: move to common clk framework" 
> series into
> several smaller series (one for each SoC).
> This means at91 will have some SoCs supporting using common clk framework
> (and thus will define the usb_clk) and other SoCs using the old at91 clk 
> implementation
> (which does not define usb_clk).
> 
> I was also requested to drop common clk framework support for non dt 
> boards, which
> means, as long as at91 keep non dt boards the at91 old clk implem will 
> remain active.
> 
> For all these reasons I will have to reintroduce the backward 
> compatibility hack.
> 
> Should I get this patch (and patch 27) out of the this series and back 
> to the "prepare" series ?

I don't care too much how the two patch series are organized, although
some of the other maintainers involved in this project might.  So long
as everything remains compatible with all the hardware variations and
bisectable at each stage, I'll be happy.

Alan Stern
