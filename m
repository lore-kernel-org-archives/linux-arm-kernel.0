From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 17 Aug 2016 13:47:40 -0700
Subject: [PATCH 0/2] Fix Qualcomm 8064/8660 interrupt flags
In-Reply-To: <20160817194322.GB18215@hector.attlocal.net>
References: <1470386318-17694-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZR-R7cZkfpMJLOt8ND1bQmdxCuVF1BWEgeagWwfXAEDQ@mail.gmail.com>
 <20160817194322.GB18215@hector.attlocal.net>
Message-ID: <20160817204740.GQ26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 17 Aug 12:43 PDT 2016, Andy Gross wrote:

> On Wed, Aug 17, 2016 at 10:56:22AM +0200, Linus Walleij wrote:
> > On Fri, Aug 5, 2016 at 10:38 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > 
> > > This came out after some frustration with trying to flag a PM8058
> > > interrupt line on the APQ8060 (MSM8660) to trigger on falling
> > > edges. It was conflicting badly with predefined contradictory
> > > flags in the device tree for the entire GPIO block. The same
> > > seems to hold for the MPP GPIO IRQs.
> > 
> > Andy are you funneling these two patches for fixes?
> 
> I looked at these last night.  What's the outcome of John's issues with the
> patch not fixing his problem?  Do these need to be taken irrespective of his
> plight?
> 

John's issue was that the order of operations was changed in the IRQ
framework, so that upon passing through the set_type() in the TLMM
driver I would overwrite, and hence disable, the chained IRQ handler -
as I should.

As the PMIC interrupt is chained from the TLMM no interrupts was
delivered.


So please move forward with these changes.

Regards,
Bjorn
