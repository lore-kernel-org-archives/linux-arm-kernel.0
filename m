From: ethan@ethantuttle.com (Ethan Tuttle)
Date: Mon, 16 Sep 2013 20:43:19 -0700
Subject: mvneta: oops in __rcu_read_lock on mirabox
In-Reply-To: <20130916182807.GO12758@n2100.arm.linux.org.uk>
References: <CACzLR4tTvt+ROEhkXUCQhV6=bPPTX4LFSkWfrEhF+OdM1Jm1Rw@mail.gmail.com>
 <20130915205701.5c61a444@skate> <20130916065047.GH27487@1wt.eu>
 <20130916175152.4e013457@skate>
 <CACzLR4twTNjzU8hK3L1cYUXnEH1ydwY6jnYoOG+9vLB3-4uQ4w@mail.gmail.com>
 <20130916163937.GC3188@1wt.eu> <20130916164412.GD3188@1wt.eu>
 <CACzLR4ssOPsmYaEh2ohe4HL5j+67keDYnmR4YezNB=aO7Pj5kA@mail.gmail.com>
 <20130916174708.GG3188@1wt.eu>
 <20130916182807.GO12758@n2100.arm.linux.org.uk>
Message-ID: <CACzLR4suLD90p=sEhB-qg1u35t66zKfrGQref1jX42fEfu3D8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I just built 3.11.1 with the posted config and got the usual crash in
about 2 minutes with a ping flood.

The kernel image is available here:

https://www.dropbox.com/s/cqkqop3jjb1stk3/uImage-dtb.armada-370-mirabox

The md5 is 05f350a193c6c60d9dac40bea810bbdd.  You may notice the
version string reveals a patch on top of 3.11.1, this is just a
makefile patch to "Build a uImage with dtb already appended".

Tcpdump captured about 2,800 icmp packets per second while the ping
flood was running.

Hope this helps!  If Willy wants to share a kernel image I'll see if I
can crash it :)

Thanks,

Ethan

On Mon, Sep 16, 2013 at 11:28 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 16, 2013 at 07:47:08PM +0200, Willy Tarreau wrote:
>> I'll have to rebuild with your config and exact 3.11 to test again.
>> Can you check the packet rate of your ping flood to give an order of
>> magnitude so that we're sure to be in the same conditions ?
>
> Also, try swapping kernel binaries between yourselves, so that you can
> be sure you're running the exact same kernel on different hardware.
