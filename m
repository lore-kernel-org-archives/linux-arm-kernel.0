From: joshc@ni.com (Josh Cartwright)
Date: Wed, 11 Mar 2015 10:41:50 -0500
Subject: [PATCH v2] ARM: zynq: use restart_handler mechanism for slcr reset
In-Reply-To: <1425049769-24929-1-git-send-email-joshc@ni.com>
References: <1425049769-24929-1-git-send-email-joshc@ni.com>
Message-ID: <20150311154150.GA3851@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 09:09:29AM -0600, Josh Cartwright wrote:
> By making use of the restart_handler chain mechanism, the SLCR-based
> reset mechanism can be prioritized amongst other mechanisms available on
> a particular board.

Have either of you had a chance to look at this yet?  On our boards we
have a chip external to the SoC that manages power sequencing (and a
hodgepodge of other board-level things), and we would like it to be
prioritized above the SLCR reset mechanism.

Previously we've just hacked up mach-zynq/common.c to not register a
restart handler, and set arm_pm_restart ourselves, but that doesn't seem
appropriate now that the restart chain exists.

Thanks,
  Josh
