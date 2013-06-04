From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jun 2013 10:34:03 +0100
Subject: [RFC PATCH] ARM: update legacy CPU ID in decompressor cache
 support jump table
In-Reply-To: <CAO1A-8BtUvDELaPvTw_gG1MB4JdMUYt8rmVP2oy+YoJENTvW2Q@mail.gmail.com>
References: <CAO1A-8AaWyp6eq7c5nkU=KBxwrm1CM3erXcsxLmYpCn2mHhMUA@mail.gmail.com>
 <20130604003525.GI599@codeaurora.org>
 <CAO1A-8BtUvDELaPvTw_gG1MB4JdMUYt8rmVP2oy+YoJENTvW2Q@mail.gmail.com>
Message-ID: <20130604093403.GT18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 07:23:09PM -0700, Marc C wrote:
> Hi Russell,
> 
> Stephen pointed out a patch by Brian [1] which switches out the
> initial entry in the cache/MMU jump table so that ARM-v7 processors
> from non-ARM vendors can use the appropriate cache maintenance and MMU
> setup routines. Your response to an RFC [2] solves this problem
> without requiring adding an #if/#endif to boot.S. Which method would
> you prefer?
> 
> [1] - http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7736/1
> [2] - http://lists.infradead.org/pipermail/linux-arm-kernel/2010-January/007871.html

I'd actually prefer your method over removing it completely.
