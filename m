From: isdn@linux-pingi.de (isdn at linux-pingi.de)
Date: Fri, 4 Mar 2016 19:18:49 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <1659125.tHp8H942OG@wuerfel>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
 <56D7F62E.6050502@linux-pingi.de> <1659125.tHp8H942OG@wuerfel>
Message-ID: <56D9D189.8080206@linux-pingi.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.03.2016 um 16:24 schrieb Arnd Bergmann:
> On Thursday 03 March 2016 09:30:38 isdn at linux-pingi.de wrote:
>> Hi Arnd,
>> I fully agree and ack.
>> Thanks for the work.
>>
> 
> I actually did more patches that I ended up not submitting:
> 
> * move hisax to staging
> * remove i4l support from gigaset
> * move i4l core to staging
> 
> while I initially thought that i4l as a whole is not just unmaintained
> but also more or less unused, patch 19cebbcb04c8 ("isdn: Partially
> revert debug format string usage clean up") came in that indicated that
> there are still users that even send patches for hisax, and that
> made me doubt whether we could consider it obsolete enough.
> 
> Any thoughts on this? If you like, I can send those too.

I4L is still in use on some sides and here is no 100% replacement (net
via RAW IP mode, terminal via X.75).

This week I got some question from a big retail chain  in Germany about
migration. I never know that they are  using this stuff (for initial
setup of remote shops).

So I would not drop i4l yet, maybe we should propose this for 2018.
I4L is not so usefull for NT mode, which is very popular nowadays for
gateways into the new full IP world. Some design ins with mISDN here,
mostly in the embedded area.

> 
> My main motivation was to not have to fix up the ippp implementation
> when I move the compat ioctl handler from fs/compat_ioctl.c
> into drivers/net/ppp/ppp_generic.c, but I guess I can do that
> anyway as it seems that i4l never worked properly in compat mode.
> 
> 	Arnd
> 
> 
> 
> 
> 
