From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Sep 2016 13:59:41 -0700
Subject: Regression in next with "softirq: fix tasklet_kill() and its
 users"
In-Reply-To: <a305129a-e2b4-9ba1-9e94-7998277da035@oracle.com>
References: <20160922205122.ezsxjint2l6lytyi@atomide.com>
 <a305129a-e2b4-9ba1-9e94-7998277da035@oracle.com>
Message-ID: <20160922205941.al4m3vf6en4c3txk@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@oracle.com> [160922 13:59]:
> On 9/22/2016 1:51 PM, Tony Lindgren wrote:
> > Hi Santosh,
> > 
> > Looks like commit 1f5e9c3bc47f ("softirq: fix tasklet_kill() and
> > its users") causes pandaboard es to not get any IP address on the
> > smsc95xx USB Ethernet.
> > 
> > Reverting the commits fixes the issue. Any ideas?
> > 
> Yep. It was discussed today morning and Stephen was suppose to
> revert that commit from next for now.
> 
> The tasklet core fix even though fixes the issue, there are many
> bad users of tasklet which are using tasklet APIs without
> doing any sort of tasklet initialization. So there is more
> work to do before the tasklet core can be fixed.

OK thanks for the info.

Regards,

Tony
