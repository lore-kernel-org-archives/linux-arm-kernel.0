From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 10 Jul 2012 09:08:49 -0400
Subject: [PATCH 4 0/4] Add ability to set defaultless network device MAC
 addresses to deterministic computed locally administered values
In-Reply-To: <4FFC2712.9020208@warmcat.com>
References: <20120705024259.26317.16000.stgit@build.warmcat.com>
 <201207101437.54877.florian@openwrt.org> <4FFC2712.9020208@warmcat.com>
Message-ID: <1341925729.14828.17.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-07-10 at 20:58 +0800, "Andy Green (???)" wrote:
> On 10/07/12 20:37, the mail apparently from Florian Fainelli included:
> 

> Why should Ubuntu, Fedora etc stink up their OSes with Panda-specific 
> workarounds?  And Panda is not the only device with this issue.

Actually I think you just answered your own question ;-)

Anyway, I don't think an initrd solution is the best. Yeah, it's fine
for a work around, but then I need to go and screw with the initrd if it
doesn't have support for the board. If the network card already has a
MAC address, why should the kernel give it another *random* one?

This isn't a complex patch set, where the complexity should be put into
userspace. And it makes it very convenient for people that just want the
board to boot so they can test it. I'm not developing any SoC or BSP,
I'm just using it to make sure my kernel changes can also be implemented
for ARM.

-- Steve
