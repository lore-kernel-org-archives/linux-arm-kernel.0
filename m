From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2012 09:17:20 +0000
Subject: [PATCH v2 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <20120208081508.GA6673@avionic-0098.mockup.avionic-design.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
 <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
 <4F31AB63.3020301@gmail.com>
 <20120208081508.GA6673@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120208091720.GI889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 09:15:08AM +0100, Thierry Reding wrote:
> * Ryan Mallon wrote:
> > On 07/02/12 02:19, Thierry Reding wrote:
> > > The total maximum number of PWM devices is currently fixed to 64, but
> > > can easily be made configurable via Kconfig.
> > 
> > It would be better to make the code handle arbitrary numbers of PWMs. A
> > Kconfig knob becomes annoying when you have more than one platform
> > configured into the kernel.
> 
> AFAICT handling an arbitrary number of PWMs will only be possible once we get
> rid of the global namespace and therefore should be postponed for later. I
> may be wrong, though, so if anybody can point me in the right direction I'm
> perfectly happy to change that in this series.

One solution would be to look at how genirq handles this.  Eg, it uses a
radix tree to store the irqdescs rather than an array, and a bitmap
showing which global numbers are allocated.
