From: abelvesa@gmail.com (Abel Vesa)
Date: Thu, 9 Feb 2017 18:18:15 +0000
Subject: [PATCHv3] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <20170209180644.GJ27312@n2100.armlinux.org.uk>
References: <1486508275-18449-1-git-send-email-abelvesa@linux.com>
 <20170209162956.GH27312@n2100.armlinux.org.uk>
 <20170209121322.5229e6cf@gandalf.local.home>
 <20170209180644.GJ27312@n2100.armlinux.org.uk>
Message-ID: <20170209181815.GA3439@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 06:06:44PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 09, 2017 at 12:13:22PM -0500, Steven Rostedt wrote:
> > Then came along live kernel patching, which I believe this series is
> > trying to support. What is needed by pt_regs is a way to "hijack" the
> > function being called to instead call the patched function. That is,
> > ftrace is not being used for tracing, but in reality, being used to
> > modify the running kernel. It is being used to change what function
> > gets called. ftrace is just a hook for that mechanism.
> 
> So, would I be correct to assume that the only parts of pt_regs that
> would be touched are those which contain arguments to the function,
> and the register which would contain the return value?
At this point, yeah, but I intend to come up with another patch series
for livepatching which needs the exact same context as the function 
livepatched. This means all the regs need to be saved and restored 
before calling the replacing function.
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
