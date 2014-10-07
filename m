From: vgoyal@redhat.com (Vivek Goyal)
Date: Tue, 7 Oct 2014 09:43:20 -0400
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <1412290795.32313.14.camel@smoke>
References: <cover.1411604443.git.geoff@infradead.org>
 <20140930202904.GB24153@redhat.com>
 <1412112476.6630.56.camel@smoke>
 <20141002190836.GA26882@redhat.com>
 <1412290795.32313.14.camel@smoke>
Message-ID: <20141007134320.GD27464@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 03:59:55PM -0700, Geoff Levand wrote:
> Hi Vivek,
> 
> On Thu, 2014-10-02 at 15:08 -0400, Vivek Goyal wrote:
> > On Tue, Sep 30, 2014 at 02:27:56PM -0700, Geoff Levand wrote:
> > > For a running system you can check the device tree:
> > > 
> > >   cat /proc/device-tree/cpus/cpu\@0/enable-method | hexdump -C
> > > 
> > 
> > So system I have supports spin-table method for cpu bringup. How do I 
> > test your patches with that system. Are there any patches on your
> > spin-table branch which can make it working?
> 
> If possible, check if there is a firmware update that supports PSCI.
> 
> My spin-table patches are now out of date, and fixing those up is
> now low priority.

So psci method for cpu bring up is more popular as comapred to 
spin-table one? 

> 
> I modified kexec-tools to only issue a message, but accept a device
> tree that does not have the new cpu-return-addr property that is
> needed for kexec on spin-table systems.  Since the spin-table stuff
> is only for managing secondary CPUs, this change should allow you to
> test kexec with a 1st stage kernel built with CONFIG_SMP=n.
> 
> Since the secondary CPUs will have never left the spin-table, you
> should be able to kexec re-boot into an SMP kernel, but you will
> not be able to do a successful kexec re-boot from there.

Ok, I can compile kernel with CONFIG_SMP=y but use maxcpus=1 for first
kernel and hopefully that works.

Thanks
Vivek
