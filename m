From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 15 Oct 2015 12:22:24 -0600
Subject: [PATCH] mtd: document linux-specific partition parser DT binding
In-Reply-To: <20151015174709.GB108923@google.com>
References: <1444915191-28350-1-git-send-email-linus.walleij@linaro.org>
 <20151015162210.GA4545@localhost>
 <20151015170428.GA9250@obsidianresearch.com>
 <20151015174709.GB108923@google.com>
Message-ID: <20151015182224.GB17519@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 10:47:09AM -0700, Brian Norris wrote:
> Hmm, I don't know. I wouldn't expect people should really be using
> cmdlineparts as a production solution, but I'd consider it more of a
> debugging/development option -- if I want to override the DT (which is
> sometimes a bit harder to change) or the on-flash layout (e.g.,
> RedBoot), then I can fiddle with the command line.

We don't have cmdline overrides for very much (if any?) of DT.

The DT is supposed to describe the hardware/boot environment, if
overriding the partition layout is really common, then is the DT
binding really describing the hardware at all?

The partition layout is already very border line to support in DT, it
is really very close to a software configuration which is strongly
discouraged from DT files.

I justify it as the boot loader communicating the partition scheme it
understands to the OS, so the OS can have a hope of setting up the
flash in a way the bootloader understands.

I've never used the cmdline option, so maybe I don't see the use case,
but it seems like a really weird desire to change the partitioning
away from what the bootloader supports.

> Any better nominations for names?

bcrm-part-table-43 ?

Jason
