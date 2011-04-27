From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Apr 2011 16:06:08 +0100
Subject: [alsa-devel] [PATCH] ASoC: prevent compilers from optimising
	pll calculation into __aeabi__uldivmod
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0497F1AA8C@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0497F1AA8C@HQMAIL01.nvidia.com>
Message-ID: <20110427150607.GD31952@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 07:59:39AM -0700, Stephen Warren wrote:

> Aren't there compiler flags that tell gcc it isn't operating in a hosted(?)
> environment, and hence not to emit calls to these functions? If so, I
> imagine they should be added to the kernel's core (or ARM arch ) makefiles.

IIRC there's some intrinsics (usually for operations like divisions)
which GCC expects to be provided even in a free standing environment.
