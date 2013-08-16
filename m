From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 16 Aug 2013 12:58:49 -0700
Subject: [PATCH RFC 1/3] spmi: Linux driver framework for SPMI
In-Reply-To: <20130816194714.GH4035@joshc.qualcomm.com>
References: <cover.1376596224.git.joshc@codeaurora.org>
 <02deef1d90121011ab1df90ad704ef0ee36e2584.1376596224.git.joshc@codeaurora.org>
 <20130816184614.GA31510@kroah.com>
 <20130816194714.GH4035@joshc.qualcomm.com>
Message-ID: <20130816195849.GA17974@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 02:47:15PM -0500, Josh Cartwright wrote:
> > > +#ifdef CONFIG_DEBUG_FS
> > 
> > Why?  If debugfs isn't enabled, the functions should just compile away
> > with the debugfs_() calls, so no need to do this type of thing here,
> > right?
> 
> Not sure I follow you, but it may be because this is a bit misleading.
> 
> Currently CONFIG_DEBUG_FS is being extended to also mean "do you want
> the SPMI core to create device entries?".  It would probably make more
> sense to have a CONFIG_SPMI_DEBUG option which is def_bool DEBUG_FS, as
> other busses have.
> 
> The #ifdef here would then be #ifdef CONFIG_SPMI_DEBUG, as well as in
> the Makefile:
> 
>   spmi-core-$(CONFIG_SPMI_DEBUG) += spmi-dbgfs.o

If debugfs is enabled why wouldn't you want debugfs entries for your
devices?  Don't assume a user is going to be able to rebuild their
kernel just for debugging stuff (hint, they usually aren't), so having
these present, if they don't cause any performance issues, is usually
best to always have around.

thanks,

greg k-h
