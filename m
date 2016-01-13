From: davem@davemloft.net (David Miller)
Date: Tue, 12 Jan 2016 21:45:07 -0500 (EST)
Subject: [PATCHv2] net: bpf: reject invalid shifts
In-Reply-To: <20160113022415.GA37041@ast-mbp.thefacebook.com>
References: <20160112234707.GA36167@ast-mbp.thefacebook.com>
 <1452651098.1223.41.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160113022415.GA37041@ast-mbp.thefacebook.com>
Message-ID: <20160112.214507.1913407550158910781.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Jan 2016 18:24:16 -0800

> If anyone wants to submit a patch that masks K &= 31, I would ok
> with it as well, but imo it's a disservice to classic bpf users.

This is how I feel as well.  I hate when some developer of a tool
thinks it's ok to silently let me do something which it can strictly
determine is questionable without my explicitly asking it to do so.
