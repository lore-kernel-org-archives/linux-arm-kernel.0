From: tytso@mit.edu (Theodore Y. Ts'o)
Date: Mon, 27 Aug 2018 10:53:52 -0400
Subject: [PATCH 0/4] arm64: wire CRC32 instructions into core crc32
 routines
In-Reply-To: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
Message-ID: <20180827145352.GF2311@thunk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 01:02:41PM +0200, Ard Biesheuvel wrote:
> While this is not known to cause performance issues, calling a table based
> time variant implementation with a non-negligible D-cache footprint (8 KB)
> is wasteful in any case, and now that the crc32 instructions have been made
> mandatory in the architecture, let's wire them up into the core crc routines.

Stupid question --- are there any arm64 SOC's out there which do *not*
have the crc32 instructions?  Presumably there won't be in the future,
because it's now mandatory --- but where there any in the past?

	     	 	       	   	 - Ted
