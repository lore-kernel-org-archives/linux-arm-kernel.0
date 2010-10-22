From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 22 Oct 2010 08:20:00 -0700
Subject: [RFC PATCH] arm: msm: moved Kconfig machine entry into mach-msm
In-Reply-To: <20101022074918.GA25606@n2100.arm.linux.org.uk>
References: <1287686255-18674-1-git-send-email-dwalker@codeaurora.org>
	<20101022074918.GA25606@n2100.arm.linux.org.uk>
Message-ID: <1287760800.18266.5.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-10-22 at 08:49 +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 21, 2010 at 11:37:35AM -0700, Daniel Walker wrote:
> > Has anyone suggested this? It seems like it might reduce conflicts
> > in the Kconfig file.
> 
> How?  The choice normally has one entry for each mach- directory.
> You're still going to have 'source' for each mach- directory, so
> the chances of conflicts are no different.

The source lines would be mostly static.. We wouldn't have to modify
Kconfig to add new "select" statements to are entries. People end up
having to send you patches which do something then modify the Kconfig
(or in some cases they don't send them to you which is worse) in order
to reduce conflicts. With this change they wouldn't need to do that.

> Plus it increases the file count, makes things more indirect, and
> therefore harder to follow.

True. It's a trade off , but we already have this for the other menu
options further down the Kconfig.

Daniel
-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
