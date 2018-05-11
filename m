From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 11 May 2018 14:16:50 +0100
Subject: [PATCH] drivers/perf: arm-ccn: stop spamming dmesg in event_init
In-Reply-To: <cee9c043-3d64-56b9-4f23-e8c8370387dd@gmail.com>
References: <20180504104117.8086-1-mark.rutland@arm.com>
 <20180508184050.75c60b82ba538d0ecdeb2d78@arm.com>
 <1525882003.4199.55.camel@arm.com>
 <20180509184154.9994df2874e7a08025b56dea@arm.com>
 <cee9c043-3d64-56b9-4f23-e8c8370387dd@gmail.com>
Message-ID: <1526044610.3315.93.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-05-10 at 01:22 +0100, Florian Fainelli wrote:
> I don't have any dog in this, but maybe if providing information to
> the
> users is so essential to having a pleasant user experience, then
> rethinking the whole way these messages are funneled is necessary
> because the kernel log + dmesg is by no means appropriate. Take a look
> at what the networking maintainers recently did with netlink extended
> ack. You used to just get an "unsupported" error, and now you know
> exactly what is wrong when extack is available. It seems to me like
> something like this is what you might want here since you want to have
> perf be as user friendly as possible.
> 
> My 2 cents.

I couldn't agree more. I find the advice "check the dmesg, you may find
something there" that perf tool uses currently... well, pretty lame
(although this was exactly the reason I started dmesg-ing error details
in the first place).

One could play the "you're breaking userspace promise" card here, but
considering that the number of people actually using CCN PMU is...
small, I don't want to do this.

But so far no one was determined enough to get better error reporting
in place. I have ran out of time when I tried it 2 or 3 years ago, I
believe Kim has discussed some approaches and received pushback. Kim
would be better suited to summarize what has happened so far...

Regards

Pawe?
