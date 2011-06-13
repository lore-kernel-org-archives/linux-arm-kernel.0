From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 13 Jun 2011 09:17:49 -0600
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <alpine.LFD.2.00.1106131058080.2142@xanadu.home>
References: <20110612112219.GD16318@ibawizard.net>
	<20110612115820.GF10283@n2100.arm.linux.org.uk>
	<201106121615.24059.arnd@arndb.de>
	<20110612145751.GA4013@ponder.secretlab.ca>
	<20110612151931.GK10283@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1106121145570.2142@xanadu.home>
	<20110612155940.GM10283@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1106121454510.2142@xanadu.home>
	<20110613095142.GA10951@atomide.com>
	<alpine.LFD.2.00.1106131010150.2142@xanadu.home>
	<20110613142044.GC13643@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1106131058080.2142@xanadu.home>
Message-ID: <BANLkTinzibE6krCMdtzw57TLM91W4Chpqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 9:14 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:
>
>> On Mon, Jun 13, 2011 at 10:14:07AM -0400, Nicolas Pitre wrote:
>> > On Mon, 13 Jun 2011, Tony Lindgren wrote:
>> >
>> > > I agree that we need to parse the user configurable ATAGs to support
>> > > existing hardware properly. Otherwise we have edit the .dts for each board
>> > > to change the user configurable things, which is not nice for distros.
>> >
>> > You mean "existing bootloaders", right?
>> >
>> > Updated bootloaders should translate user configurable information into
>> > proper DT records and pass the resulting DTB to the kernel separately.
>>
>> OMAP is one of the code bases where this really matters - they have a
>> _lot_ of existing platforms with boot loaders which do the ATAG stuff.
>> They also have a lot of code in arch/arm that needs to be converted to
>> a DT representation.
>
> Yes, agreed. ?I just wanted to make the situation clear above, so people
> aren't confused in believing that the DT data is always static. ?New
> bootloaders should have the same ability to dynamically change some of
> the parameters passed to the kernel. ?So the issue is not about existing
> hardware, but rather about existing bootloaders.
>
>> With the current situation where you can have either ATAGs or DT but
>> not both, they're currently facing either having to break all the
>> existing platforms by ignoring the ATAGs _or_ keeping two copies of
>> a considerable amount of data - one in DT form and one in its existing
>> form.
>>
>> At present, DT can only be used sensibly on brand new SoCs where there
>> are no existing platforms with ATAG based boot loaders to worry about.
>> As things stand at present, even with your patch series, existing SoCs
>> have no viable path to transition to DT.
>
> As I said, I'm now convinced that the patch adding a shim to translate
> ATAGs into DT entries should be added to this series. ?I was reluctant
> initially for insentive purposes, but your argument clearly tilted the
> balance the other way.

John Bonesio was the author of that patch.

John, can you dust of the ATAGs-->DT conversion patch and get it
rebased to my current devicetree/test branch?  I've picked up Nicolas'
3 patch series which includes your dtb append patch into
devicetree/test.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
