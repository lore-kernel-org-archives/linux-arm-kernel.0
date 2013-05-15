From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 May 2013 10:37:13 +0100
Subject: [PATCH] ARM: PL011: add support for extended FIFO-size of
 PL011-r1p5
In-Reply-To: <5193164E.6050400@wwwdotorg.org>
References: <007301ce375e$bcf6d6b0$36e48410$@lge.com>
 <5191D200.3040604@wwwdotorg.org> <01fd01ce5072$d6b9fcd0$842df670$@lge.com>
 <5192A692.4010700@wwwdotorg.org> <022d01ce5107$8bc668e0$a3533aa0$@lge.com>
 <5193164E.6050400@wwwdotorg.org>
Message-ID: <20130515093713.GJ18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 10:59:58PM -0600, Stephen Warren wrote:
> Well, that certainly isn't true in practice. I think we should revert
> this commit until we can determine what the problem is.
> 
> I validated that the periphid register in HW contains the r1p5 revision
> (3), and the pcellid register does indeed contain the expected
> 0xb105f00d value. However, if I run the following hacky code in U-Boot
> to determine the FIFO depth, it comes out as 16, which explains the
> symptoms I'm seeing:

We could do that, just like we do in 8250.c to check the FIFO depth.
There's not much harm in doing that at boot time, it just needs to be
done carefully so that it doesn't disrupt any existing use of the UART.
