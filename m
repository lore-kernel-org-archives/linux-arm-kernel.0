From: jean-michel.hautbois@veo-labs.com (Jean-Michel Hautbois)
Date: Fri, 6 Nov 2015 20:28:45 +0100
Subject: i.MX6: Oops when unplugging a USB key
In-Reply-To: <2393919.Res6zC5Fd5@jclayton-pc>
References: <CAH-u=81BFm1nquN5z7hFN9auV=9dPMPkRFX_PneK22UXgPbJnA@mail.gmail.com>
 <2393919.Res6zC5Fd5@jclayton-pc>
Message-ID: <CAH-u=83BcUpyjt=tO10xB_3zzbYu5HbhpDzRvZswvkfxvpThag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-06 20:12 GMT+01:00 Joshua Clayton <joshua.clayton@uniwest.com>:
> On Friday, November 06, 2015 05:32:30 PM Jean-Michel Hautbois wrote:
>> Hi !
>>
>> I have an issue on my i.MX6 board I don't understand (kernel is a 4.2)...
>> When I connect a USB key, and then disconnect it, it oopses and
>> reboots (as I have panic on oops, and reboot on panic).
>> Seems to be on the umount part...
>> The USB is connected through a smsc95xx but I don't think this is related...
>>
>> Any idea is welcome :)
>>
>
> I have seen a similar issue intermitently on my imx6 based board.
> I would also like to find a fix.
>
> Specifically: unplugging usb storage occasionally causes an oops.
>
> I'm guessing a race with use-after-free, but I haven't tracked it down.
> In my environment it has been hard to reproduce, and I wasn't able to
> grok anything useful in the trace.
>
> Are you seeing this behavior consistently?

I can see it every time I unplug my device. I must conduct some tests,
but seems to be somehow related to cpufreq and maybe the PMIC too (I
have cherry-picked the patches allowing anatop to use a vin-supply). I
didn't have time to bisect, I am sure I didn't have it when cpufreq
was not used at all...

JM
