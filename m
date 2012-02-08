From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 8 Feb 2012 11:31:20 +0100
Subject: [PATCH v2 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <20120208091720.GI889@n2100.arm.linux.org.uk>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
 <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
 <4F31AB63.3020301@gmail.com>
 <20120208081508.GA6673@avionic-0098.mockup.avionic-design.de>
 <20120208091720.GI889@n2100.arm.linux.org.uk>
Message-ID: <20120208103119.GA17615@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux wrote:
> On Wed, Feb 08, 2012 at 09:15:08AM +0100, Thierry Reding wrote:
> > * Ryan Mallon wrote:
> > > On 07/02/12 02:19, Thierry Reding wrote:
> > > > The total maximum number of PWM devices is currently fixed to 64, but
> > > > can easily be made configurable via Kconfig.
> > > 
> > > It would be better to make the code handle arbitrary numbers of PWMs. A
> > > Kconfig knob becomes annoying when you have more than one platform
> > > configured into the kernel.
> > 
> > AFAICT handling an arbitrary number of PWMs will only be possible once we get
> > rid of the global namespace and therefore should be postponed for later. I
> > may be wrong, though, so if anybody can point me in the right direction I'm
> > perfectly happy to change that in this series.
> 
> One solution would be to look at how genirq handles this.  Eg, it uses a
> radix tree to store the irqdescs rather than an array, and a bitmap
> showing which global numbers are allocated.

That's exactly the solution implemented by this second version of the series.
In fact I did turn to genirq for inspiration at the time I wrote the code.
My understanding was that Ryan proposed to get rid of the bitmap altogether
because it arbitrarily limits the number of PWMs. How that can be achieved
with a global namespace I don't know. Thus my proposal to keep it as-is for
now and get rid of it once per-chip indexing is implemented.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120208/c61c04bf/attachment-0001.sig>
