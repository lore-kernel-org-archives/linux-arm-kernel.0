From: starnight@g.ncu.edu.tw (Jian-Hong Pan)
Date: Tue, 6 Nov 2018 22:28:18 +0800
Subject: [PATCH V2 2/7] net: lorawan: Add LoRaWAN socket module
In-Reply-To: <20181105.101610.1437737564548154497.davem@davemloft.net>
References: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
 <20181105165544.5215-3-starnight@g.ncu.edu.tw>
 <20181105.101610.1437737564548154497.davem@davemloft.net>
Message-ID: <CAC=mGzh3KH5H6zAOb_rZvjkYycGcJ=99bJreRzKtgVGS==K8qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Miller <davem@davemloft.net> ? 2018?11?6? ?? ??2:16???
>
> From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> Date: Tue,  6 Nov 2018 00:55:40 +0800
>
> > +static inline struct lrw_mac_cb * mac_cb(struct sk_buff *skb)
>
> "mac_cb()" is pretty generic for a name, and leads to namespace pollution,
> please use lrw_mac_cb() or similar.
>
> > +static inline struct dgram_sock *
> > +dgram_sk(const struct sock *sk)
> > +{
> > +     return container_of(sk, struct dgram_sock, sk);
> > +}
> > +
> > +static inline struct net_device *
> > +lrw_get_dev_by_addr(struct net *net, u32 devaddr)
>
> Never use inline for functions in a foo.c file, let the compiler decide.
>
> > +{
> > +     struct net_device *ndev = NULL;
> > +     __be32 be_addr = cpu_to_be32(devaddr);
>
> Always order local variables from longest to shortest line.
>
> > +static int
> > +dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > +           int noblock, int flags, int *addr_len)
> > +{
> > +     struct sk_buff *skb;
> > +     size_t copied = 0;
> > +     DECLARE_SOCKADDR(struct sockaddr_lorawan *, saddr, msg->msg_name);
> > +     int err;
>
> Likewise.
>
> I'm not going to point out every single place where you have made these
> two errors.
>
> Please audit your entire submission and fix the problems wherever they
> occur.

Thanks for the reviewing.  I will check the submission again.

Jian-Hong Pan
