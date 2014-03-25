From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Mar 2014 18:54:28 +0100
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <1395768102.12610.159.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1395670496-17381-1-git-send-email-zhangfei.gao@linaro.org>
 <21873900.AIOr1ryy37@wuerfel>
 <1395768102.12610.159.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <7101996.LQrASEuksF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 March 2014 10:21:42 Eric Dumazet wrote:
> On Tue, 2014-03-25 at 18:05 +0100, Arnd Bergmann wrote:
> > On Tuesday 25 March 2014 10:00:30 Florian Fainelli wrote:
> >
> > > Using a timer to ensure completion of TX packets is a trick that
> > > worked in the past, but now that the networking stack got smarter,
> > > this might artificially increase the processing time of packets in the
> > > transmit path, and this will defeat features like TCP small queues
> > > etc.. as could be seen with the mvneta driver [1]. The best way really
> > > is to rely on TX completion interrupts when those exist as they cannot
> > > lie about the hardware status (in theory) and they should provide the
> > > fastest way to complete TX packets.
> > 
> > By as Zhangfei Gao pointed out, this hardware does not have a working
> > TX completion interrupt. Using timers to do this has always just been
> > a workaround for broken hardware IMHO.
> 
> For this kind of drivers, calling skb_orphan() from ndo_start_xmit() is
> mandatory.

Cool, thanks for the information, I was wondering already if there was
a way to deal with hardware like this.

	Arnd
