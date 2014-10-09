From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 10 Oct 2014 00:47:06 +0300
Subject: RCU bug with v3.17-rc3 ?
In-Reply-To: <20141009204101.GA25955@debian>
References: <20140904191642.GJ5001@linux.vnet.ibm.com>
 <20140904192535.GJ13421@saruman.home>
 <20140904200403.GL13421@saruman.home>
 <20140905213216.GD5001@linux.vnet.ibm.com>
 <20141008171322.GH22688@saruman> <20141008175707.GI22688@saruman>
 <20141008212938.GP22688@saruman>
 <20141009160138.GA2396@cmpxchg.org>
 <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian>
Message-ID: <20141009214706.GC4606@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 09, 2014 at 10:41:01PM +0200, Rabin Vincent wrote:
>   What GCC version are you using?
>   
>   4.8.1 and 4.8.2 are known to miscompile the ARM kernel and these
>   find_get_entry() crashes with 0xffffffff involved smell a lot like the
>   earlier reports from kernels build with those compilers:
>   
>   https://lkml.org/lkml/2014/6/25/456
>   https://lkml.org/lkml/2014/6/30/375
>   https://lkml.org/lkml/2014/6/30/660
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
>   https://lkml.org/lkml/2014/5/9/330

Is it possible to blacklist those GCC versions on ARM somehow as it
seems people are still using them?

This bug also ruined a file system on one of my boxes last year
(see e.g. http://marc.info/?l=linux-arm-kernel&m=139033442527244&w=2).

A.
