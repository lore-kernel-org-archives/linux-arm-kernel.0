From: geoff@infradead.org (Geoff Levand)
Date: Thu, 02 Oct 2014 15:59:55 -0700
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <20141002190836.GA26882@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20140930202904.GB24153@redhat.com> <1412112476.6630.56.camel@smoke>
 <20141002190836.GA26882@redhat.com>
Message-ID: <1412290795.32313.14.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Thu, 2014-10-02 at 15:08 -0400, Vivek Goyal wrote:
> On Tue, Sep 30, 2014 at 02:27:56PM -0700, Geoff Levand wrote:
> > For a running system you can check the device tree:
> > 
> >   cat /proc/device-tree/cpus/cpu\@0/enable-method | hexdump -C
> > 
> 
> So system I have supports spin-table method for cpu bringup. How do I 
> test your patches with that system. Are there any patches on your
> spin-table branch which can make it working?

If possible, check if there is a firmware update that supports PSCI.

My spin-table patches are now out of date, and fixing those up is
now low priority.

I modified kexec-tools to only issue a message, but accept a device
tree that does not have the new cpu-return-addr property that is
needed for kexec on spin-table systems.  Since the spin-table stuff
is only for managing secondary CPUs, this change should allow you to
test kexec with a 1st stage kernel built with CONFIG_SMP=n.

Since the secondary CPUs will have never left the spin-table, you
should be able to kexec re-boot into an SMP kernel, but you will
not be able to do a successful kexec re-boot from there.

-Geoff
