From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 23 Nov 2011 12:43:43 -0800
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <4ECC6D24.9030509@codeaurora.org>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <20111122154900.GB18954@kroah.com>
 <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
 <20111122191347.GB4844@kroah.com> <4ECC6D24.9030509@codeaurora.org>
Message-ID: <CAJOA=zNQb5448Xh6weiow5pcO6C=DwNxOknXW18C5RYvH_s75g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 7:48 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 11/22/2011 11:13 AM, Greg KH wrote:
>>
>> On Tue, Nov 22, 2011 at 09:57:41AM -0800, Mike Turquette wrote:
>>>>
>>>> Ah, comments like this warm my heart.
>>>>
>>>> Come on, no abusing the kobject code please, if have problems with how
>>>> the kernel core works, and it doesn't do things you want it to, then why
>>>> not change it to work properly for you, or at the least, ASK ME!!!
>>>
>>> Ok, I'm asking you now. ?There are two ways to solve this problem:
>>>
>>> 1) have kobject core create the lists linking the objects but defer
>>> allocations and any interactions with sysfs until later in the boot
>>> sequence, OR
>>>
>>> 2) my code can create a list of clks (the same way that clkdev does)
>>> and defer kobject/sysfs stuff until later, which walks the list made
>>> during early-boot
>>>
>>> #1 is most closely aligned with the code I have here, #2 presents
>>> challenges that I haven't really though through. ?I know that OMAP
>>> uses the clk framework VERY early in it's boot sequence, but as long
>>> as the per-clk data is properly initialized then it should be OK.
>>>
>>> What do you think?
>>
>> #3 - use debugfs and don't try to create a sysfs interface for the clock
>> structures :)
>
> I would prefer debugfs too, but for my own selfish reasons. In our current

I'll cook up debugfs code for the fwk and drop sysfs.  Maybe not part
of V4 (per Arnd's suggestion to focus on upstreamable bits), or maybe
I will if I have time.

Regards,
Mike
