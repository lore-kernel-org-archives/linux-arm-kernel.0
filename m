From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 20 Nov 2013 20:22:31 +0100
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
References: <20131112083633.GB10318@1wt.eu> <87a9hagex1.fsf@natisbad.org>
 <20131112100126.GB23981@1wt.eu> <87vbzxd473.fsf@natisbad.org>
 <20131113072257.GB10591@1wt.eu> <20131117141940.GA18569@1wt.eu>
 <1384710098.8604.58.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131120171227.GG8581@1wt.eu> <20131120173436.GK8581@1wt.eu>
 <1384969222.10637.20.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131120181532.GM8581@1wt.eu>
Message-ID: <87bo1eq3ns.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Willy Tarreau <w@1wt.eu> writes:

> On Wed, Nov 20, 2013 at 09:40:22AM -0800, Eric Dumazet wrote:
>> On Wed, 2013-11-20 at 18:34 +0100, Willy Tarreau wrote:
>> 
>> > One important point, I was looking for the other patch you pointed
>> > in this long thread and finally found it :
>> > 
>> > > So
>> > > http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=98e09386c0ef4dfd48af7ba60ff908f0d525cdee
>> > > 
>> > > restored this minimal amount of buffering, and let the bigger amount for
>> > > 40Gb NICs ;)
>> > 
>> > This one definitely restores original performance, so it's a much better
>> > bet in my opinion :-)
>> 
>> I don't understand. I thought you were using this patch.
>
> No, I was on latest stable (3.10.19) which exhibits the regression but does
> not yet have your fix above. Then I tested the patch your proposed in this
> thread, then this latest one. Since the patch is not yet even in Linus'
> tree, I'm not sure Arnaud has tried it yet.

This is the one I have used for a week now, since its publication by
Eric a week ago:

 http://www.spinics.net/lists/netdev/msg257396.html

Cheers,

a+
