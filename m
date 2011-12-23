From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 22 Dec 2011 22:20:45 -0500 (EST)
Subject: init_kprobes() takes too much time during boot up
In-Reply-To: <CAMPhdO8T5wwPBYp_n15A88o8YxkXv2t8WOumRyni6WDhJinS3A@mail.gmail.com>
References: <CAMPhdO8T5wwPBYp_n15A88o8YxkXv2t8WOumRyni6WDhJinS3A@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1112222212140.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Dec 2011, Eric Miao wrote:

> I was trying to improve the kernel boot performance of the boards at
> my hands, while simply turning on initcall_debug, and found that
> init_kprobes() won the crown of being the most hungry time gobbler.
> 
> Before I take my time to look into why it's taking so much time, I'd
> post the question to the list to seek help first.

>From a quick glance, the "Lookup and populate the kprobe_blacklist" 
loops certainly have the potential to be costly.

There is nothing with notable complexity in the ARM specific part.

CC'ing Tixy in case he has a better idea.


Nicolas
