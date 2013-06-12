From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 12 Jun 2013 18:11:34 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <2722548.PBMM2Yn19A@linux-5eaq.site>
References: <Pine.LNX.4.44L0.1306111431170.1392-100000@iolanthe.rowland.org>
 <2722548.PBMM2Yn19A@linux-5eaq.site>
Message-ID: <CACVXFVMQGqGNcKntLbpQSJN+mkVZoRTRNYZ+TMVSmnGwK7BiBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 5:11 PM, Oliver Neukum <oliver@neukum.org> wrote:
> On Tuesday 11 June 2013 15:10:03 Alan Stern wrote:
>> In order to prevent this from happening, you would have to change the
>> spin_lock() call in the completion handler to spin_lock_irqsave().
>> Furthermore, you will have to audit every USB driver to make sure that
>> all the completion handlers get fixed.
>
> Yes. However, it can be done mechanically. And we know only
> the handlers for complete need to be fixed.

I am wondering if the change is needed since timer function is still
run in softirq context instead of hard irq.

Looks Alan concerned that one USB interface driver may have another
hard interrupt handler involved. Is there such kind of USB driver/device
in tree?

Thanks,
--
Ming
