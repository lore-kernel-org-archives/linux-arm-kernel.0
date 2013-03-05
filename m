From: walken@google.com (Michel Lespinasse)
Date: Mon, 4 Mar 2013 17:37:09 -0800
Subject: [PATCH V2] lglock: add read-preference local-global rwlock
In-Reply-To: <20130303174056.GA30176@redhat.com>
References: <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com>
 <512E7879.20109@linux.vnet.ibm.com> <5130E8E2.50206@cn.fujitsu.com>
 <20130301182854.GA3631@redhat.com>
 <CANN689HEW=b5S93J27p+rBX-5m7jkW4FER=eHDCp7OgMaTWLPw@mail.gmail.com>
 <5131FB4C.7070408@cn.fujitsu.com>
 <20130302172003.GC29769@redhat.com>
 <20130303174056.GA30176@redhat.com>
Message-ID: <CANN689F6RHCtDAiBGu=n60UKUEE5Ld50gkwS3rNdE2GN2+v3nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 3, 2013 at 9:40 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> However, I still think that FALLBACK_BASE only adds the unnecessary
>> complications. But even if I am right this is subjective of course, please
>> feel free to ignore.

Would it help if I sent out that version (without FALLBACK_BASE) as a
formal proposal ?

> Hmm. But then I do not understand the lglock annotations. Obviously,
> rwlock_acquire_read() in lg_local_lock() can't even detect the simplest
> deadlock, say, lg_local_lock(LOCK) + lg_local_lock(LOCK). Not to mention
> spin_lock(X) + lg_local_lock(Y) vs lg_local_lock(Y) + spin_lock(X).
>
> OK, I understand that it is not easy to make these annotations correct...

I am going to send out a proposal to fix the existing lglock
annotations and detect the two cases you noticed. It's actually not
that hard :)

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
