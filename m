From: js@sig21.net (Johannes Stezenbach)
Date: Thu, 24 Mar 2016 11:56:51 +0100
Subject: dmaengine: ARM pl080 misidentified as Samsung pl080s
Message-ID: <20160324105651.GA20489@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

commit da1b6c05b8b5bd ("dmaengine: PL08x: Add support for PL080S variant")
added this hunk:

 static struct amba_id pl08x_ids[] = {
+       /* Samsung PL080S variant */
+       {
+               .id     = 0x0a141080,
+               .mask   = 0xffffffff,
+               .data   = &vendor_pl080s,
+       },
        /* PL080 */

However, 0x0a141080 happens to be the ID of the
ARM PL080, too:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0196g/I54627.html

Since the PL080S has the configuration register at a different
address the driver doesn't work for ARM PL080 anymore.


Johannes
