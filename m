From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Oct 2014 14:18:04 -0700
Subject: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella
In-Reply-To: <5446CB2E.4080503@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <CAOesGMjAb5oXjauhbqjDhJXWct7qoXxy3XpA1=DioK7vPTwetA@mail.gmail.com>
 <5446C775.3030707@suse.de>
 <CAOesGMhSuvbWpM5CC_5Hy6BskM6sbrw0SCR90aKHvfk1Qm1_Ng@mail.gmail.com>
 <5446CB2E.4080503@suse.de>
Message-ID: <CAOesGMjQvkPyNQJ1cgxhBrw6ASwWK9jVAYkaraC1cwce9WEO=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 2:07 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 21.10.2014 um 23:01 schrieb Olof Johansson:
>> On Tue, Oct 21, 2014 at 1:52 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>> Am 18.10.2014 um 06:28 schrieb Olof Johansson:
>>>> I did a test run with yesterday's -next It looks like networking isn't
>>>> working there at the moment, clock related. Same happens with 3.17 and
>>>> latest mainline, config multi_v7_defconfig:
>>>>
>>>> [WARN] [    7.943648] macb e000b000.ethernet eth0: unable to generate
>>>> target frequency: 125000000 Hz
>>>> [WARN] [   10.948681] macb e000b000.ethernet eth0: unable to generate
>>>> target frequency: 125000000 Hz
>>>
>>> I am unable to reproduce this in my setup - at Linus' tip
>>> c2661b806092d8ea2dccb7b02b65776555e0ee47 (v3.18-rc1-68-gc2661b8), make
>>> oldconfig'ing my /proc/config.gz.
>>>
>>> S?ren, in light of your explanations, should I be expecting problems
>>> with 1GbE or with 100MbE? My board is connected to a 1GbE switch.
>>
>> My board might have old firmware/bitstream on it? It reports as:
>>
>> U-Boot 2012.10-00003-g792c31c (Jan 03 2014 - 12:24:08)
>
> Mine reports the same version.
>
> sha512sum of non-headless bitstream:
> decb37222a7da0de39b1c1eb95714500cc006506cc86d85ed9c6c7b30c7cd7b91ef3592b886311f4285b5ce0079b4ffcd83f91ae275435ac15cefefe7db00b08
>  /mnt/parallella.bit.bin

Mine is booting with whatever bitstream is flashed, and i'm not sure
how to actually look at what that is.

'fpga dump 0 0x10000000 0x1000000' doesn't do what I expect it to
(target memory isn't modified).


-Olof
