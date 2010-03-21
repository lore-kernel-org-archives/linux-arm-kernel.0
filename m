From: jamie@shareable.org (Jamie Lokier)
Date: Sun, 21 Mar 2010 17:16:34 +0000
Subject: [PATCH] MTD: Fix Orion NAND driver compilation with ARM OABI
In-Reply-To: <1269086286.4028.6039.camel@macbook.infradead.org>
References: <20100320085507.4038.96426.stgit@pauliusz>
	<1269078083.4028.5586.camel@macbook.infradead.org>
	<badfd5ba1003200420xc0680c1h8b4cccd02a8fdaba@mail.gmail.com>
	<1269086286.4028.6039.camel@macbook.infradead.org>
Message-ID: <20100321171634.GB4174@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Woodhouse wrote:
> Strictly speaking, I think your version is wrong -- although you force
> the variable 'x' to be stored in r2/r3, you don't actually force GCC to
> use r2/r3 as the output registers for the asm statement -- it could
> happily use other registers, then move their contents into r2/r3
> afterwards.

We used to do that a lot in the syscall macros in <asm/unistd.h>, on a
lot of architectures.  Were they all broken?

> Obviously it _won't_ do that most of the time, but it _could_. GCC PR
> #15089 was filed for the fact that sometimes it does, but I think Nico
> was missing the point -- GCC is _allowed_ to do that, and if it makes
> you sad then you should be asking for better assembly constraints which
> would allow you to tell it not to.
