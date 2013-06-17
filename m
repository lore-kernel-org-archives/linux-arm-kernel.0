From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 20:03:37 +0100
Subject: [RFC PATCH 07/11] dmaengine: PL08x: Fix reading the byte count
 in cctl
In-Reply-To: <CACRpkdZW0+wcVGrj1fD-1-UigjVQA7Wad7wEQ2CxFoyod2-YpQ@mail.gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-8-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdZW0+wcVGrj1fD-1-UigjVQA7Wad7wEQ2CxFoyod2-YpQ@mail.gmail.com>
Message-ID: <20130617190337.GR2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 03:53:14PM +0200, Linus Walleij wrote:
> On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> 
> > From: Alban Bedel <alban.bedel@avionic-design.de>
> >
> > There are more fields than just SWIDTH in CH_CONTROL register, so read
> > register value must be masked in addition to shifting.
> >
> > Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Are we just lucky on current variants such that all unmasked bits
> happen to be zero on them?

It's probably that all the places which this gets used, the transfers
are 8-bit (like the UART) so it "just works" irrespective of that.
