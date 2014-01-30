From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Jan 2014 18:28:59 +0100
Subject: [PATCH] arm: document "mach-virt" platform.
In-Reply-To: <1391098262-15944-1-git-send-email-ian.campbell@citrix.com>
References: <1391098262-15944-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <201401301828.59294.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 January 2014, Ian Campbell wrote:
> mach-virt has existed for a while but it is not written down what it actually
> consists of. Although it seems a bit unusual to document a binding for an
> entire platform since mach-virt is entirely virtual it is helpful to have
> something to refer to in the absence of a single concrete implementation.
> 
> I've done my best to capture the requirements based on the git log and my
> memory/understanding.
> 
> While here remove the xenvm dts example, the Xen tools will now build a
> suitable mach-virt compatible dts when launching the guest.

It might be worth noting in the changeset comment that the 'compatible'
string is actually no longer needed on newer kernels: All the members
of the machine descriptor are now the defaults (we should remove the
virt_init() function as well), and the fallback machine descriptor should
work just fine if any other string gets passed.

	Arnd
