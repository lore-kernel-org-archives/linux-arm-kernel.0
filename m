From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Mon, 9 Apr 2018 14:49:15 +0300
Subject: SUN6I a31 OPP table clock issue
In-Reply-To: <20180409112829.dckferoj6n2j2sbj@flea>
References: <c309c971-7559-e1d9-dc9f-2f7a7ad6f3cb@orpaltech.com>
 <20180409085356.goemvdy3ecyqoghp@flea>
 <8b797d9c-b2fb-e49b-daa2-e4e15753f3fa@orpaltech.com>
 <20180409112829.dckferoj6n2j2sbj@flea>
Message-ID: <0b71957c-ee99-7d82-4b17-ee98c6fa9594@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2018 02:28 PM, Maxime Ripard wrote:
> On Mon, Apr 09, 2018 at 01:35:42PM +0300, Sergey Suloev wrote:
>> On 04/09/2018 11:53 AM, Maxime Ripard wrote:
>>> On Sat, Apr 07, 2018 at 10:53:10PM +0300, Sergey Suloev wrote:
>>>> I was able to catch oops coming from OPP table on BananaPi M2.
>>>>
>>>> https://pastebin.com/ZRaXTtEx
>>>>
>>>> Let me know if need more detail.
>>> Of course we do.
>>>
>>> Which kernel version was this for? With which configuration? What
>>> makes you say it's related to the OPP table, is it a regression or
>>> something you just noticed?
>> Ok, first of all, I am having the problem using linus tree, 4.16 as it is,
>> with no extra patches.
> Your kernel version is marked as dirty in your logs, which means you
> have local changes. So it doesn't really qualify as "as is".
well, yeah, there is a small change but in? absolutely different area
>
>> My config file is here [1].
>> The problem is easily avoided by just commenting all freqs out of the OPP
>> table except for 1008 MHz, i.e. things work well when there is no freq
>> switch at all.
>> It makes me think that there might be an issue in A31 clocks driver as it is
>> the only important component used by cpufreq-dt.
>> As of cpufreq-dt driver it seems ok because works fine on other boards.
> Could you add some printk's to ccu_mux_notifier_nb to see which
> pointer is NULL?
ok

> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
