From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Jan 2018 19:26:11 +0000
Subject: [PATCH v3 02/13] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0
 kconfig entry
In-Reply-To: <20180109171700.GA18100@infradead.org>
References: <1515432758-26440-1-git-send-email-will.deacon@arm.com>
 <1515432758-26440-3-git-send-email-will.deacon@arm.com>
 <20180109171700.GA18100@infradead.org>
Message-ID: <20180110192610.GB9723@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 09:17:00AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 08, 2018 at 05:32:27PM +0000, Will Deacon wrote:
> > Although CONFIG_UNMAP_KERNEL_AT_EL0 does make KASLR more robust, it's
> > actually more useful as a mitigation against speculation attacks that
> > can leak arbitrary kernel data to userspace through speculation.
> > 
> > Reword the Kconfig help message to reflect this, and make the option
> > depend on EXPERT so that it is on by default for the majority of users.
> 
> I still haven't heard an anwer on why this isn't using
> CONFIG_PAGE_TABLE_ISOLATION but instead reinvents its own symbol.

Mainly because this code was written before CONFIG_PAGE_TABLE_ISOLATION had
been proposed and I wanted to avoid confusion with the ongoing backports
just to align on the naming for an arch-specific config option. We could
CONFIG_PAGE_TABLE_ISOLATION and make it select CONFIG_UNMAP_KERNEL_AT_EL) if
you like, but worth noting that this is default 'y' anyway and depends on
EXPERT.

Will
