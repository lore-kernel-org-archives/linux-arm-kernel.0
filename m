From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 7 Feb 2012 01:23:05 +0200
Subject: [PATCH v2 8/8] ARM: tegra: support for secondary cores on Tegra30
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178E124AA5@HQMAIL01.nvidia.com>
References: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
 <1328028051-24271-9-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178E124AA5@HQMAIL01.nvidia.com>
Message-ID: <20120206232305.GV24948@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 07:04:12PM +0100, Stephen Warren wrote:
> Peter De Schrijver wrote at Tuesday, January 31, 2012 9:41 AM:
> > Add support for bringing up secondary cores on Tegra30. On Tegra30 secondary
> > CPU cores are powergated, so we need to turn on the domains before we can bring
> > the CPU cores online. Bringing secondary cores online happens early during the
> > sytem boot, so we call powergating initialization from platform early_init
> > function.
> > 
> > Based on work by:
> > 
> > Scott Williams <scwilliams@nvidia.com>
> > Colin Cross <ccross@android.com>
> > Alex Frid <afrid@nvidia.com>
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> The series,
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> This time, since I now have the SD card working, I managed to test real
> user-space processes running on all 4 cores.
> 
> Note, patch 3 shouldn't compile due to a typo in a .size directive. It
> does for me, so I could test this! But, it didn't for Olof. Aside from
> that (which perhaps Olof would fixup during patch application?),

Indeed. The .size symbol is never used though, which might explain why it
compiled for you and me. I will leave it out in th enext version.

Cheers,

Peter.
