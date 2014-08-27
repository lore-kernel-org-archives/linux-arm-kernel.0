From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Aug 2014 10:36:16 +0100
Subject: imx6 eSATA
In-Reply-To: <CAL8zT=iVVmkT36idmkPFX7PxM7P3A489ThZqirqP3dZNkgmYTQ@mail.gmail.com>
References: <20140118184427.GJ15937@n2100.arm.linux.org.uk>
 <CAL8zT=iVVmkT36idmkPFX7PxM7P3A489ThZqirqP3dZNkgmYTQ@mail.gmail.com>
Message-ID: <20140827093616.GY30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 11:11:15AM +0200, Jean-Michel Hautbois wrote:
> Hi Russel,
> 
> 2014-01-18 19:44 GMT+01:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > So, I see we have AHCI support for SATA on the iMX6.  Great... but it
> > doesn't work on the cubox-i, because the phy settings are wrong.
> >
> > The Cubox-i requires GPR13 set to 0x0593A044 - I haven't decoded what
> > this means yet, but it's different from the 0x0593E4A4 which is
> > currently hard-coded into the driver (and I've independently tested
> > that this is indeed required.)
> 
> Pardon me if this is a naive question, but how do you know which value
> is required for a specific board ?

It's not something that one just knows.  The register defines the
electrical characteristics of the port, which is dependent on the
PCB layout of the platform.

The SATA spec includes requirements for the signal properties at the
connector, and the values in this register need to be adjusted to
meet the specification.

The problem that this presents for open source software folk is that
they generally do not have the expensive equipment to be able to
perform this validation, so one must rely on someone who does
(hopefully the platform manufacturer has done that.)  The alternative
is to look at the register definition, and adjust each property until
you get something which works - though the likelyhood of that method
working for a wide range of SATA devices is pretty small, especially
as there will be some interdependence between the various properties.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
