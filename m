From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 7 Nov 2014 11:30:16 -0800
Subject: [PATCH v9 01/12] coresight: add CoreSight core layer framework
In-Reply-To: <1415038066-22423-2-git-send-email-mathieu.poirier@linaro.org>
References: <1415038066-22423-1-git-send-email-mathieu.poirier@linaro.org>
 <1415038066-22423-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20141107193016.GA29311@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 11:07:35AM -0700, mathieu.poirier at linaro.org wrote:
> From: Pratik Patel <pratikp@codeaurora.org>
> 
> CoreSight components are compliant with the ARM CoreSight
> architecture specification and can be connected in various
> topologies to suit a particular SoC tracing needs. These trace
> components can generally be classified as sources, links and
> sinks. Trace data produced by one or more sources flows through
> the intermediate links connecting the source to the currently
> selected sink.
> 
> The CoreSight framework provides an interface for the CoreSight trace
> drivers to register themselves with. It's intended to build up a
> topological view of the CoreSight components and configure the
> correct serie of components on user input via sysfs.
> 
> For eg., when enabling a source, the framework builds up a path
> consisting of all the components connecting the source to the
> currently selected sink(s) and enables all of them.
> 
> The framework also supports switching between available sinks
> and provides status information to user space applications
> through the debugfs interface.
> 
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

You don't seem to document the sysfs files you create here in
Documentation/ABI/ anywhere in the series.  Can you fix that up?

Other than that minor nit, this looks good to me.  Feel free to take it
through some random ARM tree.

thanks,

greg k-h
