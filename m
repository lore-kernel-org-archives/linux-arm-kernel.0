From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 20 Sep 2013 23:08:08 +0200
Subject: [PATCH 01/26] ARM: nomadik: move mtu setup to clocksource init
In-Reply-To: <CACRpkdauZCi+BDGa9gAZq0eG1jzHBuym5RzzwfxxcCMCAFJZEg@mail.gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdZqm=3oed979Jyg7n+8KwW_-2AGv3OzJBTPN20ZH=Vc3Q@mail.gmail.com>
 <CACRpkdauZCi+BDGa9gAZq0eG1jzHBuym5RzzwfxxcCMCAFJZEg@mail.gmail.com>
Message-ID: <523CB938.8000104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2013 10:51 PM, Linus Walleij wrote:
> On Fri, Sep 20, 2013 at 10:49 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Wed, Sep 18, 2013 at 7:53 PM, Sebastian Hesselbarth
>> <sebastian.hesselbarth@gmail.com> wrote:
>>
>>> MTU timer initialization is stuffed into .init_time callback, while
>>> cpu8815_timer_init_of again maps addresses from the same device node.
>>> Therefore, this patch moves mtu setup from to clocksource init.
>>>
>>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>
>> Another happy Nomadik user? Or are you just compile testing
>> this?

Linus,

I am not using nomadik but just though it could be integrated
in this patch set easily. Well, looks like I was at least not
that right ;)

>> Actually, this is superceded and collides with this pending fix:
>> http://marc.info/?l=linux-arm-kernel&m=137910161418706&w=2
>>
>> We should wait for that to hit mainline and then see what we want
>> to do with this.
>
> By the way - this can *definately* not be moved into the MTU
> driver as it is pertaining to clocks, not the timer using it.
>
> As nmdk_timer_init() can also be called from the ux500 which
> does not want to do this, things get broken for ux500.

Ok, well I was looking at v3.12-rc1 and did not really follow other
nomadik related threads. That time ux500 wasn't tangled up with
clk-nomadik.

As you ACK'd the remaining patches and therefore the general approach,
I will have a look at nomadik and the above changes again while waiting
for some other ACKs.

But as nomadik seems to be trickier than I initially thought and I
don't  come with a clean solution in time, are you also ok with
dropping nomadik now and get back to it later? As long as you have a
custom .init_time, everything is safe for nomadik.

Sebastian
