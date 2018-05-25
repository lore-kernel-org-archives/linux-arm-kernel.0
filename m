From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 04:57:18 -0700
Subject: [GIT PULL] ARM: mvebu: arm for v4.18 (#1)
In-Reply-To: <87603m1lq9.fsf@bootlin.com>
References: <87603m1lq9.fsf@bootlin.com>
Message-ID: <20180525115718.o426ixt6bilonjnx@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 02:59:42PM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for arm for mvebu for v4.18.
> 
> As I feared, there were (trivial) merge issues due to the defconfig
> update in linux-next. The best place to solve them is in your tree, so
> as soon as you will pull this, I will remove from my mvebu/for-next
> branch.

Hmm. Yeah, this is because you took upon yourself to run 'make savedefconfig'
for all platforms on this shared defconfig. This will of course conflict with
everything everywhere, and it doesn't seem like a good idea to do this way.

What you're really doing here is turning on one single option? Just do that.

We can run savedefconfig at the end of a merge window here instead of having
one of the platform maintainers do it.

So, feel free to send just the NAND patch, and I can fix it up when I apply it
if needed.

Thanks!


-Olof
