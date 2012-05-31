From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:20:31 +0800
Subject: [RFC 24/34] dmaengine: PL08x: split the pend_list in two
In-Reply-To: <E1SZIxU-00070J-HB@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIxU-00070J-HB@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdZ=13F8TDwH_-ajB-u_A-dUN8ZbnNV5dmpabHJ2z5cRAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:43 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Our behaviour wasn't correct; issue_pending is supposed to be called
> before any submitted descriptors are available for processing by the
> DMA engine. ?Split the pend_list in two, one for submitted descriptors
> and another list for issued descriptors.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I suspect many DMAengine drivers get this wrong, or rather, they merge the
semantics for submitted/issued like this driver used to do.

Dan, please check this, we might need to notify a few driver maintainers to
look at this and add TODO:s to their driver files.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
