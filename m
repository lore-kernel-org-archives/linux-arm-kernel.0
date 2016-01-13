From: davem@davemloft.net (David Miller)
Date: Tue, 12 Jan 2016 21:43:15 -0500 (EST)
Subject: [PATCHv2] net: bpf: reject invalid shifts
In-Reply-To: <1452651098.1223.41.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1452641302.1223.35.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160112234707.GA36167@ast-mbp.thefacebook.com>
 <1452651098.1223.41.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <20160112.214315.2135966842775837844.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 12 Jan 2016 18:11:38 -0800

> As I said, it is possible some guys never noticed their BPF program
> were 'broken' because this invalid shift was hidden in a dead code
> part.

We should not hide bugs and unintended uses of operations with
undefined behavior.
