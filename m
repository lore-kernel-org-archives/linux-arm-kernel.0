From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Nov 2015 14:45:22 +0000
Subject: [PATCH v6 1/6] arm/arm64: add smccc
In-Reply-To: <20151102140313.GG2684@leverpostej>
References: <1446106888-8983-1-git-send-email-jens.wiklander@linaro.org>
 <1446106888-8983-2-git-send-email-jens.wiklander@linaro.org>
 <20151102115119.GB29657@arm.com> <20151102135633.GA17559@ermac>
 <20151102140313.GG2684@leverpostej>
Message-ID: <20151102144521.GG29657@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 02:03:13PM +0000, Mark Rutland wrote:
> > > > +/**
> > > > + * struct smccc_res - Result from SMC/HVC call
> > > > + * @a0-a3 result values from registers 0 to 3
> > > > + */
> > > > +struct smccc_res {
> > > > +	unsigned long a0;
> > > > +	unsigned long a1;
> > > > +	unsigned long a2;
> > > > +	unsigned long a3;
> > > > +};
> > > 
> > > Are there any endianness considerations for this structure?
> > 
> > No, I can't find anything in the ARM SMC Calling Convention document
> > indicating that.
> 
> The calling conventions have no bearing on the structure, which is our
> invention.
> 
> We stash register values (which don't have endianness) returned by the
> firmeware into the structure in the sequences above (which appear
> endian-clean to me).

Ah yes, the structure is populated by the kernel not the firmware, so
there's nothing to worry about. Thanks for the explanation.

Will
