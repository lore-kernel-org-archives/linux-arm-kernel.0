From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue, 17 Nov 2015 10:58:54 -0800
Subject: [PATCH 1/8] Documentation/spi/spidev_test.c: use one rx buffer
In-Reply-To: <20151117174156.GX31303@sirena.org.uk>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <2f17ae29e75967b4522b080c275b907622e1d353.1447773299.git.stillcompiling@gmail.com>
 <20151117174156.GX31303@sirena.org.uk>
Message-ID: <2858640.EtAPBOce2G@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 17, 2015 05:41:56 PM Mark Brown wrote:
> On Tue, Nov 17, 2015 at 07:24:21AM -0800, Joshua Clayton wrote:
> 
> > default_rx and rx are needlessly different.
> > Use one buffer, local to transmit()
> 
> Why?  This isn't what I'd expect from black boxing the API, from a
> userspace point of view the transfer is atomic and in an ideal world
> we'd be able to do direct to/from memory transfers rather than memcpy()
> into kernel space which means that userspace should assume the transfers
> are going on simultaneously even if they don't currently.

The important thing here was to get rid of the default_rx buffer.
I just noticed that the output can be set up completely within the scope
of the transmit function, since the operands are global. But I would be
just as happy to set it up at the top level. I'll change this in V2

--
~Joshua Clayton
