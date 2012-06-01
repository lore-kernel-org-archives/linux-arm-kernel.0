From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jun 2012 11:55:50 +0100
Subject: [RFC 34/34] dmaengine: PL08x: ensure all descriptors are freed
 when channel is released
In-Reply-To: <CACRpkdawZm2J_4ujUv96-d0kDV0m7XOrr+wk8Wr92a3KLZcf2w@mail.gmail.com>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZJ0j-000717-M3@rmk-PC.arm.linux.org.uk>
 <CACRpkdawZm2J_4ujUv96-d0kDV0m7XOrr+wk8Wr92a3KLZcf2w@mail.gmail.com>
Message-ID: <20120601105550.GF21245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 09:27:55AM +0800, Linus Walleij wrote:
> On Tue, May 29, 2012 at 5:46 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > Ensure all queued descriptors are freed when the channel is released,
> > ensuring we don't leak memory
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Excellent series Russell, looking forward to a version that
> applies on top of v3.5-rc:s and I'll test it. Would be great to get
> this into the -next tree as soon as you think it's ripe.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Note that I have four additional patches on top of this which I didn't
post, which I've kept up to date - two of them add the Versatile and
Realview support, though I've kept them in a slightly messy state to
work around some of the brokenness on the hardware I've experienced
(mostly just commenting out various bits of the DMA data for various
drivers.)
