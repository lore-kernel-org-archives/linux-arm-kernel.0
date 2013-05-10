From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 10 May 2013 10:03:24 -0700
Subject: [PATCH -v8 01/11] CPU hotplug: Provide a generic helper to
 disable/enable CPU hotplug
In-Reply-To: <1651579.orCh9JNVz6@vostro.rjw.lan>
References: <1367937595-32241-1-git-send-email-holt@sgi.com>
 <1367937595-32241-2-git-send-email-holt@sgi.com>
 <20130509150121.8c3ef60b2fc748ce542a1a52@linux-foundation.org>
 <1651579.orCh9JNVz6@vostro.rjw.lan>
Message-ID: <20130510100324.e1e066ab.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 May 2013 13:11:51 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> ...
>
> > cpu_hotplug_disable() doesn't get compiled unless we've defined
> > CONFIG_PM_SLEEP_SMP.  I cannot begin to imagine what the logic is
> > behind that!
> 
> I suppose it was only used by suspend/hibernate code paths when this was
> introduced.

OK, well I suspect that what I have now is simply wrong for Robin's
application.  Robin, can you please check this?  We probably want to
make the does-something version of cpu_hotplug_disable/enable available
if CONFIG_HOTPLUG_CPU.
