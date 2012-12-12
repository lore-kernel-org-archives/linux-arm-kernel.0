From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 12 Dec 2012 15:50:44 -0600
Subject: Coresight bus and drivers from CodeAurora
In-Reply-To: <CACRpkdYYhAyLXJL6ns5mfFQOethihabfPpPuqz9Unq_SCJqLig@mail.gmail.com>
References: <CACRpkdYeFw3YqYqgNAKUv1U4edyzzUa9x6xBSoBU4BbBoc6q5Q@mail.gmail.com>
 <20121211213916.GB7214@pratikp-linux.qualcomm.com>
 <CACRpkdYYhAyLXJL6ns5mfFQOethihabfPpPuqz9Unq_SCJqLig@mail.gmail.com>
Message-ID: <50C8FC34.3010505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/12/2012 02:00 AM, Linus Walleij wrote:
> On Tue, Dec 11, 2012 at 10:39 PM, Pratik Patel <pratikp@codeaurora.org> wrote:
> 
>> Thanks for the quick evaluation. I will be working on cleaning up
>> the drivers for upstream submission in the coming weeks.
> 
> This is exactly what I like to hear :-)
> 
> Can you preserver the CC line from this mail on your subsequent
> posts so the involved experts can follow the discussions?
> 
> It seems like keeping this new framework in drivers/ and actually refactoring
> the old stuff in arch/arm/kernel/etm.c etc is the way forward, but doing that
> may require some patch to support the old style of things. As the older code
> may be stale maybe just depend on !CONFIG_OC_ETM is a way forward.

I have also been working to migrate the coresight cross-trigger
interface (CTI) helpers from Ming Lei to a driver [1]. In the current
implementation I have opted to make the CTI driver an AMBA device (like
the existing ETM and ETB drivers). Therefore, I am curious if the plan
is to migrate these other coresight devices to AMBA versus adding this
new coresight bus?

It would be good to align on a plan here for coresight devices in general.

Cheers
Jon

[1] https://github.com/jonhunter/linux/commits/dev-cti
