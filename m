From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 23 Oct 2013 20:30:02 +0530
Subject: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <20131023143657.GA31536@lunn.ch>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
 <CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
 <20131023135116.GC31126@lunn.ch>
 <CAKohpokTgCz0c=PeaJHKiZEiYc0jPVq-vwkhP5pM0hh1-0QnLA@mail.gmail.com>
 <20131023143657.GA31536@lunn.ch>
Message-ID: <CAKohpomedpd8XBPcdZX2vHy6b5=FMtbSVpNTG-eVLK1YPyPaMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 October 2013 20:06, Andrew Lunn <andrew@lunn.ch> wrote:
>> So, you have actually tested your code without interrupt handler?
>
> No.

It would be better if you atleast try this and confirm that this dummy
handler is required.

>> What exactly happens in that case?
>
> Take a look at request_threaded_irq(). It contains:
>
> 1421         if (!handler) {
> 1422                 if (!thread_fn)
> 1423                         return -EINVAL;
>
> So devm_request_irq() will fail, and so the probe function will fail.

Obviously I wanted you to remove all irq specific code and hence
devm_request_irq() :)
