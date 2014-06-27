From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 27 Jun 2014 16:13:56 +0200
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <20140627135932.GI32514@n2100.arm.linux.org.uk>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140627130430.GH32514@n2100.arm.linux.org.uk> <53AD724D.4020704@gmail.com>
 <20140627133933.GJ23978@titan.lakedaemon.net> <53AD7544.2060701@gmail.com>
 <20140627135932.GI32514@n2100.arm.linux.org.uk>
Message-ID: <53AD7C24.5090408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 03:59 PM, Russell King - ARM Linux wrote:
> On Fri, Jun 27, 2014 at 03:44:36PM +0200, Sebastian Hesselbarth wrote:
>> On 06/27/2014 03:39 PM, Jason Cooper wrote:
>>> On Fri, Jun 27, 2014 at 03:31:57PM +0200, Sebastian Hesselbarth wrote:
>>>> Also, production variants have their MAC address stored at 0xd0000 on
>>>> SPI flash. And while ES has PL2303 USB-to-UART, production use a
>>>> different brand, IIRC FTDI.
>>>
>>> Could you do a follow on patch adding a comment to this effect?  The
>>> Debian guys will need this for flash-kernel and friends.
>>
>> I don't know if that information will be of any use at all.
>>
>> You cannot determine USB-to-UART type from CuBox but your host PC only.
>>
>> And I am not sure, if we want to rely on some six numbers stored on
>> SPI flash, i.e. there is no magic nor header to be really sure, it
>> is a MAC address.
>
> This is kind'a my point - you're confirming that you can't reliably
> tell which version you have by running something on the cubox itself.
> As Jason points out, there are those who need to choose the correct
> DT file when installing.
>
> So, this means that the user has to be asked.  If users have to be
> asked, users need some way to identify the hardware that they're
> running on.

I get your point, but there is no way to automatically tell them apart.
IMHO, that is why cubox-dove.dts should represent the *production*
version.

> No, I didn't know until recently, because my Cubox was given to me by
> Nicolas Pitre a couple of years ago - that's the problem, the engineering
> samples may not be with the original people and therefore their origins
> may not be known.

It is printed on the box it came in ;)

Honestly, I consider it much more likely that someone who buys/owns an
ES is able to tell them apart than the other way round. And _you_ know
how to deal with the wrong dts, the other may not.

Sebastian
