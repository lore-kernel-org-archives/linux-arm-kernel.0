From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Jan 2014 13:05:10 +0100
Subject: [Patch v3 2/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <20140128113242.GJ10628@intel.com>
References: <1390890471-14882-1-git-send-email-agross@codeaurora.org>
 <20140128111756.GE15937@n2100.arm.linux.org.uk>
 <20140128113242.GJ10628@intel.com>
Message-ID: <4916428.f0GtxdkWKj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 January 2014 17:02:42 Vinod Koul wrote:
> On Tue, Jan 28, 2014 at 11:17:57AM +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 28, 2014 at 10:16:53AM +0100, Arnd Bergmann wrote:
> > > On Tuesday 28 January 2014 10:05:35 Lars-Peter Clausen wrote:
> > > > Why does the direction needs to be specified in specifier? I see two
> > > > options, either the direction per is fixed in hardware. In that case the DMA
> > > > controller node should describe which channel is which direction. Or the
> > > > direction is not fixed in hardware and can be changed at runtime in which
> > > > case it should be set on a per descriptor basis.
> > > 
> > > Normally the direction is implied by dmaengine_slave_config().
> > 
> > No.  The direction argument in there is deprecated - we've been talking
> > about removing it for some time.
> > 
> > DMA engine drivers should store all parameters of the configuration, and
> > then select the appropriate ones when preparing a transfer (which itself
> > involves a direction.)
> 
> Right all the prep_ calls for slave cases have explcit direction argument so
> sending it using slave config makes no sense. So will remove it after the merge
> window closes and fix 

Ok, thanks for clearing up my mistake. However, the argument remains:
the direction doesn't need to be in the DT DMA descriptor since it
gets set by software anyway.

	Arnd
