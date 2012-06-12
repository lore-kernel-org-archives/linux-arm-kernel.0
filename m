From: joe@perches.com (Joe Perches)
Date: Tue, 12 Jun 2012 10:40:12 -0700
Subject: [PATCH v2] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <4FD77CAF.1020402@zytor.com>
References: <1339470307-28223-1-git-send-email-tmac@hp.com>
 <20120612191804.4211462a@tukaani.org>
 <alpine.LFD.2.02.1206121316190.23555@xanadu.home>
 <4FD77CAF.1020402@zytor.com>
Message-ID: <1339522812.2404.4.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 10:30 -0700, H. Peter Anvin wrote:
> On 06/12/2012 10:26 AM, Nicolas Pitre wrote:
> > 
> > Instead of copying, maybe this would be much better to make the content 
> > of lib/string.c usable in a pre-boot environment.

> Not sure about that... a lot of it is #ifndef __HAVE_ARCH_* and you
> *really* want those optimizations on some arches.

Can __weak be used?
