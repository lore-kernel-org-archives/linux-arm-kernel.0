From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 01 Jun 2011 20:28:59 +0400
Subject: [PATCH v6 1/8] MTD: Add integrator-flash feature to physmap
In-Reply-To: <1306914546.27474.349.camel@e102391-lin.cambridge.arm.com>
References: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>	
	<1305637877-24436-2-git-send-email-marc.zyngier@arm.com>	
	<4DE53D52.4040508@ru.mvista.com>	
	<20110531224428.6636e283@taxman.wild-wind.fr.eu.org>	
	<BANLkTim0xrx+33BeoSbXbQcu2Ab6Oin=Wg@mail.gmail.com>
	<1306914546.27474.349.camel@e102391-lin.cambridge.arm.com>
Message-ID: <4DE668CB.9040408@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote:

>>>>> In the process of moving platforms away from integrator-flash
>>>>> (aka armflash), add to physmap the few features that make
>>>>> armflash unique:
>>>>> - optionnal probing for the AFS partition type
>>>>> - init() and exit() methods, used by Integrator to control
>>>>>   write access to the various onboard programmable components
>>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>>> [...]

>>>>> diff --git a/include/linux/mtd/physmap.h b/include/linux/mtd/physmap.h
>>>>> index bcfd9f7..d37cca0 100644
>>>>> --- a/include/linux/mtd/physmap.h
>>>>> +++ b/include/linux/mtd/physmap.h
>>>>> @@ -22,6 +22,8 @@ struct map_info;
>>>>>
>>>>>  struct physmap_flash_data {
>>>>>     unsigned int            width;
>>>>> +   int                     (*init)(struct platform_device *);
>>>>> +   void                    (*exit)(struct platform_device *);

>>>>     How about a declaration for 'struct platform_device' beforehand? This breaks
>>>> build on other platforms at least...

>>> Sure. Please send a patch.

>> uhh, what ?  you broke things, so you fix them.  i already pointed out
>> this breakage to you over a week ago.

> Mike,

> Sorry I missed your earlier comment about this. My bad.

> Now, about my reply to Sergei:
>       * Sergei identified the problem, and proposed a valid fix. It's
>         only fair he gets credited for his work (yes, you did it before
>         he did, but I didn't know it). The SOB on a patch is the proper
>         way of managing the attribution.
>       * Posting a patch is the quickest way for the maintainer (in this
>         case David) to be able to push a fix to mainline.
>       * It also helps other folks reading the ML and facing the same
>         issue. They can grab the patch, apply it locally and go on with
>         their own stuff until the patch is merged.
>       * The person reporting the problem probably has a configuration
>         showing the problem. If any of my platforms had shown that
>         error, I would have fixed it long before it hit the mailing
>         list.

    Actually, I'm not a primary reporter. The issue came up on the #mipslinux 
IRC channel, I then just remembered that I saw the patch set touching this file, 
and it was easy enough to complain to you after finding the corresponding mails.
    This happens to break MIPS platforms because they use warnings-as-errors 
option of gcc.

WBR, Sergei
