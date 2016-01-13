From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 12 Jan 2016 20:07:44 -0800
Subject: [PATCHv2] net: bpf: reject invalid shifts
In-Reply-To: <20160112.214315.2135966842775837844.davem@davemloft.net>
References: <1452641302.1223.35.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160112234707.GA36167@ast-mbp.thefacebook.com>
 <1452651098.1223.41.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160112.214315.2135966842775837844.davem@davemloft.net>
Message-ID: <1452658064.1223.58.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-01-12 at 21:43 -0500, David Miller wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Tue, 12 Jan 2016 18:11:38 -0800
> 
> > As I said, it is possible some guys never noticed their BPF program
> > were 'broken' because this invalid shift was hidden in a dead code
> > part.
> 
> We should not hide bugs and unintended uses of operations with
> undefined behavior.

   JUMP 2:
   SHR  45
2: RET  10


was a valid program.

But a dumb loader decided to know better.
 
