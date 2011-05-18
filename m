From: vbendeb@google.com (=?UTF-8?B?VmFkaW0gQmVuZGVidXJ5ICjQstCxKQ==?=)
Date: Wed, 18 May 2011 13:59:22 -0700
Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate operation
	in thumb mode.
In-Reply-To: <20110516144311.GC7715@arm.com>
References: <20110513195316.9AD0940CD1@eskimo.mtv.corp.google.com>
	<BANLkTikhRuk2ZfYjriTcP7oFdbr7h1oP5g@mail.gmail.com>
	<20110514100232.GC30539@n2100.arm.linux.org.uk>
	<20110516121657.GA7715@arm.com>
	<alpine.LFD.2.00.1105161008320.14430@xanadu.home>
	<20110516144311.GC7715@arm.com>
Message-ID: <BANLkTik0LL+dFCo_H-YhF+BUOXyP7MAKzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 7:43 AM, Dave Martin <dave.martin@linaro.org> wrote:
> On Mon, May 16, 2011 at 10:32:16AM -0400, Nicolas Pitre wrote:
>> On Mon, 16 May 2011, Dave Martin wrote:
>>
>> > On Sat, May 14, 2011 at 11:02:32AM +0100, Russell King - ARM Linux wrote:
>> > > On Sat, May 14, 2011 at 10:59:14AM +0100, Catalin Marinas wrote:
>> > > > On 13 May 2011 20:53, Vadim Bendebury <vbendeb@google.com> wrote:
>> > > > > This is a cosmetic change, adding a '_thumb' prefix to the
>> > > > > 'Hardware' line in /proc/cpuinfo. Tested as follows:
>> > > > >
>> > > > > localhost ~ # dmesg | grep thumb
>> > > > > [ ? ?0.000000] Machine: kaen_thumb
>> > > > > localhost ~ # grep '^Hardware' /proc/cpuinfo
>> > > > > Hardware ? ? ? ?: kaen_thumb
>> > > > > localhost ~ #
>> > > >
>> > > > Would this break any script parsing this file?
>> > > >
>> > > > BTW, why do you need it? You could include the .config into the kernel
>> > > > and read it via /proc.
>> > >
>> > > Whether the kernel is built T2 or ARM doesn't change the userland API
>> > > either, so there's no real need for userland to know how the kernel
>> > > was built.
>> > >
>> > > The only thing which is affected by it are kernel modules, but then we
>> > > have an established way to sort out incompatible kernel modules already.
>> >
>> > One corollary to that is that _if_ there's any reason why userland needs to
>> > know what instruction set the kernel was built with, then we're probably
>> > doing something wrong somewhere...
>> >
>> > In any case, shoehorning this information into the hardware platform name
>> > seems a bit strange since this is really nothing to do with the hardware.
>> >
>> > Vadim, can you explain why you think this information is needed? ?If the
>> > need is real, perhaps there's a better way to address it.
>>
>> I think this can be useful to know how the kernel was compiled for bug
>> tracking purposes, just like we record the Git commit ID of the checked
>> out source tree, the gcc version, the build date, etc. ?Which pretty
>> much indicates that the thumbness of the kernel should probably be
>> stored in the kernel banner not the platform name.
>
> That seems a reasonable approach to me.
>

guys, thank you for your comments. Indeed, this is meant to be just a
convenience to allow to quickly tell what kind of kernel a system is
running, comes handy when there are many systems around with
differently compiled kernels.

So, would it be acceptable if I move this information into the kernel
banner (namely, add it to the machine hardware name part of the output
included in 'uname -m' and 'uname -a')?

cheers,
/vb




> ---Dave
>
