From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Wed, 26 Mar 2014 19:31:12 +0000
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140325223510.GD14718@obsidianresearch.com>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325202249.GA10378@obsidianresearch.com> <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
Message-ID: <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Tue, Mar 25, 2014 at 10:35 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Mar 25, 2014 at 04:24:04PM -0600, Jason Gunthorpe wrote:
>> On Tue, Mar 25, 2014 at 10:03:29PM +0000, Neil Greatorex wrote:
>>
>> > I then replaced it with mdelay(1000) out of interest, and it succeeded
>> > in detecting the card at boot. It then proceeded exactly as described
>> > by Willy in his later e-mail (it successfully registers an MSI-X
>> > interrupt for one port, and then proceeds to implode).
>>
>> Seem to confirm not enough time after reset..
>>
>> Try this (untested) debugging patch:
>
> Sorry, it has a mistake, that is not how you detect CRS on this chip..
>
> CRS might be something the driver has to emulate as well.....
>
> This is better.. CRS will be bit 19 in the ICR
>

<patch snipped>

I ran your patch. The dmesg output is available at
https://gist.github.com/ngreatorex/9790164

I'm afraid the output doesn't mean much to me :-)

Cheers,
Neil
