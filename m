From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Jan 2015 10:58:04 +0000
Subject: SPCR table parsing
In-Reply-To: <54B880B5.6010907@redhat.com>
References: <54B880B5.6010907@redhat.com>
Message-ID: <20150116105804.GF21809@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 03:08:37AM +0000, Jon Masters wrote:
> Hi Folks,
> 
> We're implementing support for SPCR table parsing shortly[0], since it
> will allow to deprecate supplying a "console=" (and eventually, also
> "earlycon=") on 64-bit ARM servers, where it's not always the case that
> we can assume a 16550 at a specific address. SPCR has been provided on
> x86 systems since 2000 but is not (yet) supported by Linux.

For anyone using DT rather than ACPI, the same can be achieved in
mainline with /chosen/stdout-path as of:

7914a7c5651a5161 "of: support passing console options with stdout-path"

Documented in:

2a9d832cc9aae21e "of: Add bindings for chosen node, stdout-path"

e.g.

uart: serial at f00 {
	reg = <0xf00 0x200>;
	compatible = "vendor,some-serial-device";
};

chosen {
	stdout-path = "/serial at f00:115200n8";
};

This will be used for both the console and earlycon. Please make use of
this where possible.

Thanks,
Mark.
