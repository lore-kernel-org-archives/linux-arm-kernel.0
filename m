From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Feb 2014 11:19:27 -0700
Subject: [RFC/PATCH 0/3] Add devicetree scanning for randomness
In-Reply-To: <20140217155419.682F7C401D4@trevor.secretlab.ca>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
 <201402121251.06280.arnd@arndb.de>
 <20140212174554.GM27395@titan.lakedaemon.net>
 <20140212182000.GJ5554@obsidianresearch.com>
 <20140217155419.682F7C401D4@trevor.secretlab.ca>
Message-ID: <20140218181927.GE29304@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 03:54:19PM +0000, Grant Likely wrote:

> I applied a patch that did exactly that (109b623629), and then reverted
> it (b920ecc82) shortly thereafter because add_device_randomness() is
> a rather slow function and FDTs can get large. I'd like to see someone
> do a reasonable analysis on the cost of using an FDT for randomness
> before I reapply a patch doing something similar. An awful lot of the
> FDT data is not very random, but there are certainly portions of it that
> are appropriate for the random pool.

I read through the original thread from Tim Bird and FWIW I agree with
the assessment that passing the FDT through MD5 first is a good
approach.

Thinking into the future, I'd expect to see similar variable data in
DT on servers as we see in DMI, including:
  - Vendor serial number for the HW, manufacturing date, model number,
    and HW UUID
  - Serial numbers and vendor part numbers for DIMMS
  - MAC addresses for all the ethernet
  - OEM specific data

At worst a 'choosen/linux,no-dt-random = 1' value in the DT to disable
it would solve the problem for those in embedded that care about
microseconds during booting.

Regards,
Jason
