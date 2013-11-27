From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 26 Nov 2013 20:07:23 -0800
Subject: [PATCH 00/23] mtd: st_spi_fsm: Add new device
In-Reply-To: <1385137380-28968-1-git-send-email-lee.jones@linaro.org>
References: <1385137380-28968-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20131127040723.GZ9468@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Huang, Mark, SPI list

There seem to be multiple efforts going on that are vaguely related. I'd
like to see more of the same people appearing on the CC list, to keep
better coordinated.

On that topic, is the SPI dev list relevant, or would anybody working on
the intersection of SPI and MTD be on the MTD list?

On Fri, Nov 22, 2013 at 04:22:37PM +0000, Lee Jones wrote:
> The first bunch of these patches have been on the MLs before, but 
> didn't receive a great deal of attention for the most part. We are
> a little more featureful this time however. We can now successfully
> setup and configure the N25Q256. We still can't read/write/erase
> it though. I'll start work on that next week and will provide it in
> the next instalment.

What happened to integrating a SPI NOR framework? I see you copied some
of the m25p80 commands, but you don't share them with m25p80. I also
understand your argument (from the first version of this patch series)
that much of the actual controller operation is not shared with m25p80,
but you'd be surprised how this might evolve. There are several others
with QSPI hardware that are trying to get patches merged, some of whom
(Huang, at least) are actively submitting patches to help with this
abstraction.

Now, I haven't had a lot of time yet to look at both yours and Huang's
work and see what, if anything, can be shared (will do soon). But I
think you need to be aware.

BTW, can you include version markers (i.e., [PATCH v2 X/Y]) in the
subject from now on?

Brian
