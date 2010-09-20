From: mail@pawelmoll.com (Pawel Moll)
Date: Mon, 20 Sep 2010 11:38:44 +0100
Subject: [RFC] mmaping with VIVT cache
In-Reply-To: <20100917210649.GA18343@n2100.arm.linux.org.uk>
References: <589851.42712.qm@web120206.mail.ne1.yahoo.com>
	<20100917210649.GA18343@n2100.arm.linux.org.uk>
Message-ID: <a4e3b92bbd5f9f04fa06dd5d3f2f160a@cox.rootnode.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> However, in this case, architectures using VIPT aliasing caches will
> also trip over it - has anyone used this webcam on something like
> Sparc or powerpc?  I'm guessing that it'll fail there too...

It wasn't a webcam but USB audio card, not sparc nor powerpc but sh but
the I believe problem stays the same - vmalloc-ed buffer mapped into the
user-space...

http://thread.gmane.org/gmane.linux.alsa.devel/55882/focus=7160

I've ended up with pgprot_noncached(), as there was no "alias-safe API"
available, and apparently it's still the case? ;-)

Cheers!

Pawe?
