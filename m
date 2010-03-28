From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 28 Mar 2010 00:18:20 +0000
Subject: [PATCH 1/1] [RFCv2] arm: add half-word __xchg
In-Reply-To: <20100328001429.GA16697@shareable.org>
References: <20100318135008.GA11800@Krystal>
	<1269535366-25175-1-git-send-email-virtuoso@slind.org>
	<20100327225240.GC13203@n2100.arm.linux.org.uk>
	<20100328001429.GA16697@shareable.org>
Message-ID: <20100328001819.GF13203@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 28, 2010 at 12:14:29AM +0000, Jamie Lokier wrote:
> But seeing as this is for ARM only at present, I'd just change the
> types to u32 and be done with it.  It does seem like a good thing to
> go to asm-generic eventually though.

Which is why having it use __alignof__ now would be a good idea - it
avoids someone blindly copying the code and then there being a subtle
bug in it.

I was wondering if a generic PTR_ALIGN(type, ptr) macro would be a
good idea too.
