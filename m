From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Mon, 2 Nov 2015 13:13:34 -0500
Subject: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
In-Reply-To: <20151102091253.GS4058@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446150450-22093-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151030175656.GF4058@x1> <20151030200812.GB8666@localhost>
 <20151102091253.GS4058@x1>
Message-ID: <20151102181334.GA7200@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 09:12:53AM +0000, Lee Jones wrote:
> [Cc'ing Arnd]
> 
> On Fri, 30 Oct 2015, Damien Riegel wrote:
> > On Fri, Oct 30, 2015 at 05:56:56PM +0000, Lee Jones wrote:
> > > On Thu, 29 Oct 2015, Damien Riegel wrote:
> > > 
> > > > Driver for TS-4800 syscon. These registers belong to a FPGA that is
> > > > memory mapped and are used for counters, enable various IPs in the FPGA,
> > > > control LEDs, control IOs, etc.
> > > > 
> > > > Currently, only the watchdog is handled.
> > > 
> > > Why do you require your own syscon driver?
> > > 
> > > What's wrong with the generic one?
> > > 
> > 
> > The generic one uses a regmap_config with reg_stride set to 4 and val_bits
> > to 32.
> > 
> > TS-4800 syscon registers are 16-bit wide and must be accessed with 16
> > bit read and writes:
> > http://wiki.embeddedarm.com/wiki/TS-4800#Syscon
> > 
> > I will address the other issues in the next version (split commit,
> > license issue, style, and superfluous remove).
> 
> The Syscon driver was written to be generic so that each
> vendor/platform didn't require their own incarnation.  How unique is
> the TS-4800?
> 
> Perhaps it might be better to supply a generic 16 bit Syscon for
> devices akin to the TS-4800?

The TS-4800 syscon could use a generic 16-bit syscon. There is nothing
specific that requires a driver besides that.

We could add some optional properties to the generic syscon node to
configure reg_bits, val_bits, and reg_stride (and pad_bits ?). Would
that be a good solution ?

> Arnd, any opinion on this?
> 
