From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jan 2015 22:39:22 +0000
Subject: Embedded white space in out-of-tree module full pathname
In-Reply-To: <54C75E09.6050002@free.fr>
References: <54C75E09.6050002@free.fr>
Message-ID: <20150127223922.GQ26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 10:44:41AM +0100, Mason wrote:
> I'd like some confirmation that this is either not supported, or that
> I'm doing something obviously wrong. (Kernel 3.14 if it matters.)

It's something which isn't going to be supported.

Various things in the make makes it difficult - for example:

module-dirs := $(addprefix _module_,$(KBUILD_EXTMOD))

and as per your example, addprefix will see "/tmp/foo" and "bar/module"
as two separate words.  make has no way to know that these are one
path rather than two separate paths.

See the addprefix documentation in make's info pages, which splits the
second argument by whitespace.

Unlike shell, where you have IFS= which can change the word splitting,
make always uses white space.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
