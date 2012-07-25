From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Wed, 25 Jul 2012 13:04:07 +0530
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <201207250631.54157.arnd@arndb.de>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <50068030.1050905@st.com> <500F770C.9000005@st.com>
 <201207250631.54157.arnd@arndb.de>
Message-ID: <20120725073406.GM19660@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jul 25, 2012 at 06:31:53AM +0000, Arnd Bergmann wrote:
> Can you post here the complete set of callback implementations
> that you have in your development trees at the moment? That should
> help us determine which case we're talking about here.

There are following types of callbacks (involving SoC/platform) seen
generally in our case,

  * parent clk selection -
        driver is not aware about various clock sources (which also
        varies from platform to platform) and hence can only be
        programmed by corresponding platform.

        This is the case in Ethernet, audio, etc.

  * spi controller
        This is little hack in the h/w. As part of s/w controlled chip
        select/deselect in spi-pl022, we need to write to some system
        specific register.

  * OTG controller
        phy clock initialization which involves series of steps
        including powering down, etc.

  * NAND controller
        bank selection on runtime by writing to system registers

  * sata controller
        Similar to OTG case which involves clock initialization.

--
regards
Shiraz
