From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Mon, 24 Mar 2014 10:47:53 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <53300BF4.2000309@redhat.com>
References: <20140226183454.GA14639@cbox>
 <20140301152756.67A02C40238@trevor .secretlab.ca>
 <20140306085213.GU643@mal.justgohome.co.uk> <531843EE. 8040102@redhat.com>
 <53185FB9.1040308@redhat.com>
 <20140306120449.GA29916@ mal.justgohome.co.uk>
 <20140307122418.2F2C4C408EC@trevor.secretlab.ca>
 < 20140322010206.GF25519@cbox>
 <20140322122354.7644FC418C4@trevor.secretlab.ca>
 <1395651814.4052.6.camel@dagon.hellion.org.uk>
 <53300BF4.2000309@redhat.com>
Message-ID: <1395658073.19365.39.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-24 at 11:41 +0100, Paolo Bonzini wrote:
> Il 24/03/2014 10:03, Ian Campbell ha scritto:
> >> > That isn't actually my position. I absolutely think that VMs /should/
> >> > implement persistent variables, but the variables are a property of a VM
> >> > instance, not of the disk image. As far as this spec is concerned, I
> >> > think portable disk images should operate under the assumption of an
> >> > empty set of variables, and therefore follow the removable disk
> >> > requirements in the UEFI spec.
> > Just to be sure I understand. You position is:
> >      1. A VM image downloaded from www.distro.org should neither contain
> >         nor expect any persistent variables to be present.

I suppose for completeness I should have had 1a here:
        When a VM image is instantiated into a specific VM instance then
        it must not expect or require any persistent variables to be
        present.

> >      2. After a VM image is instantiated into a specific VM instance and
> >         booted then it is at liberty to set persistent variables (either
> >         on first boot or as part of an upgrade) and the VM should ensure
> >         that those variables a retained over reboot for that specific
> >         instance.
> >      3. If a VM does not preserve those variables then the instance
> >         should have some sane functional fallback (implied by the
> >         removable disk requirements from the UEFI spec).
> >
> > Is that right? I'm pretty sure you meant (1), reasonably sure you meant
> > (2) and not at all sure you meant (3) ;-)
> 
> At least I do. :)

You did mean it, or you do think Grant meant it? ;-)

Ian.
