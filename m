From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Mon, 13 Sep 2010 13:58:14 +0200
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <20100913101533.GB30787@n2100.arm.linux.org.uk>
References: <4C8DD588.7040009@endruntechnologies.com>	<201009131043.48688.marek.vasut@gmail.com>	<AANLkTimti4ajAOR0_aZ8aeGu9PN4a0MX8dbpg6dpZJYf@mail.gmail.com>	<20100913101039.GC2614@kw.sim.vm.gnt>
	<20100913101533.GB30787@n2100.arm.linux.org.uk>
Message-ID: <4C8E11D6.4050402@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux a ?crit :
> On Mon, Sep 13, 2010 at 10:10:39AM +0000, Simon Guinot wrote:
>> On Mon, Sep 13, 2010 at 05:56:30PM +0800, Haojian Zhuang wrote:
>>> On Mon, Sep 13, 2010 at 4:43 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> Cheers
>>> If initramfs is built in, we'll get a huge kernel. Even using LZMA, my
>>> kernel size is near 5MB.
>> The initramfs is located at the end of the init section and before the
>> text section. Because the kernel must be able to 'branch' between the
>> init and text sections, the initramfs size can't be greater than the
>> 'branch' maximum offset. 32MB ?
>>
>> I guess that relocate the initramfs just after the text section should
>> break this limitation.
> 
> But then means that it won't be freed after init time.
And why not putting it before init section ?

Matthieu
