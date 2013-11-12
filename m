From: xiyou.wangcong@gmail.com (Cong Wang)
Date: Tue, 12 Nov 2013 06:48:59 +0000 (UTC)
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
References: <8761s0cqhh.fsf@natisbad.org>
Message-ID: <slrnl83jr5.49f.xiyou.wangcong@linux-6brj.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 10 Nov 2013 at 13:53 GMT, Arnaud Ebalard <arno@natisbad.org> wrote:
> Hi,
>
> I decided to upgrade the kernel on one of my ReadyNAS 102 from 3.11.1 to 
> 3.11.7. The device is based on Marvell Armada 370 SoC and uses mvneta
> driver. Mine runs Debian armel unstable but I can confirm the issue also
> happens on a debian harmhf unstable.
>
[...]
>
> Then, knowing that, I started a git bisect session on stable tree to end
> up with the following suspects. I failed to go any further to a single
> commit, due to crashes, but I could recompile a kernel w/ debug info and
> report what I get if neeeded.
>
> commit dc0791aee672 tcp: do not forget FIN in tcp_shifted_skb()     [bad]
> commit 18ddf5127c9f tcp: must unclone packets before mangling them
> commit 80bd5d8968d8 tcp: TSQ can use a dynamic limit
> commit dbeb18b22197 tcp: TSO packets automatic sizing
> commit 50704410d014 Linux 3.11.6                                    [good]
>

This regression is probably introduced the last TSQ commit, Eric has a patch
for mvneta in the other thread:

http://article.gmane.org/gmane.linux.network/290359
