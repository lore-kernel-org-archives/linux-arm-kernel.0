From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 17 Sep 2014 12:00:48 -0700
Subject: [PATCH v4 04/11] drivers: base: support cpu cache information
 interface to userspace via sysfs
In-Reply-To: <5419C3F6.4050607@arm.com>
References: <1409763617-17074-1-git-send-email-sudeep.holla@arm.com>
 <1409763617-17074-5-git-send-email-sudeep.holla@arm.com>
 <5419C3F6.4050607@arm.com>
Message-ID: <20140917190048.GA4063@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 06:25:10PM +0100, Sudeep Holla wrote:
> Hi Greg,
> 
> On 03/09/14 18:00, Sudeep Holla wrote:
> >From: Sudeep Holla <sudeep.holla@arm.com>
> >
> >This patch adds initial support for providing processor cache information
> >to userspace through sysfs interface. This is based on already existing
> >implementations(x86, ia64, s390 and powerpc) and hence the interface is
> >intended to be fully compatible.
> >
> >The main purpose of this generic support is to avoid further code
> >duplication to support new architectures and also to unify all the existing
> >different implementations.
> >
> >This implementation maintains the hierarchy of cache objects which reflects
> >the system's cache topology. Cache devices are instantiated as needed as
> >CPUs come online. The cache information is replicated per-cpu even if they are
> >shared. A per-cpu array of cache information maintained is used mainly for
> >sysfs-related book keeping.
> >
> >It also implements the shared_cpu_map attribute, which is essential for
> >enabling both kernel and user-space to discover the system's overall cache
> >topology.
> >
> >This patch also add the missing ABI documentation for the cacheinfo sysfs
> >interface already, which is well defined and widely used.
> >
> 
> Can you review the first 4 patches in this series please ?

It's in my todo queue, which is really long at the moment due to me
going to conferences (at one right now...)  Will be working on this
soon, thanks for your patience.

greg k-h
