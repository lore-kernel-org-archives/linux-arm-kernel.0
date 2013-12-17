From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Dec 2013 09:30:28 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Conditionally select MICREL_PHY
In-Reply-To: <52AEFF56.5010602@cogentembedded.com>
References: <1387153872-8387-1-git-send-email-horms+renesas@verge.net.au>
 <52AEFF56.5010602@cogentembedded.com>
Message-ID: <20131217003028.GE27171@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 05:25:42PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 16-12-2013 4:31, Simon Horman wrote:
> 
> >The koelsch board uses has an SH ethernet controller which uses a Micrel
> >phy. Select MICREL_PHY for koelsch if SH_ETH is enabled to make use of the
> >Micrel-specific phy driver rather than relying on the generic phy driver.
> 
>    Frankly speaking, I'm seeing no advantages to doing that.

I think there is an advantage to using the hardware-specific driver.
Even if it make any difference at run-time with the present code.

> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
>    Analogous changes are needed for BOCK-W and Lager boards since
> they all use the same KSZ8041RNLI PHY chip. I was going to submit
> such changes with the PHY IRQ patches but since no IRQ is generated
> still, this got delayed...

I believe that similar changes are needed for almost all
of the shmobile boards. If you would like to handle some or all
of them that is quite fine by me.
