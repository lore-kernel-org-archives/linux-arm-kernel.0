From: rob.epping@gmail.com (Rob J. Epping)
Date: Mon, 12 Oct 2015 18:05:04 +0200
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <CAKzmTe2f1FdjM5VZ-ju+ZQ4z0Dxk4x1ywJCfi1OX5eSaCr=51w@mail.gmail.com>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
 <CAKzmTe0Bq8itvKoOTwZ+ZjY5pTqFYWt0-ihO4jn0qew_NYGhFg@mail.gmail.com>
 <20151011153548.GA9808@lunn.ch>
 <CAKzmTe2f1FdjM5VZ-ju+ZQ4z0Dxk4x1ywJCfi1OX5eSaCr=51w@mail.gmail.com>
Message-ID: <461C493B-AD82-4044-A87F-EC22BBFB7011@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On October 12, 2015 4:29:51 PM GMT+02:00, JM <fijam@archlinux.us> wrote:
>On Sun, Oct 11, 2015 at 5:35 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> On Sun, Oct 11, 2015 at 04:37:52PM +0200, JM wrote:
>>> On Sat, Sep 5, 2015 at 11:08 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>>> > On Fri, Aug 21, 2015 at 01:24:17PM +0100, Ian Campbell wrote:
>>> >> Hi kirkwood-upstream,
>>> >>
>>> >> We (Debian) have had a couple of reports of I/O errors running
>Debian
>>> >> on kirkwood, specifically it seems to relate to later kernels
>(e.g.
>>> >> 4.0+) and I _suspect_ (without proof) that it may be due to the
>switch
>>> >> from board files to the DTS based kernel, or some change implied
>by
>>> >> this (e.g. different SATA driver now or timeouts have changed
>>> >> perhaps?).
>>> >
>>> > Hi Ian
>>> >
>>> > I've not reproduced this exactly, but something similar.
>>> >
>>> > I do a find / and in parallel a cat /dev/mtdblock3 > /dev/null
>>> >
>>> > While the cat is active, the find grinds to a halt. I don't get
>any
>>> > SATA timeouts, but that could be because /dev/mtdblock3 is small
>>> > enough that the timers don't expire.
>>> >
>>> > So i will now try to track down if there is a lock getting
>contended,
>>> > or at least why only the cat process makes progress.
>>> >
>>> >    Andrew
>>>
>>> Is there any update on this? The bug persists with kernel 4.2.1
>>
>> Sorry, not had time to look.
>>
>> Do you have any idea when the issue started? My QNAP box got device
>> tree support somewhere around 3.5. So i would be tempted to see if
>> that has the issue, and then git bisect from there. Could you do the
>> same with you hardware?
>>
>>      Andrew
>
>Thanks for the reply.
>
>I'm afraid my only box is 'in production' and I'd be very reluctant to
>test older kernels there as I use fairly recent filesystem features. I
>have a feeling this bug has been around for a long time (or perhaps is
>even inherent to the way the mtdblock driver is written) and has only
>been brought out of its dormancy due to some more recent changes, as I
>remember my device momentarily freezing during flashing with Debian
>Wheezy (kernel 3.2) (although at that time it wouldn't result in a
>complete SATA reset). This could use an independent confirmation
>though.
>
>Best regards,
>Jan

I've been on backports  for some time. AFAIR the problems started with the change to dtb/dts.

I have a box that I can test with, but it has no console connected. Can steal the console connection from my "production" box but that is cumbersome.

GRTNX,
RobJE
-- 
Sent from my mobile device. Please excuse my brevity.
