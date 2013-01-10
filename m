From: horms@verge.net.au (Simon Horman)
Date: Thu, 10 Jan 2013 09:46:05 +0900
Subject: [PATCH v2 1/2] ARM: SH-Mobile: sh73a0: Secondary CPUs handle own
 SCU flags
In-Reply-To: <1357760512-2634-1-git-send-email-hechtb+renesas@gmail.com>
References: <1357760512-2634-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130110004605.GA29988@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 08:41:51PM +0100, Bastian Hecht wrote:
> From: Bastian Hecht <hechtb@gmail.com>
> 
> When booting secondary CPUs we have used the main CPU to set up the
> Snoop Control Unit flags of these CPUs. It is a cleaner approach
> if every CPU takes care of its own flags. We avoid the need for
> locking and the program logic is more concise. With this patch the file
> headsmp-sh73a0.S is added that contains a startup vector for secondary CPUs
> that sets up its own SCU flags.
> Further in sh73a0_smp_prepare_cpus() we can rely on the generic ARM helper
> scu_power_mode(). This is possible as we don't cross borders anymore (every
> CPU handles its own flags) and need no locking. So we can throw out the
> needless function modify_scu_cpu_psr().
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

Thanks, applied to the soc2 branch.
