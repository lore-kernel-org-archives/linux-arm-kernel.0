From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 24 Mar 2014 11:46:13 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140324095723.GJ23363@mal.justgohome.co.uk>
References: <20140301152756.67A02C40238@trevor.secretlab.ca>
 <20140306085213.GU643@mal.justgohome.co.uk> <531843EE.8040102@redhat.com>
 <53185FB9.1040308@redhat.com> <20140306120449.GA29916@mal.justgohome.co.uk>
 <20140307122418.2F2C4C408EC@trevor.secretlab.ca>
 <20140322010206.GF25519@cbox> <532D4505.1090603@redhat.com>
 <20140323031952.GB30885@cbox> <20140323032939.GD30885@cbox>
 <20140324095723.GJ23363@mal.justgohome.co.uk>
Message-ID: <53300CF5.5090808@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 24/03/2014 10:57, Robie Basak ha scritto:
>> > After thinking about this a bit more, I think I see what we're actually
>> > discussing.  It's obvious that if software in a VM makes changes to UEFI
>> > variables that are required to be persistent for that VM image to boot
>> > again, then the VM image is no longer portable, as per the spec.
> No longer portable, and given the current state of implementation, no
> longer bootable, since we don't support persistent storage yet;
> certainly not on OpenStack? Or do we have that now?
>
> Are we really pushing ahead with a specification that nobody can
> implement today? How far away are we from a fully compliant
> implementation?

The spec says SHOULD, so I think it's fine.  While support for 
persistent variables in the KVM stack is in the early stages, there is 
request and it is not ARM-specific.  It will be implemented sooner 
rather than later at least at the libvirt level, and I suppose qemu-arm, 
xl, OpenStack/, Virt, XenServer and everything else will follow soon.

Paolo
