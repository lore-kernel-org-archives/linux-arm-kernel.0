From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 6 Aug 2012 14:30:48 -0500
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <20120806190856.GA1120@n2100.arm.linux.org.uk>
References: <20120803090452.GE2626@pengutronix.de>
 <20120803114532.GB26925@mudshark.cambridge.arm.com>
 <20120805095528.GO2626@pengutronix.de>
 <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
 <CAKGA1b=Pxif=4qSvK-Odmunbm_T6LjWP_CXid_v2VNmpuyHLDA@mail.gmail.com>
 <20120806190856.GA1120@n2100.arm.linux.org.uk>
Message-ID: <CAKGA1b=Np8+RMwgQEzwxdJcL6AjC4qiv1Jyq0bTTa_dHCeLokA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 2:08 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 06, 2012 at 01:40:26PM -0500, Matt Sealey wrote:
>> Maybe we could implement a shiny new zImage magic value, I'm not sure
>> if 0x016f2818 might have some sentimental value, but there's nothing
>> to say that 0x016f2819 wouldn't also be valid and indicate that it's
>> an ARM zImage with a Thumb2 entrypoint?
>
> No.  That magic value is a bloody pain in the backside from my point
> of view.  I've had soo many problems with it with boot loaders its
> untrue.

[snip]

> Instead, lets not continue this broken idea.  Instead, let's be able
> to _tell_ the boot loader what we want it to do, rather than have it
> magically decipher what _it_ thinks might be a good idea to do.

Okay, so how about we just append an ELF header to the front of the
image so the entry point, and the architecture, instruction
set, ABI etc. is well defined in an industry standard manner?

e_entry would then have the LSB set which indicates the entry is
Thumb.. or not :)

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
