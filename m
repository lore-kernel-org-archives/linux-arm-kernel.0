From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 10 Jan 2014 22:52:13 +0100
Subject: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the OpenBlocks
 AX3-4 board
In-Reply-To: <20140110213752.GA19878@titan.lakedaemon.net>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
 <20140110182240.GK19878@titan.lakedaemon.net>
 <20140110190521.GI18269@obsidianresearch.com>
 <20140110194550.GT19878@titan.lakedaemon.net>
 <20140110200813.GV19878@titan.lakedaemon.net>
 <52D05439.7040905@free-electrons.com>
 <20140110211417.GX19878@titan.lakedaemon.net>
 <52D06459.5000403@free-electrons.com>
 <20140110213752.GA19878@titan.lakedaemon.net>
Message-ID: <52D06B8D.9060901@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2014 22:37, Jason Cooper wrote:
> On Fri, Jan 10, 2014 at 10:21:29PM +0100, Gregory CLEMENT wrote:
>> On 10/01/2014 22:14, Jason Cooper wrote:
>>> On Fri, Jan 10, 2014 at 09:12:41PM +0100, Gregory CLEMENT wrote:
>>>> Jason,
>>>> On 10/01/2014 21:08, Jason Cooper wrote:
>>>>> On Fri, Jan 10, 2014 at 02:45:50PM -0500, Jason Cooper wrote:
>>>>>> On Fri, Jan 10, 2014 at 12:05:21PM -0700, Jason Gunthorpe wrote:
>>>>>>> On Fri, Jan 10, 2014 at 01:22:40PM -0500, Jason Cooper wrote:
>>>>>>>
>>>>>>>> Do we create new compatible strings to indicate errata, or to indicate
>>>>>>>> 'from this version forward there are new features'?  The former would
>>>>>>>> indicate as Gregory has written '...-a0-i2c', the latter would warrant
>>>>>>>> '...-b0-i2c' and disabling offloading if we don't see '...-b0-i2c'.
>>>>>>
>>>>>> s/-b0-i2c'./-b0-i2c' or newer./
>>>>>>
>>>>>>> IMHO the compatible string should represent a specific HW/SW ABI. So
>>>>>>> you need a unique compatible string for every variation of that ABI.
>>>>>>
>>>>>> My concern is that we tend to do things like "marvell,orion-sata" for
>>>>>> the first version of the IP block we can work with.  orion5x, kirkwood,
>>>>>> dove, and armada 370/xp all use that compatible string to refer to that
>>>>>> IP block.
>>>>>>
>>>>>> Given that we look at it as 'and newer', '...-a0-i2c' would mean no
>>>>>> offloading until we introduce '-b0-i2c'.  Or am I mis-understanding what
>>>>>> you're saying?
>>>>>>
>>>>>>> We already have a compatible string defined for the ABI that B0
>>>>>>> presents.
>>>>>>
>>>>>> So 'mv78230-i2c' is newer than 'mv78230-a0-i2c', or are you referring to
>>>>>> something else?
>>>>>
>>>>> I think the crux of it is:  Is mv78230-i2c the first, or the default?
>>>>
>>>> Here it's clearly the default
>>>
>>> So we should default to no offloading when we see it?  Since it has been
>>> deployed referring to -a0 revision i2c IP blocks?
>>>
>>
>> But this assumption is wrong as I already wrote few days ago, mv78230-i2c
>> has been deployed referring to -b0 revision i2c IP blocks since the begining.
> 
> Ok, sorry.  As I wrote on irc last week, I've been on travel and haven't
> been able to fully digest everything coming in.  My re-read of all the
> threads regarding this this morning didn't catch it.

No problem there was a lot of email just for this simple fix!

> 
>> It was developed on and for B0 version, and this compatible was created for
>> this specific version. It was latter that we realized that it was not fully
>> compatible with A0. But for sure:
>>
>> mv78230-i2c == I2C IP running on Armada XP B0 (or latter)
> 
> Ok, this still feels counter-intuitive, and folks not familiar with the
> development process might assume the opposite.  So I'll reply to 4/4
> with a reword to make your above statement an explicit part of the
> binding documentation.  No need to do another patch version.  I'll fix
> it up when I pull it in if you're ok with it.

Please use my branch because as I wrote you:
https://github.com/MISL-EBU-System-SW/mainline-public/tree/i2c-mv64xxx-3.13-rc6-fixes-v6

I took into account the last minor review from Arnd and Wolfram, and I
also updated all the flags acked-by and reported-by. But if you prefer
I can just sent a 6th version on the mailing list.

Thanks,

Gregory


> 
> thx,
> 
> Jason.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
