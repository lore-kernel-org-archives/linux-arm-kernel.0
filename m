From: kpa_info@yahoo.fr (Patrick)
Date: Fri, 18 Dec 2009 09:00:15 +0000 (GMT)
Subject: [PXA320] dmac_flush_range and burst on SMEMC
Message-ID: <354684.99618.qm@web23301.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I am using a PXA320 with a FPGA connected on the VLIO memory bus. For faster transfer between the PXA and the FPGA I would like to use burst (supported by the SMEMC in VLIO).

I was using a 2.6.26 kernel and burst was working very fine. I was using ioremap_cached and after a loop of iowrite32 and a call to dmac_flush_range to start the burst. It was working fine.

I have migrated to a 2.6.28 kernel with the same driver code. All the data writed by the loop of iowrite32 is lost and only the last burst is writed using PIO and no burst. It's like if dmac_flush_range is not working and flush no cash at all.

Do you have any idea ? Should I use another function than dmac_flush_range ?

Thanks in advance for any help

Patrick


      
