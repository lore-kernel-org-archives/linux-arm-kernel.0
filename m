From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 14 Dec 2012 12:20:29 +0900
Subject: [PATCH 1/2] ARM: SH-Mobile: sh73a0: Secondary CPUs handle own SCU
 flags
In-Reply-To: <1354795719-5578-1-git-send-email-hechtb+renesas@gmail.com>
References: <1354795719-5578-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <CANqRtoR-HeWVgWsL654aVEx9BuHKBpSVXzRYBZY9=1JZFi267g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 6, 2012 at 9:08 PM, Bastian Hecht <hechtb@gmail.com> wrote:
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

Acked-by: Magnus Damm <damm@opensource.se>
