From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 9 May 2014 08:58:03 +0200
Subject: OMAP baseline test results for v3.15-rc4
In-Reply-To: <alpine.DEB.2.02.1405081456560.23579@utopia.booyaka.com>
References: <alpine.DEB.2.02.1405080417150.23579@utopia.booyaka.com>
 <CAGhQ9Vx_dJTn20S1OngAks1KvZkH=MUWEh-4bv5ciM7PhofJ8Q@mail.gmail.com>
 <alpine.DEB.2.02.1405081456560.23579@utopia.booyaka.com>
Message-ID: <CAGhQ9VzP7doMPdNrX2O5aYuiicigi93KSq=Pg6FQFDS9kGeD_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2014 17:00, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Joachim,
>
> On Thu, 8 May 2014, Joachim Eastwood wrote:
>
>> On 8 May 2014 06:23, Paul Walmsley <paul@pwsan.com> wrote:
>> >
>> > Here are some basic OMAP test results for Linux v3.15-rc4.
>> > Logs and other details at:
>> >
>> >     http://www.pwsan.com/omap/testlogs/test_v3.15-rc4/20140505112251/
>> >
>> >
>> > Test summary
>> > ------------
>> <snip>
>> >
>> > The eMMC on the 4460 VAR-SOM-OM has failed; I guess it's run out of
>> > reserve blocks to reallocate.  Now it's time to find yet another way
>> > to boot it.
>>
>> I have some patches for u-boot which makes it possible to use the
>> on-board LAN7500 USB Ethernet controller for tftp.
>
> That's great!

I haven't had time to upstream it yet, but I'll send you a WIP version.
These patches are also needed for USB in Linux since the on-board USB
hub requires some special setup that I have put in u-boot.

>> Since you have a VAR-SOM-OM44 module maybe you could test my dts patches for it?
>> I will post a new version of the patch set early next week. I can cc you.
>
> I'd like to load the rootfs off the external SD slot.  Looks like you
> might be adding support for that with your recent DT patches?

Yes, the external SD slot (sdmmc5) is supported in the dts. It worked
last time I tested it, but I haven't tried to use it for rootfs.

>> Do you have the VAR-DVK-OM44 eval board?
>
> Yes.

Nice :-)

Then you see if the display stuff is working with DT also.

regards
Joachim Eastwood
