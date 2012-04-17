From: kosaki.motohiro@gmail.com (KOSAKI Motohiro)
Date: Tue, 17 Apr 2012 14:24:36 -0400
Subject: [NEW]: Introducing shrink_all_memory from user space
In-Reply-To: <1334483226.20721.YahooMailNeo@web162003.mail.bf1.yahoo.com>
References: <1334483226.20721.YahooMailNeo@web162003.mail.bf1.yahoo.com>
Message-ID: <4F8DB564.2060205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(4/15/12 5:47 AM), PINTU KUMAR wrote:
> Dear All,
>
> This is regarding a small proposal for shrink_all_memory( ) function which is found in mm/vmscan.c.
> For those who are not aware, this function helps in reclaiming specified amount of physical memory and returns number of freed pages.
>
> Currently this function is under CONFIG_HIBERNATION flag, so cannot be used by others without enabling hibernation.
> Moreover this function is not exported to the outside world, so no driver can use it directly without including EXPORT_SYMBOL(shrink_all_memory) and recompiling the kernel.
> The purpose of using it under hibernation(kernel/power/snapshot.c) is to regain enough physical pages to create hibernation image.

This is intended. current shrink_all_memory() is not designed for generic purpose. It doesn't care numa affinity etc..
In future, we may remove this function completely because actually hibernation don't depend on it. it only help to
improvement hibernation speed-up a bit.
