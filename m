From: eric@nelint.com (Eric Nelson)
Date: Fri, 23 Sep 2016 11:39:41 -0700
Subject: Alignment issues with freescale FEC driver
In-Reply-To: <20160923183010.GB1041@n2100.armlinux.org.uk>
References: <troy.kisky@boundarydevices.com>
 <02afb707-65de-5101-a79b-355929c4e00b@nelint.com>
 <CANn89iLb+QJu+MYh859oAAjcLCsKRpBbzVf43yOdq+HJVtZDpQ@mail.gmail.com>
 <5ee28ee0-cf0c-bdab-1271-f17755365c13@nelint.com>
 <0fe7a310-2d2f-4fca-d698-85d66122d91c@nelint.com>
 <20160923181301.GD22965@lunn.ch>
 <20160923183010.GB1041@n2100.armlinux.org.uk>
Message-ID: <e1db8ef7-a61a-e4a7-b551-51d42df6d065@nelint.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Russell,

On 09/23/2016 11:30 AM, Russell King - ARM Linux wrote:
> On Fri, Sep 23, 2016 at 08:13:01PM +0200, Andrew Lunn wrote:
>>> Since the hardware requires longword alignment for its' DMA transfers,
>>> aligning the IP header will require a memcpy, right?
>>
>> The vf610 FEC has an SHIFT16 bit in register ENETx_TACC, which inserts
>> two padding bits on transmit. ENETx_RACC has the same.
>>
>> What about your hardware?
> 
> The iMX6 FEC also has that ability - as part of my FEC patch stack from
> ages ago, I implemented support for it.
> 
>   "net:fec: implement almost zero-copy receive path"
> 
> in my public fec-testing branch.
> 
> That patch stack is sadly now totally dead and I've no interest in
> reviving it myself.  There was some interest from others in taking my
> patch stack over, but that went quiet.
> 

I'll take a look and hopefully revive at least part of the patch set.
