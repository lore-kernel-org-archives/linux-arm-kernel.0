From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 19 Apr 2012 03:33:03 -0600 (MDT)
Subject: [PATCH 12/12] ARM: OMAP2xxx: hwmod data: start to fix the IVA1,
 IVA2 and DSP
In-Reply-To: <20120419092823.GW25053@n2100.arm.linux.org.uk>
References: <20120308023614.8205.78768.stgit@dusk>
 <20120308023840.8205.51532.stgit@dusk>
 <alpine.DEB.2.00.1204190317030.29048@utopia.booyaka.com>
 <20120419092823.GW25053@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1204190331560.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Apr 2012, Russell King - ARM Linux wrote:

> FYI, I'm also seeing omap_hwmod errors on boot:
> 
> 3430ldp: http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=133
> omap_hwmod: i2c1: softreset failed (waited 10000 usec)
> omap_hwmod: i2c2: softreset failed (waited 10000 usec)
> omap_hwmod: i2c3: softreset failed (waited 10000 usec)
> 
> 4430sdp: http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=134
> omap_hwmod: i2c1: softreset failed (waited 10000 usec)
> omap_hwmod: i2c2: softreset failed (waited 10000 usec)
> omap_hwmod: i2c3: softreset failed (waited 10000 usec)
> omap_hwmod: i2c4: softreset failed (waited 10000 usec)
> omap_hwmod: ipu: failed to hardreset

Thanks for the report.  Those should be resolved by:

ARM: OMAP2+: hwmod: Revert "ARM: OMAP2+: hwmod: Make omap_hwmod_softreset 
wait for reset status"

which was sent upstream to Tony as part of

http://git.kernel.org/?p=linux/kernel/git/pjw/omap-pending.git;a=commit;h=3c55c1baffa5f719eb2ae9729088bc867f972f53

Hopefully it will go into the next v3.4-rc kernel.


- Paul
