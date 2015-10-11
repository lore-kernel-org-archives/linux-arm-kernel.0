From: fijam@archlinux.us (JM)
Date: Sun, 11 Oct 2015 16:37:52 +0200
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20150905210846.GF6040@lunn.ch>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
Message-ID: <CAKzmTe0Bq8itvKoOTwZ+ZjY5pTqFYWt0-ihO4jn0qew_NYGhFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 5, 2015 at 11:08 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Aug 21, 2015 at 01:24:17PM +0100, Ian Campbell wrote:
>> Hi kirkwood-upstream,
>>
>> We (Debian) have had a couple of reports of I/O errors running Debian
>> on kirkwood, specifically it seems to relate to later kernels (e.g.
>> 4.0+) and I _suspect_ (without proof) that it may be due to the switch
>> from board files to the DTS based kernel, or some change implied by
>> this (e.g. different SATA driver now or timeouts have changed
>> perhaps?).
>
> Hi Ian
>
> I've not reproduced this exactly, but something similar.
>
> I do a find / and in parallel a cat /dev/mtdblock3 > /dev/null
>
> While the cat is active, the find grinds to a halt. I don't get any
> SATA timeouts, but that could be because /dev/mtdblock3 is small
> enough that the timers don't expire.
>
> So i will now try to track down if there is a lock getting contended,
> or at least why only the cat process makes progress.
>
>    Andrew

Is there any update on this? The bug persists with kernel 4.2.1

Best regards,
Jan
