From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 30 Jun 2014 09:50:30 +0200
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <20140628145424.GK23978@titan.lakedaemon.net>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140627130430.GH32514@n2100.arm.linux.org.uk> <53AD724D.4020704@gmail.com>
 <20140627133933.GJ23978@titan.lakedaemon.net> <53AD7544.2060701@gmail.com>
 <D0DC98AD-E460-42C9-B2F4-51EDDE371E31@lakedaemon.net>
 <53ADAB8C.6070609@gmail.com> <20140628145424.GK23978@titan.lakedaemon.net>
Message-ID: <53B116C6.80601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2014 04:54 PM, Jason Cooper wrote:
> On Fri, Jun 27, 2014 at 07:36:12PM +0200, Sebastian Hesselbarth wrote:
>> On 06/27/2014 06:49 PM, Jason Cooper wrote:
>>>> On Jun 27, 2014, at 9:44, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>>> ...
>>>> And I am not sure, if we want to rely on some six numbers stored on
>>>> SPI flash, i.e. there is no magic nor header to be really sure, it
>>>> is a MAC address.
>>>
>>> It couldn't be compared with the MAC address of the nic?
>>
>> Sure, but if it is not equal it tells you nothing.
>>
>> You can change the NICs MAC in your bootloader, it will be different
>> from the numbers you read from SPI, and some mechanism will assume you
>> just made your production version into ES.
>>
>> We really want to introduce such a crutch?
> 
> Well, we need to keep in mind distro's concerns, but we don't need to
> (and shouldn't) attempt to solve them.
> 
> That's why I wanted to add a comment expressing the facts as best we
> know them.  We could also now add a link to this thread to assist future
> distro maintainers.
> 
> As this patch sits, it is an accurate description of the two variants of
> dove-based CuBoxes.  The fact that SolidRun didn't leave a clear
> differentiator is unfortunate, but we can't magic a solution out of our
> ass.  Nor should we block a patch because we can't.

Ok, I'll look through my eMails and Web again to collect some
differences and prepare a "add comment" only patch for the CuBox DTSs.

> It also might be worth reaching out to Rabeeh one more time and asking
> explicitly if there is a programmatic way to differentiate the two
> boards on the board itself.

Yeah, I remember someone said that there is a different SPI vendor on
production CuBox. That could be a way to tell them apart _if_ it is
used exclusively on production boxes.

But I'll ask Rabeeh about it again.

> It would have been ideal if the ES had 512MB of RAM...

Depends, for differentiation yes, otherwise I am quite happy with 1G ;)

Some magic and a variant number in SPI would have been better I guess.

Sebastian
