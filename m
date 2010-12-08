From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 8 Dec 2010 17:39:51 +0000
Subject: [RFC PATCH 06/13] picoxcell: add support for system clks
In-Reply-To: <20101208161807.GN9777@n2100.arm.linux.org.uk>
References: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
	<1290506774-17895-7-git-send-email-jamie@jamieiles.com>
	<20101208161807.GN9777@n2100.arm.linux.org.uk>
Message-ID: <20101208173951.GH2716@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 04:18:07PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 23, 2010 at 10:06:07AM +0000, Jamie Iles wrote:
> > The different picoXcell device variants have different numbers of clocks
> > and different capabilities (PC3X2 doesn't have any gateable or
> > controllable clocks). Add the infrastructure necessary for device
> > variants to provide their own clock implementation.
> 
> Fro the looks of this, you only allow one lookup per clk?  That's
> rather sub-optimal, and could cause you problems in the future when
> you may want to have aliases to cater for differences in the SoC
> clock layout.

Hmm, I hadn't thought of that. The number of clocks in our chips appears 
to be rapidly multiplying so that seems like a very good idea.

I guess for PC3X2 where we don't have any gateable or controllable 
clocks that means I can create one virtual clock then add a number of 
aliases where drivers require a struct clk.

Thanks,

Jamie
