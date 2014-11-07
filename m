From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 7 Nov 2014 13:48:30 -0800
Subject: [PATCH v9 01/12] coresight: add CoreSight core layer framework
In-Reply-To: <CANLsYkzKB7iBUFxsqmaoHob26mEZvfbVSA1O_ZadFCYHE2viAA@mail.gmail.com>
References: <1415038066-22423-1-git-send-email-mathieu.poirier@linaro.org>
 <1415038066-22423-2-git-send-email-mathieu.poirier@linaro.org>
 <20141107193016.GA29311@kroah.com>
 <20141107193054.GB29311@kroah.com>
 <CANLsYkzKB7iBUFxsqmaoHob26mEZvfbVSA1O_ZadFCYHE2viAA@mail.gmail.com>
Message-ID: <20141107214830.GA1995@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 02:39:31PM -0700, Mathieu Poirier wrote:
> On 7 November 2014 12:30, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Nov 07, 2014 at 11:30:16AM -0800, Greg KH wrote:
> >> On Mon, Nov 03, 2014 at 11:07:35AM -0700, mathieu.poirier at linaro.org wrote:
> >> > From: Pratik Patel <pratikp@codeaurora.org>
> >> >
> >> > CoreSight components are compliant with the ARM CoreSight
> >> > architecture specification and can be connected in various
> >> > topologies to suit a particular SoC tracing needs. These trace
> >> > components can generally be classified as sources, links and
> >> > sinks. Trace data produced by one or more sources flows through
> >> > the intermediate links connecting the source to the currently
> >> > selected sink.
> >> >
> >> > The CoreSight framework provides an interface for the CoreSight trace
> >> > drivers to register themselves with. It's intended to build up a
> >> > topological view of the CoreSight components and configure the
> >> > correct serie of components on user input via sysfs.
> >> >
> >> > For eg., when enabling a source, the framework builds up a path
> >> > consisting of all the components connecting the source to the
> >> > currently selected sink(s) and enables all of them.
> >> >
> >> > The framework also supports switching between available sinks
> >> > and provides status information to user space applications
> >> > through the debugfs interface.
> >> >
> >> > Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> >> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>
> >> You don't seem to document the sysfs files you create here in
> >> Documentation/ABI/ anywhere in the series.  Can you fix that up?
> 
> Thanks for the review.   Do you want sysfs entries documented for the
> framework only or all the ones created by the drivers as well?

All need to be documented.

> >> Other than that minor nit, this looks good to me.  Feel free to take it
> >> through some random ARM tree.
> >
> > Wait, did you want me to take this through my tree?  If so, I'll be glad
> > to do so, I can't remember what we talked about here...
> 
> I was hoping to go through yours.

Ok, I can take it, can you send me a follow-on patch for the sysfs
files?

thanks,

greg k-h
