From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 16:32:33 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <56531F4F.9010100@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <8472808.1HUuK2O5nn@wuerfel> <56531F4F.9010100@codeaurora.org>
Message-ID: <105706554.vF12QZslMx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 November 2015 09:14:39 Christopher Covington wrote:
> On 11/23/2015 03:15 AM, Arnd Bergmann wrote:
> > On Sunday 22 November 2015 21:36:45 Nicolas Pitre wrote:
> >> On Sun, 22 Nov 2015, Arnd Bergmann wrote:
> > 
> > Ok, thanks a lot! So the reporting in /proc/cpuinfo clearly matches
> > the actual features, and we can just treat this as no LPAE / no IDIV
> > for kernel compilation, as nobody ever seems to use THUMB2_KERNEL
> > in practice.
> > 
> > PJ4-MP is like Cortex-A15/A7/A12/A17 and supports both IDIV and LPAE,
> > which leaves the question whether Scorpion or Krait do the same as
> > well, or whether they are outliers and need a special configuration.
> 
> LPAE is only supported in the Krait 450.
> 
> http://www.anandtech.com/show/7537/qualcomms-snapdragon-805-25ghz-128bit-memory-interface-d3d11class-graphics-more
> 
> I'm pretty sure idiv support came earlier, but I don't have the
> specifics on hand.

I have seen that article, but didn't trust it as a canonical
source of information here.

If you can confirm that it's right, that would mean that we
don't support LPAE on mach-qcom, as the only SoC with Krait 450
seems to be APQ8084, and mainline Linux doesn't run on that.

The ones we do support are MSM8x60 (Scorpion), MSM8960
(Krait-without-number),and MSM7874 (Krait 400). Do those all
support IDIV but not LPAE?

	Arnd
