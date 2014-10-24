From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 24 Oct 2014 12:08:26 +0000
Subject: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <3236720.MHeqOodrCV@wuerfel>
References: <1413374436-14410-1-git-send-email-sthokal@xilinx.com>
 <4301925.4pMHXMXqA4@wuerfel>
 <ff137744d6474640aab09e5d6f62921a@BN1AFFO11FD019.protection.gbl>
 <3236720.MHeqOodrCV@wuerfel>
Message-ID: <7dc11ef7ccec49bcb052c30b9aa916c3@BL2FFO11FD044.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

-----Original Message-----
From: Arnd Bergmann [mailto:arnd at arndb.de]
Sent: Tuesday, October 21, 2014 2:45 PM
To: linux-arm-kernel at lists.infradead.org
Cc: Appana Durga Kedareswara Rao; devicetree at vger.kernel.org; vinod.koul at intel.com; Srikanth Vemula; linux-kernel at vger.kernel.org; Srikanth Thokala; dmaengine at vger.kernel.org; robh+dt at kernel.org; Michal Simek; Anirudha Sarangi; grant.likely at linaro.org; dan.j.williams at intel.com
Subject: Re: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine driver support

On Tuesday 21 October 2014 09:06:13 Appana Durga Kedareswara Rao wrote:
> The above mentioned API's  and structures will be used by the dma test
> client driver's to set hardware configuration information. The dma
> client drivers are not mainlined  yet and it is Internally used by
> our git-tree  to test the DMA functionality in loopback .

I would suggest you add the test driver into the main dmaengine driver file directly then, so you don't need to export the symbols. If there are important reasons to keep that as separate files, just move the header to the drivers/dma/ directory and add the test driver there.

        Arnd

Sorry I forgot to mention the below things in the mail .The Config API's and structures not only used by the dmaengine driver's but also used by the  various IP's  (Ex: Ethernet driver and SRIO driver these drivers are under development).For example the Ethernet driver is resides under drivers/net/ethernet but it needs to set some specific configuration parameters of the dma that's why created a separate header file for the h/w configurable parameters.


Regards,
Kedar.


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
