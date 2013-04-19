From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Apr 2013 08:36:14 -0700
Subject: [PATCH] gpio/omap: ensure gpio context is initialised
In-Reply-To: <51715772.9020003@ti.com>
References: <1366230707-32681-1-git-send-email-jon-hunter@ti.com>
 <871ua734mv.fsf@linaro.org> <51707D7C.1050600@ti.com>
 <5170911C.6010507@ti.com> <51709499.8030208@ti.com>
 <5170E4EE.7090100@ti.com> <87sj2mzkcf.fsf@linaro.org>
 <51715772.9020003@ti.com>
Message-ID: <20130419153614.GF10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130419 07:43]:
> On Friday 19 April 2013 07:35 PM, Kevin Hilman wrote:
> > Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> > 
> >> On Friday 19 April 2013 06:19 AM, Jon Hunter wrote:
> >>>
> >>> On 04/18/2013 07:34 PM, Jon Hunter wrote:
> >>>>
> >>>> On 04/18/2013 06:10 PM, Jon Hunter wrote:
> >>>>> On 04/18/2013 04:34 PM, Kevin Hilman wrote:
> >>>>
> >>>> ...
> >>>>
> >>>>>> Why not just init context right here if bank->loses_context &&
> >>>>>> !bank->context_valid?
> >>>>
> >>>> I really like this idea a lot. It can really clean-up the code
> >>>> and really make it much more readable. Before we were playing 
> >>>> some tricks with when we init'ed the get_context_loss_count()
> >>>> function pointer. How about the below?
> >>>>
> >>>> Tony, care to re-test?

Still works thanks:

Tested-by: Tony Lindgren <tony@atomide.com>

> > Assuming this driver could become a module someday (not terribly likely,
> > I know), but context_valid would have meaning for each module reload.
> > 
> I don't think GPIO can ever be a module(at least on OMAP) considering the way
> it is used in many SOCs and hence the objection on that flag. GPIO is really
> an infrastructure driver which is needed to be always available for the
> client drivers to work. 

Not really related to this fix.. But when booting with initramfs, we should
be able to make everything into loadable modules except things that are related
to enabling timers and interrupts. This is important for distros to be able
do generic kernels. Surely for mounting non-initramfs root GPIO is most
likely needed though :)

Regards,

Tony
