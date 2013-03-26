From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 17:58:20 +0100
Subject: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
In-Reply-To: <20130326163421.GA30255@obsidianresearch.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364314719-1049-11-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326163421.GA30255@obsidianresearch.com>
Message-ID: <20130326175820.78c9b3c7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 26 Mar 2013 10:34:21 -0600, Jason Gunthorpe wrote:
> On Tue, Mar 26, 2013 at 05:18:32PM +0100, Thomas Petazzoni wrote:
> 
> > +		pcie-controller {
> > +			compatible = "marvell,armada-370-pcie";
> > +			status = "disabled";
> > +			device_type = "pci";
> > +
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +
> > +			bus-range = <0x00 0xff>;
> > +
> > +			reg = <0xd0040000 0x2000>, <0xd0080000 0x2000>;
> > +
> > +			reg-names = "pcie0.0", "pcie1.0";
> > +
> > +			ranges = <0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
> > +			          0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */
> > +
> > +			pcie at 1,0 {
> > +				device_type = "pci";
> > +				reg = <0x0800 0 0 0 0>;
> > +				#address-cells = <3>;
> > +				#size-cells = <2>;
> 
> Very Minor Nit: These two # fields are not strictly necessary

Ok. I'll wait to see if there are more comments on this patch set,
especially on deciding between reg = <...> or assigned-addresses, and
I'll repost an updated version.

> This basically looks fine to me, however, I think it is valuable if
> you and Thierry could use the same method to pass per-port registers. I
> expect others are going to reference these bindings for future work,
> and one standard method is more clear than two.
> 
> Thierry: Did you settle on using assigned-addresses? Can you share the
> final binding for your driver?
> 
> Jingoo Han's driver for Exynos uses lots of per-port registers, so I'm
> inclined to think that assigned-addresses is the clearer way forward.
> 
> This is a fairly minor comment. Would people be comfortable going in as-is
> with a small follow-up revision to the DT?

I'm fine reworking the driver in one way or another. I really don't
care much about how the registers addresses are represented in the DT,
as long as it gets the job done. So, let's wait for Thierry's opinion
so we can align our DT bindings.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
