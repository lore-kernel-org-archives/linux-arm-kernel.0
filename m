From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Tue, 14 Mar 2017 21:41:50 +0100
Subject: [PATCH] drm/exynos: Print kernel pointers in a restricted form
In-Reply-To: <20170314195240.gj7jbgql7hfziw42@kozik-lap>
References: <20170314183804.13788-1-krzk@kernel.org>
 <e1800491-0b60-74d1-1377-756d5b0bb371@math.uni-bielefeld.de>
 <20170314190859.y55wlc4z7xdsbbxg@kozik-lap>
 <de5e8583-748b-9df2-f7cc-c1b4fb499d17@math.uni-bielefeld.de>
 <20170314195240.gj7jbgql7hfziw42@kozik-lap>
Message-ID: <e147ef15-0f7c-19f0-8e1b-db6a75930932@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski wrote:
> On Tue, Mar 14, 2017 at 08:17:35PM +0100, Tobias Jakobi wrote:
>> Krzysztof Kozlowski wrote:
>>> On Tue, Mar 14, 2017 at 08:01:41PM +0100, Tobias Jakobi wrote:
>>>> Hello Krzysztof,
>>>>
>>>> I was wondering about the benefit of this. From a quick look these are
>>>> all messages that end up in the kernel log / dmesg.
>>>>
>>>> IIRC %pK does nothing there, since dmest_restrict is supposed to be used
>>>> to deny an unpriviliged user the access to the kernel log.
>>>>
>>>> Or am I missing something here?
>>>
>>> These are regular printks so depending on kernel options (e.g. dynamic
>>> debug, drm.debug) these might be printed also in the console. Of course
>>> we could argue then if access to one of the consoles is worth
>>> securing.
>> This here suggests otherwise.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/sysctl/kernel.txt#n388
>>
>> I have not tested this, but IIRC %pK is not honored by the kernel
>> logging infrastucture. That's why dmesg_restrict is there.
>>
>> Correct me if I'm wrong.
> 
> The %pK will not help for dmesg or /proc/kmsg but it will help for
> console (/dev/ttySACN, ttySN etc) because effectively it uses the same
> vsprintf()/pointer() functions.
Thanks for the explanation, I didn't know that there was a difference
there. In that case, looks good to me.


> As I said, we could argue whether securing console is worth... usually
> attacker having access to it has also physical access to the machine so
> everything gets easier...
Still, putting %pK there certainly doesn't hurt.

- Tobias

> 
> Best regards,
> Krzysztof
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
