From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 6 Mar 2015 10:40:45 +0800
Subject: parent/child hierarchy for regulator
In-Reply-To: <54F849AE.6040104@i2se.com>
References: <20150305103534.GA19600@shlinux2> <54F849AE.6040104@i2se.com>
Message-ID: <20150306024043.GA12879@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 01:18:54PM +0100, Stefan Wahren wrote:
> Hi Peter,
> 
> Am 05.03.2015 um 11:35 schrieb Peter Chen:
> > Hi lists,
> >
> > Any good ways at code/dts to show parent/child hierarchy for regulator?
> >
> > The related regulators at my platforms like below:
> > PMIC (SWB 5v) --> Switch Chip (GPIO Regulator) --> USB VBUS
> >
> > PMIC has one 5V regulator (eg, swbst at pfuse), and it is the input
> > for USB power switch chip, and there are two gpios at this switch
> > chip to control if 5V is output or not, we register these two gpios as 
> > fixed regulators, currently, if regulator swbst is disabled, the
> > gpio regulator has no way to know, and cause the vbus voltage is wrong.
> >
> > Thanks in advance.
> >
> 
> i don't have an answer to your question, but do you think of i.MX28
> platform?
> 

No, many Freescale i.mx6 SDB boards need to consider this problem.
-- 

Best Regards,
Peter Chen
