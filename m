From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 May 2018 20:44:22 +0100
Subject: [PATCH 2/4] pid: Export find_task_by_vpid for use in external
 modules
In-Reply-To: <CANLsYkwaNmZCUjwJXK0X1ia+RnzumfbpB8EvZJ-HDtOHj8rafQ@mail.gmail.com>
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
 <87d0y5toed.fsf@xmission.com> <20180509152505.GA25559@xps15>
 <87k1scs0f8.fsf@xmission.com>
 <20180510084057.GT16141@n2100.armlinux.org.uk>
 <CANLsYkwaNmZCUjwJXK0X1ia+RnzumfbpB8EvZJ-HDtOHj8rafQ@mail.gmail.com>
Message-ID: <20180510194422.GX16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 01:39:18PM -0600, Mathieu Poirier wrote:
> Hi Russell,
> 
> On 10 May 2018 at 02:40, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> > This does not leak information from other namespaces because of the
> > uniqueness of the global PID.  However, what it does leak is the value
> > of the global PID which is meaningless in the namespace.  So, before
> > the event stream is delivered to userspace, this value needs to be
> > re-written to the namespace's PID value.
> 
> Unfortunately that can't be done.  The trace stream is compressed and
> needs to be decompressed using an external library.  I think the only
> option is to return an error if a user is trying to use this feature
> from a namespace.

That sounds like a sensible approach, and that should get rid of the
vpid stuff too.

Eric, would this solve all your concerns?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
