From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 19 Apr 2013 23:42:53 +0800
Subject: [PATCH 4/4] ARM: mmp: add SMP support for pxa988
In-Reply-To: <20130419140938.GT14496@n2100.arm.linux.org.uk>
References: <1365651547-11583-1-git-send-email-zhangwm@marvell.com>
 <CAN1soZxCX1oUg69MTy0ZAL2vH8SOywDBaZHJ7wgnwgasxPAPdQ@mail.gmail.com>
 <20130419140938.GT14496@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZwsC6yjH3nG7zUvRf9x9SLuEC4b9DtqsTGWQhacu78EbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 10:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Apr 13, 2013 at 09:08:12PM +0800, Haojian Zhuang wrote:
>> On Thu, Apr 11, 2013 at 11:39 AM, Neil Zhang <zhangwm@marvell.com> wrote:
>> > +       /*
>> > +        * Synchronise with the boot thread.
>> > +        */
>> > +       spin_lock(&boot_lock);
>> > +       spin_unlock(&boot_lock);
>> Lock & unlock without protecting anything. If so, you can remove this.
>
> ... which means you don't understand what is going on in this code,
> and probably didn't read the comment above this fragment.  The above
> is to synchronise with the code below - again, read the comment at
> the spin unlock in this function, remembering that the above code
> and the code below runs concurrently on two different CPUs:
>
Yes, I misunderstood it. Thanks for your correction.

Regards
Haojian
