From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 22 Sep 2016 13:58:38 -0700
Subject: Regression in next with "softirq: fix tasklet_kill() and its
 users"
In-Reply-To: <20160922205122.ezsxjint2l6lytyi@atomide.com>
References: <20160922205122.ezsxjint2l6lytyi@atomide.com>
Message-ID: <a305129a-e2b4-9ba1-9e94-7998277da035@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/22/2016 1:51 PM, Tony Lindgren wrote:
> Hi Santosh,
>
> Looks like commit 1f5e9c3bc47f ("softirq: fix tasklet_kill() and
> its users") causes pandaboard es to not get any IP address on the
> smsc95xx USB Ethernet.
>
> Reverting the commits fixes the issue. Any ideas?
>
Yep. It was discussed today morning and Stephen was suppose to
revert that commit from next for now.

The tasklet core fix even though fixes the issue, there are many
bad users of tasklet which are using tasklet APIs without
doing any sort of tasklet initialization. So there is more
work to do before the tasklet core can be fixed.

Regards,
Santosh
