From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 09:31:03 +0200
Subject: [PATCH 1/4] ARM: rockchip: rk3288: Switch to use the proper PWM IP
In-Reply-To: <CAD=FV=U6S3idZds57G2itFw6mdb-fTVt41Lv_jpBuNuq0fimnA@mail.gmail.com>
References: <1408381749-14156-1-git-send-email-dianders@chromium.org>
 <20140820153801.GB3427@ulmo>
 <CAD=FV=Xf4Hm5tCaaW3QG-ZSQGovh6RKH=1Og1K-yxj+jKyGsmA@mail.gmail.com>
 <2927513.T62GI7nq9T@phil> <20140821063637.GB4486@ulmo>
 <CAD=FV=XKr0T-mwma1WdTKQDVyS06rbj3=J4GwbAkc1KsXQspOw@mail.gmail.com>
 <20140821164705.GA1172@ulmo>
 <CAD=FV=U6S3idZds57G2itFw6mdb-fTVt41Lv_jpBuNuq0fimnA@mail.gmail.com>
Message-ID: <20140826073055.GD15573@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 04:40:57PM -0700, Doug Anderson wrote:
[...]
> I was doing some thinking about what to do, then.  I wondered whether
> the right thing to do is not to make a "rk3288 syscon" driver that
> configures these bits, but rather to make a "rk3288" driver has access
> to the syscon.  It could live in drivers/soc/rockchip/rk3288.c and we
> could give it a handle to the syscon.  It could do the one-time
> initialization.  It would also be a place to put special rk3288 APIs
> in cases where other drivers need similar things.
> 
> What do you think?

Yes, that could work. There have been recent discussions about adding
such machine drivers that match on the top-level compatible string in
the DT.

I still think that subclassing syscon would be the cleanest solution,
though.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/d26f983c/attachment-0001.sig>
