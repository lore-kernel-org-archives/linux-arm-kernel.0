From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 09:53:45 +0000
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
Message-ID: <20120223095345.GJ22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 02:47:40PM +0530, Viresh Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> There are some peripheral (e.g dwc otg) whose registers can be configured to
> work in either little or big endian mode. Therefore macros like out_be32,
> in_be32, out_le32 and in_le32 have been added to support such peripherals.

NAK.

1. Using the PCI/ISA IO macros for non-PCI/ISA IO purposes is silly
2. We should have readb_be() etc instead.
