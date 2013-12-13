From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Dec 2013 17:46:47 +0000
Subject: [PATCH 1/5] arm64: Fix __data_loc value
In-Reply-To: <35a937043d1b3eae1b1ea547efc25f75b5f43f67.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
 <35a937043d1b3eae1b1ea547efc25f75b5f43f67.1386879684.git.geoff@infradead.org>
Message-ID: <20131213174647.GJ4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 08:39:45PM +0000, Geoff Levand wrote:
> The __data_loc variable should be set to the VMA of the data section, not
> the LMA.
> 
> At present LOAD_OFFSET is not set and defaults to zero, so this bug
> does not cause any problems.

Why does ARM64 have this in the first place?  __data_loc is used for
XIP support on ARM, does ARM64 have XIP support?
