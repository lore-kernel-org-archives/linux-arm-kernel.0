From: jamie@shareable.org (Jamie Lokier)
Date: Sun, 28 Mar 2010 22:47:09 +0100
Subject: Query about Float Point Operation
In-Reply-To: <tencent_294E932A6E12E0191CF4271B@qq.com>
References: <tencent_294E932A6E12E0191CF4271B@qq.com>
Message-ID: <20100328214709.GA14740@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

??? wrote:
> WOW
> My audio codec drivers use float point operation heavily!
> Does that mean that I can ONLY implement it on USER space ?

It's not impossible, but it's quite complicated, not supported
(no need), and architecture-dependent.

Anyway, codecs should be done in userspace.  That's how Linux does
software codecs.  Only audio output, or passing raw data to an audio
DSP, needs to happen in kernel space.

-- Jamie
