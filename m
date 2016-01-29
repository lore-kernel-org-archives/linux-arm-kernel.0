From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Jan 2016 15:59:45 +0800
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <56AB05EF.2090604@redhat.com>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr> <56A8D5E5.30701@gmail.com>
 <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
 <56A9098A.5010107@redhat.com>
 <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
 <56A9CE3D.4020906@redhat.com>
 <56AA14AA.4070502@gmail.com> <20160128175918.78a916a8cd7bf4c0b2f2814f@free.fr>
 <20160128192931.GB32462@lukather> <56AB05EF.2090604@redhat.com>
Message-ID: <CAGb2v65VfPuxVeH9eWEXJLp-10LyLxSaYXwaWTH-K5=cHKBXsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 2:25 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 01/28/2016 08:29 PM, Maxime Ripard wrote:
>>
>> On Thu, Jan 28, 2016 at 05:59:18PM +0100, Jean-Francois Moine wrote:
>
>
> <snip>
>
>>> The A23/A33/H3 (and surely some other SoCs) documentations about
>>> the peripheral/periph/periph0/periph1 PLLs say:
>>>
>>>         Note: The PLL Output should be fixed to 600MHz, it is not
>>>         recommended to vary this value arbitrarily.
>>
>>
>> I don't know if it's worth it at this point. The pll6 seems to work
>> fine at other rates. Have you experienced any breakage when running at
>> another frequency?
>
>
> Hmm, are we actually changing the freq of pll6 on any SoCs? I know we've
> the code to it, but given that it is shared between many pheripherals,
> I assume we end up never changing it. I assume / hope that the clock
> framework protects against reclocking a clock with multiple users ...

No we're not. And none of the children of pll6 have CLK_SET_RATE_PARENT
set, so they won't change pll6. I think the point is pll6 itself _can_
be changed, but that would screw up all the peripherals depending on it.

There's also SATA and USB that might be driven by it.

ChenYu
