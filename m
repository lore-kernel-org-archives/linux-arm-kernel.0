From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2011 11:03:00 +0200
Subject: [PATCH V7 02/17] SPEAr13xx: Add PCIe host controller base driver
	support.
In-Reply-To: <4DB7BD41.50108@st.com>
References: <cover.1298977728.git.viresh.kumar@st.com>
	<201104172219.01493.arnd@arndb.de> <4DB7BD41.50108@st.com>
Message-ID: <201104271103.00284.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2011, Pratyush Anand wrote:
> > I would suggest in general to make the code as generic as easily possible
> > and put it into an appropriate location for sharing, but not spending
> 
> Our next SOC has new revision of Synopsys PCIe Controller, which has more
> generic application interface registers. I am planning to divide code for
> this new SOC, so that it would be easily usable if someone has same controller.
> What could be the best location for shared code?
 
Traditionally, that would be arch/arm/common.

Since we are now in the process of increasingly moving drivers into the
drivers/*/ directory, we could also discuss starting a new
drivers/pci/hosts/ directory and moving some of the existing host
controllers from arch/arm over there.

	Arnd
