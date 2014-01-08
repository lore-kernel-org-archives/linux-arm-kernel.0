From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jan 2014 11:08:33 +0100
Subject: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot
 dts node.
In-Reply-To: <20140108100549.GE6701@e106331-lin.cambridge.arm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <1389135041-16062-2-git-send-email-fkan@apm.com>
 <20140108100549.GE6701@e106331-lin.cambridge.arm.com>
Message-ID: <6073715.cGydpIHKD1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014 10:05:50 Mark Rutland wrote:
> > +
> > +Example:
> > +
> > +     reboot at 0 {
> > +             compatible = "apm,xgene-reboot";
> > +             reg = <0x0 0x17000014 0x0 0x4>;
> > +     };
> 
> Given this seems to be a 64-bit address, the unit address should
> preferably be 0,17000014 rather than just 0.

I also wonder about the size and location of the register.
Are you sure the device is just a single 4-byte register at offset
0x14, rather than a complex device that happens to contain the
reset register?

	Arnd
