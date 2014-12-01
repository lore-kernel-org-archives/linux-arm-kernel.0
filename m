From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Mon, 1 Dec 2014 18:15:31 +0800
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <20141201095815.GA7949@1wt.eu>
References: <CAB8gEUsK9c3YMpAABifNAWU7zec2ePztSqS4KAYtiT7Sbhadvg@mail.gmail.com>
 <20140721070303.GM21834@1wt.eu>
 <CAB8gEUtmgwfWcuoYZ-wDwHVmzHN0WyOQD9oEOGAZ_gJfbPUm-g@mail.gmail.com>
 <20140723061659.GE30488@1wt.eu>
 <CAB8gEUtO=K-mjie6czsf-9ao1cxiMAV2ScbgUnf+XxqjEfOUvg@mail.gmail.com>
 <CAB8gEUtgo-8nets3tRtqiZ8qRx+SyCq2d8v05scavWNwE5TNXg@mail.gmail.com>
 <20141201072802.GB21731@1wt.eu>
 <CAB8gEUsQ8nSNwB7vpZHBkELEBX2sN1QdWvujBGYQJY9dtCzgww@mail.gmail.com>
 <20141201092851.GA22304@1wt.eu>
 <20141201103221.6268b811@free-electrons.com>
 <20141201095815.GA7949@1wt.eu>
Message-ID: <CAB8gEUuW-r8oY=+ku+Cy4ZBKBvO9rF+QApn=WxR3nZFaSoCvTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Willy.
Good day.

Thank you for your assistance as always.

We are currently testing the attached patch + 3.13.9.
We'll let you know the results as soon as we've conducted enough tests
- latest tomorrow.

Will keep you posted.

Regards,
Maggie Roxas


On Mon, Dec 1, 2014 at 5:58 PM, Willy Tarreau <w@1wt.eu> wrote:
> Hi Thomas,
>
> On Mon, Dec 01, 2014 at 10:32:21AM +0100, Thomas Petazzoni wrote:
>> If I understood correctly, on RX the interrupt coalescing can be done
>> every X packets, or after N milliseconds. However, on TX, it's only
>> after Y packets, there is no way to configure a delay.
>
> That was my understanding of the datasheet as well.
>
>> But in any case, with NAPI implemented in software, are these hardware
>> interrupt coalescing features very important? As soon as the number of
>> interrupts becomes high, the kernel will disable the interrupt and
>> switch to polling, no?
>
> Absolutely, but despite this, the interrupts still impact the system's
> performance, because instead of waking up the driver once the Tx queue
> is about to be empty (let's say twice per Tx queue), we wake up as often
> as the system supports it. The net effect is a performance loss of about
> 5% on small packets, which is not huge of course, but would rather be
> spent doing some more useful stuff.
>
> Uri gave me a contact at Marvell who knows this device well, I'll ask
> him if there's no other way to work with this chip. Sending an interrupt
> at least when the Tx queue is empty would be nice :-/
>
> Best regards,
> Willy
>
