From: dashie@sigpipe.me (Dashie)
Date: Fri, 21 Feb 2014 08:39:08 +0100
Subject: Stuck getting DTS working for a new kirkwood board
In-Reply-To: <20140221013407.GX7862@titan.lakedaemon.net>
References: <5306721B.7020403@sigpipe.me>
 <20140221013407.GX7862@titan.lakedaemon.net>
Message-ID: <5307029C.20006@sigpipe.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/21/2014 02:34 AM, Jason Cooper wrote:
> Dashie,
>
> + other mvebu maintainers.  Please Cc us in the future.
>
> Your timing is fortuitous.  :)  We were just discussing this board and
> the few others that haven't been converted yet.
That's exactly what motivated me to post ;)

>
> On Thu, Feb 20, 2014 at 10:22:35PM +0100, Dashie wrote:
>> Hi all,
>>
>> I'm a very beginner in the DTS and ARM kernel world and trying to get a
>> DTS working for my new toy.
> I was there a couple years ago.  No problem.
>
>> I've done some tests using mainlineLinux and arcNumber and i remember to
>> got some things working (PCI-e, Intel eth) but only two drives and no
>> fan/sensor using arcNumber for "00000b1e    HP t5325 Thin Client       
>>                         2846".
> Let's focus on converting this board file to devicetree.  which means
> you'll be setting mainlineLinux to true and arcNumber to 0xffffffff.
> (means booting via devicetree).
Actually i've unset mainlineLinux and arcNumber, so the DTB is used.
In fact the t5325 device is the only one which the pci-e works, but it
use old -setup.c files and then i'm lost with that.

>
>> I've since started to use a DTS, copied the guruplug-server-plus (IIRC)
>> and done some changes, actually i can get working :
>>     - temp sensor
>>     - fan control (off, middle, full)
>>     - integrated marvell eth
>>     - the four disks are detected and seems working
> That's a good start.
>
>> But can't get the PCI-e working (and then the intel ethernet), also
>> sensor path seems to change every reboot (i need to do more tests).
>> Also i've SATA power reg enabled in the DTS but it doesn't seems to have
>> any (to be confirmed, the original firmware seems to have the ability to
>> shutdown unaccessed drives) and i will remove them, anyway i don't know
>> the GPIO, if any.
>>
>> I still miss some GPIOS for : Led (r/g) power, func led, the four sata
>> leds, maybe some triggers for hdds, and the power and func buttons.
>> (already tried gpio export and out direction and "1" in value, but
>> nothing blink)
>> Reset button sends things in /dev/input/input0 so it seems to works.
>>
>> The current DTS is joined to this mail, i've actually the NAS with me
>> and can test things. I can provide too : original dmesg (from original
>> firmware), current dmesg using DTS, lspci -vvv (from kernel with arcNumber).
>>
>> I'm currently using a stock 3.12.9 debian kernel and doesn't have
>> anymore access to the original firmware.
> It would be helpful if you could build a kernel from the git repos.
> Have you done that before?
I've built a kernel from the 3.12.9 debian sources but can't get it to
boot, i got nothing after "Uncompressing Linux... done, booting the
kernel.".
I've used the debian's kernel config file, but i can try the
kirkwood_defconfig make target and checking everything is activated (DTB
append, SATA PMP, etc.)
Which git repos i could try to build then ?

>
> thx,
>
> Jason.
