From: Iwo.Mergler@netcommwireless.com (Iwo Mergler)
Date: Mon, 29 Sep 2014 11:22:11 +1000
Subject: [PATCH] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <20140911143616.3ebb025a@bbrezillon>
References: <1410339339-25561-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140911120928.GA1585@localhost.localdomain>,
 <20140911143616.3ebb025a@bbrezillon>
Message-ID: <EACD232272DA4849B060F0828564D13B44955ABD82@ntcex01.corp.netcomm.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Sep 2014 22:36:16 +1000
Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:
> 
> Well, I don't know about freescale specific tools, but at least I have
> an example with mtd_nandbiterrs module.
> This module is assuming it can write only the data part of a NAND page
> without modifying the OOB area (see [1]), which in GPMI controller
> case is impossible because raw write function store the data as if
> there were no specific scheme, while there is one:
> (metadata + n x (data_chunk + ECC bytes) + remaining_bytes).
> 

Hi Boris,


just as an aside, only the incremental bit errors test in nandbiterrs
positively requires raw data write.

The overwrite test (re-write the same page data repeatedly without
erase), only uses raw access because I was lazy. A normal ECC write
would do just as well.


Best regards,

Iwo

______________________________________________________________________
This communication contains information which may be confidential or privileged. The information is intended solely for the use of the individual or entity named above.  If you are not the intended recipient, be aware that any disclosure, copying, distribution or use of the contents of this information is prohibited.  If you have received this communication in error, please notify me by telephone immediately.
______________________________________________________________________
