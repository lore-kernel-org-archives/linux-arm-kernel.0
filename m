From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Jan 2013 12:53:16 +0100
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename
 =?UTF-8?Q?KVM=5FSET=5FDEVI?= =?UTF-8?Q?CE=5FADDRESS?=
In-Reply-To: <CAFEAcA87t5VP5TCUjtNHDPHM=uPSXirNSD5=GWgwZaHF-wOo6A@mail.gmail.com>
References: <1357769438.18196.5@snotra>
 <97E481BC-F14D-4866-B44B-878833CA81DC@suse.de>
 <CAFEAcA87t5VP5TCUjtNHDPHM=uPSXirNSD5=GWgwZaHF-wOo6A@mail.gmail.com>
Message-ID: <f1c3b1a5c2261578b5112e69af8c5180@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jan 2013 10:17:09 +0000, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 9 January 2013 22:30, Alexander Graf <agraf@suse.de> wrote:
>> In fact, in this particular case one could merge all of the patches
>> except for the
>> particular ioctl implementation and just give the respective addresses
>> default
>> values until there is an API to set them, similar to how we did things
>> with PVR
>> in the beginning.
> 
> That's what we started with and we got review comments saying "yuck,
> don't hard code this"...

Even worse: hard-coding things breaks kvmtool (we do not emulate a
vexpress and have a rather different memory map) and arm64 (the
requirements on GIC mappings are different).

So hard coding addresses is already unacceptable.

        M.
-- 
Fast, cheap, reliable. Pick two.
