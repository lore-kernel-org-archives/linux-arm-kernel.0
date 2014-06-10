From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jun 2014 21:21:12 +0200
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <5397360B.80102@huawei.com>
References: <20140328184517.GA27219@cbox> <5397360B.80102@huawei.com>
Message-ID: <9128476.SiMN0btvWc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 June 2014 18:44:59 Claudio Fontana wrote:
> I just wanted to share with you guys how we are using virtualization
> on ARM64 over here for the OSv project.
> By skipping steps like UEFI, grub, firmware load, etc we strive to
> keep our application launch time low.
> Is this going to create problems for us in the future if you start
> requiring every VM to boot using those instead?

My feeling is that it's out of scope for this specification.
What you are doing is great, and you should keep doing it that way.

It does mean that your applications are aware of which hypervisor
they are running on, and you have to manage them using OSv specific
tools on the host.

The VM System Specification however is meant to provide a way to
distribute a file system image for a virtual machine that can run
on any compliant hypervisor using any compliant management tools.
The reason it goes through all the boot loader steps is to make it
much closer to a real system, so distros don't have to special-case
this.

If you don't care about that, you can just install the tools on
the host to manage your OSv application without a boot loader.
In particular, you can support multiple targets on OSv: e.g.
native Xen, native KVM, and portable standard hypervisor following
the ARM VM System Spec.

	Arnd
