From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 8 Dec 2017 07:45:40 -0800
Subject: [PATCH net-next v4 0/2] net: thunderx: add support for PTP clock
In-Reply-To: <20171208103442.19354-1-aleksey.makarov@cavium.com>
References: <20171208103442.19354-1-aleksey.makarov@cavium.com>
Message-ID: <20171208154540.ulmwofskhmwcczyd@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 01:34:38PM +0300, Aleksey Makarov wrote:
> This series adds support for IEEE 1588 Precision Time Protocol
> to Cavium ethernet driver.
> 
> The first patch adds support for the Precision Time Protocol Clocks and
> Timestamping coprocessor (PTP) found on Cavium processors.
> It registers a new PTP clock in the PTP core and provides functions
> to use the counter in BGX, TNS, GTI, and NIC blocks.
> 
> The second patch introduces support for the PTP protocol to the
> Cavium ThunderX ethernet driver.
> 
> v4:
> - use IS_ENABLED. This fixes compilation of the ptp as a module (David Miller)
> - select PTP_1588_CLOCK, not depend on it.  This fixes a build warning.

It should be "imply" not "select".

Thanks,
Richard
