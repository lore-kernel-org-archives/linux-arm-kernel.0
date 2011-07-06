From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 13:10:26 +0100
Subject: [PATCH 2/3] ARM: CSR: mapping early DEBUG_LL uart
In-Reply-To: <CAGsJ_4xRxWXL=xPRgkaLMFxpBtr-bP6xV9iD1UomfzyKmHhSJA@mail.gmail.com>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-3-git-send-email-bs14@csr.com>
	<20110706110522.GQ8286@n2100.arm.linux.org.uk>
	<CAGsJ_4xRxWXL=xPRgkaLMFxpBtr-bP6xV9iD1UomfzyKmHhSJA@mail.gmail.com>
Message-ID: <20110706121026.GT8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 07:53:14PM +0800, Barry Song wrote:
> hi Russell,
> 
> 2011/7/6 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Wed, Jul 06, 2011 at 02:47:57AM -0700, Barry Song wrote:
> >> Signed-off-by: Barry Song <bs14@csr.com>
> >
> > Surely this should be part of the first patch, which won't build without
> > this one if DEBUG_LL is enabled?
> 
> i guess that can get fixed by:
> 
> static void __init sirfsoc_map_io(void)
> {
>         sirfsoc_map_lluart();
> }
> 
> MACHINE_START(PRIMA2_EVB, "prima2cb")
>       ...
>        .map_io         = sirfsoc_map_io,
>       ...
> MACHINE_END

That doesn't really change anything.  If you build the first patch without
the second patch with DEBUG_LL enabled, you'll get a build failure because
sirfsoc_map_lluart is not defined.

Either omit the .map_io initializer in the first patch and add it in the
second patch, or combine the two patches together.
