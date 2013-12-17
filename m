From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Dec 2013 09:31:07 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Conditionally select MICREL_PHY
In-Reply-To: <52AF8D57.7010705@cogentembedded.com>
References: <1387153872-8387-1-git-send-email-horms+renesas@verge.net.au>
 <52AEFF56.5010602@cogentembedded.com>
 <52AF8D57.7010705@cogentembedded.com>
Message-ID: <20131217003107.GF27171@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 02:31:35AM +0300, Sergei Shtylyov wrote:
> On 12/16/2013 04:25 PM, I wrote:
> 
> >>The koelsch board uses has an SH ethernet controller which uses a Micrel
> >>phy. Select MICREL_PHY for koelsch if SH_ETH is enabled to make use of the
> >>Micrel-specific phy driver rather than relying on the generic phy driver.
> 
> >    Frankly speaking, I'm seeing no advantages to doing that.
> 
>    Although wait, Geert has reported the absence of Rx FIFO overflow
> messages with this PHY driver, IIRC.
> 
> >>Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> >    Analogous changes are needed for BOCK-W and Lager boards since they all
> >use the same KSZ8041RNLI PHY chip. I was going to submit such changes with the
> >PHY IRQ patches but since no IRQ is generated still, this got delayed...
> 
>    Only I was going to do it via defconfigs...

That was my initial approach too. However I have been convinced
that Kconfig is a better way forwards.
