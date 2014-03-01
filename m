From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 1 Mar 2014 15:35:22 -0800
Subject: ccf: where to put constraints?
In-Reply-To: <20140228212412.GD2517@katana>
References: <20140224201046.GA13155@katana>
 <8e8ce023-b9a4-41a5-b06c-0f6d934f22e6@VA3EHSMHS020.ehs.local>
 <20140228212412.GD2517@katana>
Message-ID: <CAPtuhTjc3HUO+iAedQ64_A6oSNzp8WNfggdH2aJmnVzj2A2wNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 1:24 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Hi S?ren,
>
>> I.e. when a clock consumer needs to be notified about its input clock
>> being changed it registers a clock notifier.
>
> I found the notifiers, too, but I am still not sure they are proper for
> my case. There, CPU and GPU clocks are siblings, there is no
> parent-child relationship.

Hi Wolfram,

No parent-child relationship is required. The cpufreq driver you have
in mind could subscribe to notifiers for both your GPU clock as well
as your CPU clock and listen for any changes, waiting to take action.

Regards,
Mike

>
> Anyhow, I have been told cpufreq is not needed currently, so this task
> is postponed. Thanks for the input nonetheless!
>
>    Wolfram
>
