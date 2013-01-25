From: stefanha@gmail.com (Stefan Hajnoczi)
Date: Fri, 25 Jan 2013 08:46:23 +0100
Subject: [Qemu-devel] [RFC] Virtio-desktop: Virtio-based virtual desktop
In-Reply-To: <CALrVBksLFyq5Vb+oLtASrdgU6x=GxXCEFy_ZWmvSosDOU6CsiQ@mail.gmail.com>
References: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
 <20130124092531.GD18072@stefanha-thinkpad.redhat.com>
 <CALrVBksLFyq5Vb+oLtASrdgU6x=GxXCEFy_ZWmvSosDOU6CsiQ@mail.gmail.com>
Message-ID: <CAJSP0QUvhvSwv1M8ciakqJTkfn4dNeDLbPK5N4oM4WDBRz498g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 2:08 PM, Anup Patel <anup.patel@linaro.org> wrote:
> On 24 January 2013 14:55, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> On Thu, Jan 24, 2013 at 11:40:24AM +0530, Anup Patel wrote:
>> > IMHO, If we have something like Virtio-desktop specification then all
>> > possible guest OSes can have support for it and different hypervisor can
>> > emulate it without worrying about guest support.
>>
>> At this point x86 virtualization is mature and working with a mix of
>> emulated x86 architecture pieces and virtio devices for
>> performance-critical or open-ended functionality that we want to be able
>> to extend.
>>
>> ARM is getting KVM and virtio-mmio support.  It will be in a similar
>> position soon.
>>
>> Virtio guest drivers have not been implemented widely.  The Linux and
>> Windows efforts are driven by the folks who were behind virtio from the
>> start, but Solaris, FreeBSD, and others didn't really jump on the virtio
>> bandwagon.
>
> [Anup] I think other OSes will be motivated to added Virtio drivers if there
> exists some think like Virtio-desktop specification that is being emulated
> by
> many hypervisors.

Absolutely, if most hypervisors implement it then guests will also
implement it.  But this is exactly what I tried to describe in the
previous email:

Yes, virtio has the potential to be implemented by many hypervisors.
The specification is out there and existing open source
implementations are out there.

But the leading x86 hypervisors (kvm, xen, vmware, hyperv) implement
their own paravirt I/O approaches.  This may be due to historical
reasons but virtio has been around long enough for any of the other
big hypervisors to implement it if they wanted to.

Code sharing or a unified standard isn't sufficient motivation when
there are other factors like ability to change device spec to achieve
better performance, compatibility with existing guests, ability to add
new features, certified device drivers, etc.

The incentives need to be favorable for hypervisors to wed themselves
to a standardized paravirt device - simply adding more virtio devices
doesn't change today's incentives, so you cannot expect hypervisor
vendors to act differently from how they have in the past.

Stefan
