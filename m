From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 25 Apr 2014 07:33:24 +0200
Subject: [PATCH] ARM: imx6q: work around faulty PMU irq routing
In-Reply-To: <CAOMZO5DjiZnOHL9t3GeqSGu7=zU5ajKSs4__aVBRM0eHdHa3JA@mail.gmail.com>
References: <1398371029-21176-1-git-send-email-l.stach@pengutronix.de>
 <CAOMZO5DjiZnOHL9t3GeqSGu7=zU5ajKSs4__aVBRM0eHdHa3JA@mail.gmail.com>
Message-ID: <5359F3A4.2060307@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.04.2014 22:32, Fabio Estevam wrote:
> On Thu, Apr 24, 2014 at 5:23 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
>> The i.MX6 PMU has a design errata where the interrupts of all cores are
>> wired together into a single irq line. To work around this we have to
>
> Is there an erratum reference number for this, please?

First, many thanks to Lucas for working on this! Up to now, it was my 
impression that the PMU on i.MX6 is completely useless for !single core 
SoCs. So maybe there is some hope, now :)

Regarding the erratum: To my knowledge there is no erratum. In 2013 I've 
had a discussion with the FSL support about this and got the answer:

-- cut --
This is the IC design issue, we have OR'ed the interrupt pin of the four 
PMU and provide one interrupt to the CPU. currently, we don't have the 
SW workaround available for it.
-- cut --

This is just what has been called as "braindead, broken system" in

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/113802.html

Best regards

Dirk
