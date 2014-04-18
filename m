From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Apr 2014 12:03:21 +0200
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <2664026.dY5rX8rfNU@typ>
References: <3748421.ND1tAjvgKS@typ> <1437066.E9nAxXbK6K@phil>
 <2664026.dY5rX8rfNU@typ>
Message-ID: <3654530.JEvxoLYNLf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 18. April 2014, 11:30:21 schrieb Max Schwarz:
> On Friday 18 April 2014 at 11:06:56, Heiko St?bner wrote:
> > > I think Heiko and I have been operating under the misconception that
> > > caching is somehow enabled by default - which is not the case. Thanks
> > > for
> > > clearing that up ;-)
> > 
> > Actually I think it's the other way around :-).
> > 
> > See regmap_read() calling _reagmap_read(), which in turn calls
> > regcache_read(), except when map->cache_bypass is enabled, which then
> > checks the volatile setting for the individual register.
> 
> But map->cache_bypass *is* enabled by regcache_init() in regcache.c when
> cache_type is REGCACHE_NONE, which is the default value:
> 
> if (map->cache_type == REGCACHE_NONE) {
> 	map->cache_bypass = true;
> 	return 0;
> }
> 
> You can see the behaviour in detail if you compile with event tracing and
> boot with trace_event=regmap:* .
> 
> If you think about it, it would be quite insane to enable caching in syscon
> without knowing anything about the registers.

yep, you're right of course ... now I see it too :-)

So we really can leave everything as it is now - and I can stop worrying about 
creating future issues with the soc_con registers :-)


Heiko
