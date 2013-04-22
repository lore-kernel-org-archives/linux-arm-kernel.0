From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Apr 2013 15:36:16 +0100
Subject: [PATCHv2] arm: Preserve TPIDRURW on context switch
In-Reply-To: <517168BB.3070903@dawncrow.de>
References: <517168BB.3070903@dawncrow.de>
Message-ID: <20130422143616.GP14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 05:54:35PM +0200, Andr? Hentschel wrote:
> From: =?UTF-8?q?Andr=C3=A9=20Hentschel?= <nerv@dawncrow.de>
> 
> There are more and more applications coming to WinRT, Wine could support them,
> but mostly they expect to have the thread environment block (TEB) in TPIDRURW.
> This register must be preserved per thread instead of being cleared.
> 
> Signed-off-by: Andr? Hentschel <nerv@dawncrow.de>

This actually makes things less efficient all round, because you
now use the value immediately after loading, which means it will cause
pipeline stalls, certainly on older CPUs.

Could you please rework the patch to try avoiding soo many modifications
to the way things have been done here?
