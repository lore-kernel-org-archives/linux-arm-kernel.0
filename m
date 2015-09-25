From: nm@ti.com (Nishanth Menon)
Date: Fri, 25 Sep 2015 11:01:29 -0500
Subject: [PATCH 1/3] Documentation: dt: keystone: provide SoC specific
 compatible flags
In-Reply-To: <560565AF.2010701@oracle.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
 <1442938118-4718-2-git-send-email-nm@ti.com> <5602ED34.9010108@oracle.com>
 <56040323.1080409@ti.com> <560406C2.6090200@ti.com> <56041CA4.40208@ti.com>
 <56055F1F.4060401@ti.com> <560565AF.2010701@oracle.com>
Message-ID: <56056FD9.5060000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2015 10:18 AM, santosh shilimkar wrote:
> On 9/25/2015 7:50 AM, Nishanth Menon wrote:
[...]
>> But, how about userspace
>> needing to know which SoC they are on, without needing to depend on
>> board->soc mapping? How do we help resolve that?
>>
> Why the user space should care about exact SOC ?

examples vary - trivial one is: debug tools like omapconf[1] or testing
tools like opentest[2] need some standard way to ensure Linux kernel is
functional - trusting the least set of parameters is usually what we
would prefer. while building a generic distro such as debian or yocto,
one prefers NOT to need to do a package build per SoC/perboard - that
never scales. instead, you'd like the same application run on different
systems dynamically.


[1] https://github.com/omapconf/omapconf
[2] http://arago-project.org/wiki/index.php/Opentest
-- 
Regards,
Nishanth Menon
