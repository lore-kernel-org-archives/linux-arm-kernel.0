From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Jan 2013 15:57:57 +0000
Subject: [RFC PATCH v3 2/2] ARM: OMAP4: setup SoC model name during ID
 initialisation
In-Reply-To: <1359558091-29251-3-git-send-email-ruslan.bilovol@ti.com>
References: <1359558091-29251-1-git-send-email-ruslan.bilovol@ti.com>
 <1359558091-29251-3-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <20130130155757.GK2637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 05:01:31PM +0200, Ruslan Bilovol wrote:
> Set up the SoC model name during OMAP ID initialisation
> so it will be displayed in /proc/cpuinfo:
> 
> / # cat proc/cpuinfo
> [...]
> CPU variant     : 0x2
> CPU part        : 0xc09
> CPU revision    : 10
> 
> SoC name        : OMAP4470

Hmm.  Still not happy.  Wasn't there some SoC infrastructure added to the
kernel to export this kind of information via sysfs?  See:

Documentation/ABI/testing/sysfs-devices-soc
