From: bp@alien8.de (Borislav Petkov)
Date: Fri, 17 Jun 2016 19:02:53 +0200
Subject: [PATCHv3 2/7] EDAC, altera: Add panic flag check to A10 IRQ
In-Reply-To: <57642DE5.6060903@opensource.altera.com>
References: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
 <1465852752-11018-3-git-send-email-tthayer@opensource.altera.com>
 <20160617165131.GE3912@pd.tnic>
 <57642DE5.6060903@opensource.altera.com>
Message-ID: <20160617170253.GH3912@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 12:05:41PM -0500, Thor Thayer wrote:
> That is a good question. We have 2 important uses for OCRAM 1) to hold our
> power-down/sleep and resume functions and 2) to hold our FPGA contents
> during sleep. If either of these is corrupted, it is better to panic than to
> load something that would cause incorrect.
> 
> In the cases of the FIFOs such as Ethernet and USB, the plan is to add code
> to drop the packet so that we'll get a re-transmission. In that case, it is
> sort of recoverable.

Much better. Now put that explanation in the code please!

:-)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
