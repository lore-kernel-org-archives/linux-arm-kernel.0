From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 26 Mar 2013 10:45:05 -0600
Subject: mvebu: Device bus driver resurrection
In-Reply-To: <20130326124337.GD2454@localhost>
References: <20130326124337.GD2454@localhost>
Message-ID: <20130326164505.GB30255@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 09:43:38AM -0300, Ezequiel Garcia wrote:
> Hello everyone,
> 
> Now that we've all agreed on a mvebu mbus driver (or a first version of it)
> I'd like to resurrect the Device Bus driver.
> 
> As far as I can remember, the last things said about this driver were:
> 
>   * The timing parameters should be in {nano,pico,etc} seconds,
>     instead of ticks.

Yes, and I saw Rob Herring note that the DT parameters in cases like
that should end in -ps
 
>   * Although not everyone agreed, this driver was a good thing to have
>     so we no longer depend on the bootloader setting these parameters.

Please make the timing parameters mandatory, not optional. If boot
loader set timing is going to be used then this driver should not be
involved. Otherwise the timing should be fully specified and no values
from the bootloader should be retained.

>   * The address decoding windows should *not* be setup by this driver,
>     but rather be described in the device tree itself.

I'm going to suggest you send out a quick DT sample for what you are
thinking, that might save lots of effort?

Jason
