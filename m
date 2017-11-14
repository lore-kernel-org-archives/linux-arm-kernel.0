From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 14 Nov 2017 18:33:02 +0100
Subject: [PATCH v3 4/4] net: nb8800: Add support for suspend/resume
In-Reply-To: <83c8a08a-f369-0bd0-67dd-6c6678ce5ef0@sigmadesigns.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <ae0d528a-d602-f399-9d75-65bf9bbf1264@sigmadesigns.com>
 <yw1xshdh109j.fsf@mansr.com>
 <80649328-8d2a-0a6f-a025-6a6c4de62d7e@sigmadesigns.com>
 <20171114163159.GX30830@lunn.ch>
 <83c8a08a-f369-0bd0-67dd-6c6678ce5ef0@sigmadesigns.com>
Message-ID: <20171114173302.GY30830@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 06:08:47PM +0100, Marc Gonzalez wrote:
> On 14/11/2017 17:31, Andrew Lunn wrote:
> 
> > On Tue, Nov 14, 2017 at 03:22:04PM +0100, Marc Gonzalez wrote:
> > 
> >> On 14/11/2017 14:02, M?ns Rullg?rd wrote:
> >>
> >>> Missing patch description.  Don't bother though.  I won't approve of
> >>> this implementation.
> >>
> >> I hope I can convince David that you should not have veto power over
> >> this driver just because it was you who submitted it upstream first.
> > 
> > In practice, anybody can request a veto on a patch. If a patch
> > introduces a regression, and somebody reports it, that is pretty much
> > an automatic veto.
> > 
> > Please work with Mans to ensure you are not breaking the driver for
> > the hardware he cares about.
> 
> FWIW, removing generic support ("aurora,nb8800") does not break any existing hardware.

Hi Marc

I also did a quick search, and no board appears to use this, at the
moment.

But it does appear that the changes to the pause configuration while
the DMA is running will break stuff. So there appears to be a
legitimate reason for that patch to get a NACK.

	   Andrew
