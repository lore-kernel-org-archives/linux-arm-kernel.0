From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 25 Mar 2010 10:22:33 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <4BAA23E7.9010100@warmcat.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<4BA9D93E.50705@warmcat.com>
	<20100324113241.GC5831@opensource.wolfsonmicro.com>
	<4BAA017D.70503@warmcat.com>
	<20100324140101.GC26453@rakim.wolfsonmicro.main>
	<4BAA23E7.9010100@warmcat.com>
Message-ID: <20100325102232.GC27729@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 24, 2010 at 02:38:31PM +0000, Andy Green wrote:
> On 03/24/10 14:01, Somebody in the thread at some point said:

> >I really am very sure that nobody has ever reported any issues here -

> There's plenty of out-of-tree code.  I'm not trying to blame you for

I'm really wary of trusting out of tree reports since a high proportion
of the time they turn out to be due to people not being aware of some
existing support or things like API misuse.  New issues do crop up, but
anecdotes about issues that have been diagnosed but not reported need to
be taken with a grain of salt.

Like I say, the regulator drivers just don't do anything in suspend
in mainline which means that ordering issues from them seem a bit
suspicious.
