From: joe@perches.com (Joe Perches)
Date: Tue, 13 Jan 2015 09:17:59 -0800
Subject: [PATCH] mISDN: avoid arch specific __builtin_return_address call
In-Reply-To: <1816278.9Bv8N8K5IB@wuerfel>
References: <1816278.9Bv8N8K5IB@wuerfel>
Message-ID: <1421169479.9233.25.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-13 at 17:10 +0100, Arnd Bergmann wrote:
> Not all architectures are able to call __builtin_return_address().
> On ARM, the mISDN code produces this warning:
> 
> hardware/mISDN/w6692.c: In function 'w6692_dctrl':
> hardware/mISDN/w6692.c:1181:75: warning: unsupported argument to '__builtin_return_address'
>   pr_debug("%s: %s dev(%d) open from %p\n", card->name, __func__,

I didn't know that tidbit. Thanks.
