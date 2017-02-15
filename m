From: stefan@agner.ch (Stefan Agner)
Date: Wed, 15 Feb 2017 14:44:12 -0800
Subject: sDMA on i.mx7d
In-Reply-To: <20170215110736.oumvvv7zordd2jdw@piout.net>
References: <20170214222425.hbkfkeq3l6sveo7n@piout.net>
 <e9c36a33f2a49df2a517db5869eaea7f@agner.ch>
 <20170215110736.oumvvv7zordd2jdw@piout.net>
Message-ID: <3513b2c01d86ad7312522d6be97e766f@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-02-15 03:07, Alexandre Belloni wrote:
> On 14/02/2017 at 23:25:34 -0800, Stefan Agner wrote:
>> On 2017-02-14 14:24, Alexandre Belloni wrote:
>> > Hi,
>> >
>> > I've been trying to get a PCM3168s codec with a Colibri iMX7 using TDM
>> > on SAI2.
>> > I've got it working properly with the 4.1.35 kernel from Toradex (based
>> > on the 4.1.15 from Freescale).
>> > It is working fine with and without providing a firmware to the sDMA.
>> >
>> > But, I couldn't get that to work with v4.9. I actually managed to
>> > reproduce the issue using the SGTL5000 so I don't have any patch on top
>> > of v4.9.
>>
>> I guess you are using the on module SGTL5000 to reproduce?
>>
> 
> Yes, using the on module sgtl5000 of a colibri on an iris.
> 
>> When I added audio support I remember that the sound seemed to be ok to
>> me. Is the corruption such that you can hear it?
>>
> 
> You can hear it but not if you are playing a simple sine at a frequency
> that is a multiple of 10 (e.g. 440Hz)
> 

Compiled v4.9 and played a song, I could clearly hear constant "noise"
during playback.

I went back to my v4.8-rc3 + some patches applied back when I tested
audio and submitted the device tree change, and the noise isn't there.

In a "I feel lucky" manor I just reverted the last patch 5881826ded79
("dmaengine: imx-sdma - update the residue calculation for cyclic
channels") and the song sounded clean as always again!

Alexandre, does reverting this helps your issue too?

+Nandor, Author of said patch. Any idea?

--
Stefan
