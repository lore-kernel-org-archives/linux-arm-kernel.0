From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 24 Jun 2013 11:54:51 +0200
Subject: [PATCH v3 4/4] ARM: dts: mvebu: Introduce a new compatible string
 for mv64xxx-i2c
In-Reply-To: <51C5CD57.6040200@gmail.com>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
 <1371821529-13791-5-git-send-email-gregory.clement@free-electrons.com>
 <20130621140707.GO31667@titan.lakedaemon.net> <51C46001.30500@gmail.com>
 <20130621171836.GC10905@obsidianresearch.com> <51C5CD57.6040200@gmail.com>
Message-ID: <51C8176B.4000807@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2013 06:14 PM, Sebastian Hesselbarth wrote:
> On 06/21/2013 07:18 PM, Jason Gunthorpe wrote:
>> On Fri, Jun 21, 2013 at 04:15:29PM +0200, Sebastian Hesselbarth wrote:
>>> from a quick check of the patch set (which you forgot to send to LKML)
>>> I am wondering why you didn't update the of matches struct with the new
>>> compatible for "marvell,mv78230-i2c"? This will save you from still
>>> having "marvell,mv64xxx-i2c" as additional compatible to match device
>>> and driver. With that the above should also be s/and/or/.
>>
>> Agree, I noticed the same things.
>>
>> Alos, the compatible string should be:
>>
>>    compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
>>
>> (note the order reversal, most specific is first)
> 
> Actually, I suggest to use "marvell,mv78230-i2c" alone. With a new
> entry in the match table it will be sufficient for matching driver and

I would prefer using a specialization rather than a new entry, so I can just
use the "marvell,mv64xxx-i2c" entry for the data pointer .

> device. BTW, is mv78230 sufficient to match all SoC variants having
> this feature? Maybe mv78xx0 but that could interfere with Discovery
> Innovation or even better armada-xp-i2c (or armada-370-i2c)?

I am pretty sure that the convention in the device tree is to always use
specific product numbers, rather than wildcards. So, here, the choice of
mv78230 was just that we can see the mv78260 and mv78460 as extension of
the mv78230, so I chose the smallest common denominator.

> 
>> and I think it is better to use the 'data' field of of_device_id than
>> a of_is_compatible call. The former is sensitive to order of the
>> compatible string, the latter is not.
> 
> IMHO as long as there is only one compatible and only a bool to set,
> using of_device_is_compatible without data pointer is fine here.
> IIRC sunxi i2c isn't using data pointer the different register offset
> struct, so we shouldn't for a simple bool. And casting a bool to
> (void *) looks awkward.
> 
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
