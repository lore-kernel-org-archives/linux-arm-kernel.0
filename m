From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 22 Nov 2011 10:09:29 -0800
Subject: [PATCH v3 0/5] common clk framework
In-Reply-To: <20111122174544.GA19739@n2100.arm.linux.org.uk>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <20111122154259.GA18954@kroah.com>
 <20111122174544.GA19739@n2100.arm.linux.org.uk>
Message-ID: <CAPtuhTgFPZA9U-8heNw1eNUnHLFv2w+LzXg5rdjSx3J53Xy+2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 9:45 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 22, 2011 at 07:42:59AM -0800, Greg KH wrote:
>> On Mon, Nov 21, 2011 at 05:40:42PM -0800, Mike Turquette wrote:
>> > ? .sysfs support. ?Visualize your clk tree at /sys/clk! ?Where would be
>> > a better place to put the clk tree besides the root of /sys/?
>>
>> Um, in the "proper" place for it under /sys/devices like the rest of the
>> device tree is?
>
> I'd suggest that making the clock tree visible in sysfs (and therefore
> part of the kernel ABI) is not a good idea. ?Some of the nodes in there
> will be specific to the implementation. ?Exposing the clock nodes means
> that if you have to change the clock tree structure, you change the
> visible userspace ABI.

It is true that the ABI will change dynamically.

>
> So, I'd suggest that we need to see a justification for this, rather
> than exposing this stuff via debugfs as has been done with existing
> implementations.

Userspace tools like powerdebug (and maybe someday powertop) hope to
use a reliable-looking interface to view clk data.  There are obvious
uses for this data in a debug tool, the most obvious of which is
"which clk isn't turning off when it should?".

I can migrate this stuff to debugfs, but it adds the burden of having
debugfs enabled for folks that want to view this data.  I would also
argue that sysfs is there to model various aspects of system topology
and a clk tree certainly fits the bill.

If others also agree that it should reside only in debugfs then I'll
move it there for V4.

Thanks,
Mike
