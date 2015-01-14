From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Jan 2015 12:35:22 +0100
Subject: [PATCH] arm64: kill off the libgcc dependency
In-Reply-To: <20150114104826.GD4050@arm.com>
References: <1421231934-31720-1-git-send-email-haokexin@gmail.com>
 <20150114104826.GD4050@arm.com>
Message-ID: <3138622.1rQcFu1jAj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 January 2015 10:48:26 Will Deacon wrote:
> On Wed, Jan 14, 2015 at 10:38:54AM +0000, Kevin Hao wrote:
> > The arm64 doesn't depend on the libgcc to build the vmlinux image.
> 
> Yes it does; we make use of __builtin_* for our bitops, for example.
> The compiler guys don't guarantee that these will be inlined.

Is that an architecture-specific statement?

The debate has been going on for ages in Linux, most architecture
maintainers however decided against using libgcc and copy the functions
that are actually needed into the kernel sources.

	Arnd
