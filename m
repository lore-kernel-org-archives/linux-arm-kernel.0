From: stefanha@gmail.com (Stefan Hajnoczi)
Date: Thu, 24 Jan 2013 10:25:31 +0100
Subject: [Qemu-devel] [RFC] Virtio-desktop: Virtio-based virtual desktop
In-Reply-To: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
References: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
Message-ID: <20130124092531.GD18072@stefanha-thinkpad.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 11:40:24AM +0530, Anup Patel wrote:
> IMHO, If we have something like Virtio-desktop specification then all
> possible guest OSes can have support for it and different hypervisor can
> emulate it without worrying about guest support.

At this point x86 virtualization is mature and working with a mix of
emulated x86 architecture pieces and virtio devices for
performance-critical or open-ended functionality that we want to be able
to extend.

ARM is getting KVM and virtio-mmio support.  It will be in a similar
position soon.

Virtio guest drivers have not been implemented widely.  The Linux and
Windows efforts are driven by the folks who were behind virtio from the
start, but Solaris, FreeBSD, and others didn't really jump on the virtio
bandwagon.

Given this landscape, what is the advantage of doing a virtio-desktop?
It will still need to fall back on ARM or x86 which is already being
virtualized and emulated.

Depending on how you see it we either have virtio-desktop already or,
if not, I think the experience with virtio adoption suggests other
hypervisors and guest OSes will not trip over themselves to implement
virtio-desktop.

What's the advantage over virtualizating an existing ARM or x86 platform
and using virtio devices where appropriate?

Stefan
