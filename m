From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Thu, 19 Dec 2013 13:05:02 +0200
Subject: [PATCH v3 01/21 resend] serial: rewrite pxa2xx-uart to use
 8250_core
In-Reply-To: <1387447296.31516.37.camel@host5.omatika.ru>
References: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-2-git-send-email-ynvich@gmail.com>
 <20131219085145.GB20686@xps8300>
 <1387445713.31516.30.camel@host5.omatika.ru>
 <1387447296.31516.37.camel@host5.omatika.ru>
Message-ID: <20131219110502.GC20686@xps8300>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 02:01:36PM +0400, Sergei Ianovich wrote:
> On Thu, 2013-12-19 at 13:35 +0400, Sergei Ianovich wrote:
> > On Thu, 2013-12-19 at 10:51 +0200, Heikki Krogerus wrote:
> > > I noticed one more thing. I'm sorry about commenting this late.
> > > 
> > > Since you set the type PORT_XSCALE, don's you want to use
> > > UPF_FIXED_TYPE flag instead of the UPF_SKIP_TEST here? Otherwise the
> > > type will just get overridden and autoconfig() will be executed.
> > 
> > UPF_FIXED_PORT was my first guess. However, it didn't work.
> > 
> > I've also tried to do ioremap in serial_pxa_probe instead of using
> > UPF_IOREMAP. This didn't work as well.
> 
> I didn't clarify properly.
> 
> UPF_SKIP_TEST skips only the loopback test. This test could work on PXA,
> but requires PXA-specific pre-initialization. There are more test after
> the loopback one, which will fail if we are not on PXA. So I decided
> that skipping it is easier than tricky rewriting of autoconfig().

OK. So there is no problem here. Sorry about the noise.

Thanks,

-- 
heikki
