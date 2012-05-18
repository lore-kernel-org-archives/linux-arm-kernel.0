From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 May 2012 08:31:04 -0700
Subject: [PATCH v9 00/19] Introduce a led trigger for CPU activity and
 consolidate LED driver in ARM
In-Reply-To: <CAK5ve-Jc=g+E=fmK8HgMKAHPNBYkQdAKw=S0bLqEPYfPEbyabw@mail.gmail.com>
References: <1335884506-15370-1-git-send-email-bryan.wu@canonical.com>
 <alpine.LFD.2.02.1205101351380.21030@xanadu.home>
 <CAK5ve-L4rcAx-=n5u7G0AQzvUG3ir_jzF_ibaSf-EntXAzFUCw@mail.gmail.com>
 <201205121453.45242.arnd.bergmann@linaro.org>
 <CAOesGMgy4QkLuB10q19e67n_kQw4++gDYbWNELN-ASayVYkjbA@mail.gmail.com>
 <CAK5ve-Jc=g+E=fmK8HgMKAHPNBYkQdAKw=S0bLqEPYfPEbyabw@mail.gmail.com>
Message-ID: <CAOesGMg=UxB1E10r7WpqKc=FFSws6TN5jGahx7rpm1+E9uSkog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

On Fri, May 18, 2012 at 5:43 AM, Bryan Wu <bryan.wu@canonical.com> wrote:
> On Sun, May 13, 2012 at 3:06 PM, Olof Johansson <olof@lixom.net> wrote:
>> Hi,
>>
>> On Sat, May 12, 2012 at 7:53 AM, Arnd Bergmann <arnd.bergmann@linaro.org> wrote:
>>> On Friday 11 May 2012, Bryan Wu wrote:
>>>> OK, I rebased my patch back on 3.4.0-rc6, please find it here:
>>>> git://kernel.ubuntu.com/roc/linux-2.6/.git leds
>>>>
>>>> linux-next branch can be also found here:
>>>> git://kernel.ubuntu.com/roc/linux-2.6/.git leds-next
>>>>
>>>> Arnd, could you please help me to merge? if got any issue, please
>>>> point to me to fix.
>>>>
>>>
>>> Hi Bryan,
>>>
>>> I've merged it into a new next/leds branch. I got conflicts with the clps711x
>>> and at91 cleanups that are already in the next/cleanup branch but I think
>>> I resolved them all correctly. ?It would be nice if you and/or the maintainers
>>> of those platforms could confirm that.
>>
>> At the end of my pass of merging branches tonight, I tried building
>> all defconfigs on ARM and got several new build errors due to LED
>> changes. The ones that have hit it so far are:
>> * assabet_defconfig
>> * at91rm9200_defconfig
>> * ebsa100_defconfig
>> * footbridge_defconfig
>>
>> Bryan, please sort these out as soon as possible. Should be easy to
>> reproduce to debug. Meanwhile I've dropped the leds branch from
>> arm-soc's for-next branch so that we can bring in an updated
>> (bisectable without breakage) branch from you.
>>
>>
>
> So sorry, Arnd and Olof.
>
> I was travelling back from US to home recently and missed this email thread.
> I've already push all changes:
> git://git.kernel.org/pub/scm/linux/kernel/git/cooloney/linux-leds.git
> for-arm-soc
> It is based on y next branch in arm-soc git tree. I tried building and
> fixed some errors.
>
> Hope it's not very late.

Timing on this is unfortunate. Given that it's had a bit of problems
already I would like to see more bake and test time before this goes
into the tree. The merge window for 3.5 is too close for that.

We could pick it up as a staging/ branch, but given everybody's mad
dash at getting things in for 3.5 now, it's probably better to hold
off and pick it up i next/ branch as soon as -rc1 is out.

So, please send a fresh pull right after 3.5-rc1. Hope that's ok.


Regards,

-Olof
