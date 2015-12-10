From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Thu, 10 Dec 2015 14:15:04 +0000
Subject: [RFC PATCH 8/8] arm64: add sysfs cpu_capacity attribute
In-Reply-To: <1448288921-30307-9-git-send-email-juri.lelli@arm.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-9-git-send-email-juri.lelli@arm.com>
Message-ID: <566988E8.3010308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/15 14:28, Juri Lelli wrote:
> Add a sysfs cpu_capacity attribute with which it is possible to read and
> write (thus over-writing default values) CPUs capacity. This might be
> useful in situation where there is no way to get proper default values
> at boot time.
> 
> The new attribute shows up as:
> 
>  /sys/devices/system/cpu/cpu*/cpu_capacity
>

This sysfs interface is not really needed for arm or arm64. People can
build the dt blob if they want to change the values. Less code to carry
... Let's focus on the core functionality, which is parsing cpu capacity
from dt file to task scheduler for heterogeneous systems.

[...]
