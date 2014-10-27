From: tthayer@opensource.altera.com (Thor Thayer)
Date: Mon, 27 Oct 2014 16:35:00 -0500
Subject: [PATCHv2 0/4] Add Altera peripheral memories to EDAC framework
In-Reply-To: <20141027204307.GB4741@pd.tnic>
References: <1413578029-13205-1-git-send-email-tthayer@opensource.altera.com>
 <544E93F0.3030409@opensource.altera.com> <20141027204307.GB4741@pd.tnic>
Message-ID: <544EBA84.7080109@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/27/2014 03:43 PM, Borislav Petkov wrote:
> On Mon, Oct 27, 2014 at 01:50:24PM -0500, Thor Thayer wrote:
>> Do you have any comments about this driver?
> Just a question: why do you have three .c files for something which
> does only error injection and nothing else AFAICT? Why isn't this part
> of altera_edac.c?
>
There are 2 files for doing the error injection (altera_l2_edac.c and 
altera_ocram_edac.c) and then 1 file for the irq handling and probe 
(altera_edac_mgr.c).

The L2 cache and the On-Chip RAM drivers were based on the Calxeda L2 
cache driver and when written as 2 separate files, the resulting code 
was very similar from the probe and error handling standpoint so the 
common code was combined (altera_edac_mgr.c).

The Memory Controller model was used for the SDRAM EDAC (altera_edac.c) 
since it matches the DIMM model.  The MC model didn't seem to fit the 
discrete memories like OCRAM and L2 cache (these files) so I used the 
EDAC device model which agreed with the Calxeda L2 cache driver.

Should I move the EDAC Device probe and error handling from 
altera_edac_mgr.c to altera_edac.c? Can I mix the MC and Device models 
in the same file?

Thanks for reviewing and for commenting.

Thor
