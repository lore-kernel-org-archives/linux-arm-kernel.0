From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 21:17:17 +0000
Subject: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations for
 Armada 370
In-Reply-To: <20130326211234.GA1295@avionic-0098.mockup.avionic-design.de>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303262050.12847.arnd@arndb.de>
 <20130326211234.GA1295@avionic-0098.mockup.avionic-design.de>
Message-ID: <201303262117.17478.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Thierry Reding wrote:
> On Tue, Mar 26, 2013 at 08:50:12PM +0000, Arnd Bergmann wrote:
> > On Tuesday 26 March 2013, Thierry Reding wrote:
> > >                 pci at 1,0 {
> > >                         device_type = "pci";
> > >                         assigned-addresses = <0x82000800 0 0x80000000 0 0x1000>;
> > >                         reg = <0x000800 0 0 0 0>;
> > >                         status = "disabled";
> > > 
> > >                         #address-cells = <3>;
> > >                         #size-cells = <2>;
> > > 
> > >                         nvidia,num-lanes = <2>;
> > >                 };
> > 
> > Shouldn't there be an empty ranges property in there as well?
> 
> Technically yes, I think. Though it doesn't make a bit of a difference
> on Linux.

Only because we have a workaround for old Power Macintoshs that we should
remove or at least disable on non-PowerPC systems.

	Arnd
