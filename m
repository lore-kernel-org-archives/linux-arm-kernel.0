From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 12 Jan 2016 18:11:38 -0800
Subject: [PATCHv2] net: bpf: reject invalid shifts
In-Reply-To: <20160112234707.GA36167@ast-mbp.thefacebook.com>
References: <20160112185121.GA34045@ast-mbp.thefacebook.com>
 <1452626228-15742-1-git-send-email-rabin@rab.in>
 <1452628118.1223.25.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160112195356.GA34598@ast-mbp.thefacebook.com>
 <5695653F.6030001@iogearbox.net>
 <20160112204620.GA35080@ast-mbp.thefacebook.com>
 <1452641302.1223.35.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160112234707.GA36167@ast-mbp.thefacebook.com>
Message-ID: <1452651098.1223.41.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-01-12 at 15:47 -0800, Alexei Starovoitov wrote:

> I would agree if those loaded programs would do something sensible,
> but they're broken. As shown arm and arm64 would execute them
> differently without JIT, because HW treats such shifts differently.
> I also checked that libpcap is sane and doesn't generate broken shifts.
> imo we're not breaking backward compatiblity here.
> 

How did you prove a particular code path was even taken in a BPF
program ? This is new to me.

As I said, it is possible some guys never noticed their BPF program were
'broken' because this invalid shift was hidden in a dead code part.

So a program might appear as 'weak' when in fact its behavior was
absolutely correct.

You assume everybody uses libpcap, this is wrong, and for very obvious
reasons.

Try to encode the QUEUE, RXHASH, or CPU instructions in libpcap, for a
start.
