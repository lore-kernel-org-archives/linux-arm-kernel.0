From: Leonid.Yegoshin@imgtec.com (Leonid Yegoshin)
Date: Wed, 13 Jan 2016 11:02:35 -0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160113104516.GE25458@arm.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
Message-ID: <56969F4B.7070001@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2016 02:45 AM, Will Deacon wrote:
> On Tue, Jan 12, 2016 at 12:45:14PM -0800, Leonid Yegoshin wrote:
>>
> I don't think the address dependency is enough on its own. By that
> reasoning, the following variant (WRC+addr+addr) would work too:
>
>
> P0:
> Wx = 1
>
> P1:
> Rx == 1
> <address dep>
> Wy = 1
>
> P2:
> Ry == 1
> <address dep>
> Rx = 0
>
>
> So are you saying that this is also forbidden?
> Imagine that P0 and P1 are two threads that share a store buffer. What
> then?
>

I ask HW team about it but I have a question - has it any relationship 
with replacing MIPS SYNC with lightweight SYNCs (SYNC_WMB etc)? You use 
any barrier or do not use it and I just voice an intention to use a more 
efficient instruction instead of bold hummer (SYNC instruction). If you 
don't use any barrier here then it is a different issue.

May be it has sense to return back to original issue?

- Leonid
