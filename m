From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Thu, 14 Feb 2013 08:52:06 +0000
Subject: [PATCH RFC] davinci: poll for sleep completion in resume routine.
In-Reply-To: <511C8B3F.6010200@ti.com>
References: <1359624393-5898-1-git-send-email-manishv.b@ti.com>
 <511C65B3.7060109@ti.com>
 <A4887BF146CD57468F700B415D2F470158374E@DBDE01.ent.ti.com>
 <511C8B3F.6010200@ti.com>
Message-ID: <A4887BF146CD57468F700B415D2F47015837B5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Thu, Feb 14, 2013 at 12:29:11, Nori, Sekhar wrote:
> On 2/14/2013 10:46 AM, Vishwanathrao Badarkhe, Manish wrote:
> > Hi Sekhar,
> > 
> > On Thu, Feb 14, 2013 at 09:48:59, Nori, Sekhar wrote:
> >> Manish,
> >>
> >> On 1/31/2013 2:56 PM, Vishwanathrao Badarkhe, Manish wrote:
> >>> As per OMAP-L138 TRM, Software must poll for SLEEPCOMPLETE bit until 
> >>> it is set to 1 before clearing SLEEPENABLE bit in DEEPSLEEP register 
> >>> in resume routine.
> >>> Modifications are as per datasheet:
> >>> http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
> >>> See sections 10.10.2.2 and 11.5.21 for more detailed explanation.
> >>
> >> Polling for SLEEPCOMPLETE is not required in RTC controlled wake-up which is the mode currently supported (see section 10.10.2.1 of the TRM). Polling for SLEEPCOMPLETE is required for external controlled wake-up which to my knowledge has never been tested. If you have tested this with external controlled wakep-up, then I can consider this patch.
> >> Else, I would like to take it only after externally controlled wake-up is fully tested/supported instead of taking bits and pieces.
> > 
> > Yes, for RTC controlled wakeup, this polling is not required as per section 10.10.2.1.
> > But if we see in section 10.10.2.2 (Exiting Deep Sleep Mode) step 2, 
> > When sleep count completes SLEEPCOMPLETE bit gets sets in DEEPSLEEP 
> > register till that it's not safe to release clock to devices. So If we 
> > don?t poll for SLEEPCOMPLETE, this delay will not come into picture 
> > which we actually set while entering deep sleep in case of RTC controlled wakeup (Section 10.10.2.1 step 9).
> > Please let me know, whether these understanding is correct?
> 
> The  delay is coming from hardware. Till SLEEPCOUNT completes, the clock to device is not provided. There is no need to poll for SLEEPCOMPLETE and indeed 10.10.2.2 does not ask for this bit to be polled.

Thanks for your explanation.
Ok, I will test this patch with external controlled wakeup and update you.

Regards, 
Manish Badarkhe
