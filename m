From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Nov 2013 18:48:25 +0000
Subject: [PATCH V5 2/2] arm64: perf: add support for percpu pmu interrupt
In-Reply-To: <CAPrCYkfThbf4GoPrWB=CrnY6SfnaksxiDwqgqevYXdnrH-ynjg@mail.gmail.com>
References: <1385372753-7396-1-git-send-email-vkale@apm.com>
 <1385372753-7396-3-git-send-email-vkale@apm.com>
 <20131125184159.GE28201@mudshark.cambridge.arm.com>
 <CAPrCYkfThbf4GoPrWB=CrnY6SfnaksxiDwqgqevYXdnrH-ynjg@mail.gmail.com>
Message-ID: <20131129184824.GA6730@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 08:44:24AM +0000, Vinayak Kale wrote:
> On Tue, Nov 26, 2013 at 12:11 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Nov 25, 2013 at 09:45:53AM +0000, Vinayak Kale wrote:
> >> +static void
> >> +armpmu_enable_percpu_irq(void *data)
> >> +{
> >> +     struct arm_pmu *armpmu = data;
> >> +     struct platform_device *pmu_device = armpmu->plat_device;
> >> +     int irq = platform_get_irq(pmu_device, 0);
> >> +
> >> +     enable_percpu_irq(irq, 0);
> >
> > IRQ_TYPE_NONE?
> 
> Did you mean to use macro instead or 0? If yes, I will modify.

Yes.

Will
