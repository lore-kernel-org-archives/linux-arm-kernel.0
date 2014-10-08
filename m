From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Oct 2014 10:42:58 +0100
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <20141007134006.GC27464@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com>
 <1412370971.32313.30.camel@smoke>
 <20141007134006.GC27464@redhat.com>
Message-ID: <20141008094258.GG27216@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Cc'ing the arm efi guys]

On Tue, Oct 07, 2014 at 02:40:06PM +0100, Vivek Goyal wrote:
> On Fri, Oct 03, 2014 at 02:16:11PM -0700, Geoff Levand wrote:
> > Hi,
> > 
> > On Wed, 2014-10-01 at 11:19 -0400, Vivek Goyal wrote:
> > > On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
> > > > Hi All,
> > > > 
> > > > This series adds the core support for kexec re-boots on arm64.  I have tested
> > > > with the ARM VE fast model using various kernel config options for both the
> > > > first and second stage kernels.
> > > 
> > > Does this patch series work with kexec on UEFI machines?
> > 
> > I have not done much more than some simple re-boot tests using the
> > base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
> > but yes, it should work.
> 
> [CC Dave Young ]
> 
> I have not looked at the user space patches but are you preparing efi
> setup data and passing all the runtime map information to second kernel.
> 
> I am hoping on arm64 we have the CONFIG_EFI_RUNTIME_MAP=y and it works
> well.

>From a quick look at mainline that config option just gates exposing
that info under sysfs, and we never call efi_runtime_map_setup on arm64.
I gues the x86 kexec tool parses that and sets up some data structure?

For arm64 we have runtime map information in the initial DTB, and this
should have been copied into the DTB we pass to the second kernel. See
Documentation/arm/uefi.txt and drivers/firmware/efi/libstub/fdt.c.

Is that sufficient?

Mark.
