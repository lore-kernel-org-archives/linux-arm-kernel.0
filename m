From: ben-i2c@fluff.org (Ben Dooks)
Date: Tue, 04 Jan 2011 01:01:50 +0000
Subject: mc13xxx core support for i2c
In-Reply-To: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <4D22717E.90003@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/12/10 03:50, Marc Reilly wrote:
> These patches add i2c support for the mc13xxx-core driver. This v3 improves the v2
> (http://lists.arm.linux.org.uk/lurker/message/20101215.214755.b6bae366.en.html) by splitting
> the driver up into core, spi and i2c files so that it can support one subsystem in the absence
> of the other.

As noted by others, this needs to be re-worked so that the driver can
always been built and used across bisections.

A suggested approach would be to move items out into the header file
first, and then maybe split the spi driver out of the core, and then
add the I2c driver. It may also make the patch set easier to follow.
