From: julien.grall@arm.com (Julien Grall)
Date: Thu, 30 Jun 2016 10:19:34 +0100
Subject: [PATCH] xen/arm: register clocks used by the hypervisor
In-Reply-To: <143393c4-739a-6e29-cbfa-128fdfcb1ed0@de.bosch.com>
References: <1466504165-9214-1-git-send-email-dirk.behme@de.bosch.com>
 <576AAE36.9070501@arm.com>
 <143393c4-739a-6e29-cbfa-128fdfcb1ed0@de.bosch.com>
Message-ID: <5774E426.3030600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On 29/06/16 16:49, Dirk Behme wrote:
> On 22.06.2016 17:26, Julien Grall wrote:
>> On 21/06/16 11:16, Dirk Behme wrote:
>> Would it be possible to use the flags CLK_IGNORE_UNUSED instead? So the
>> clock will be ignored by clk_disable_unused_subtree.
>
>
> Yes, using CLK_IGNORE_UNUSED is an option. But ;)
>
> But we can't set it directly in enlighten.c as we can't access the flags
> part of the clock structs from outside the core clock code.

Maybe we can introduce a new function in the kernel to set the flags?

Anyway, I am not very familiar with the clock subsystem. So, as 
suggested by Mark, I would recommend you to start a discussion with with 
the clock maintainers to see what would be the best way to avoid DOM0 to 
disable any clock used by Xen or a guest.

Regards,

-- 
Julien Grall
