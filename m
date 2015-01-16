From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 16:53:33 +0100
Subject: [Linaro-acpi] [PATCH v7 00/17] Introduce ACPI for ARM64 based on
 ACPI 5.1
In-Reply-To: <20150116154913.GW7091@arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1809831.d9GPSfLUEN@wuerfel> <20150116154913.GW7091@arm.com>
Message-ID: <1887263.kzglbjcc0t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 January 2015 15:49:13 Will Deacon wrote:
> 
> The on-board ethernet on Seattle requires the driver to program its AXI
> attributes, so configuring it to be a coherent master actually means
> "program the same cacheable AXI settings as you have on the CPU". That
> sounds like Linux should be doing it to me, but even if the firmware takes
> a guess at "normal cacheable WBRWA", it's not clear to me whether that
> register persists across things like adapter reset.
> 
> Tom?
> 
> There's also the situation where the firmware hasn't initialised the
> register and Linux realises this during probe. What should it do then?

In case of a 10gbit ethernet adapter, there really should be no question
regarding whether to set it coherent or not. Can't Linux just always
set this AXI attribute in the driver?

	Arnd
