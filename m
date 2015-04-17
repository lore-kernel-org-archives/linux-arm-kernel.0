From: cmetcalf@ezchip.com (Chris Metcalf)
Date: Fri, 17 Apr 2015 12:56:17 -0400
Subject: [PATCH] tile: use si_int instead of si_ptr for compat_siginfo
In-Reply-To: <20150323120253.GA12757@e104818-lin.cambridge.arm.com>
References: <1423563011-12377-1-git-send-email-bamvor.zhangjian@huawei.com>
 <20150210122718.GC32052@e104818-lin.cambridge.arm.com>
 <54DB3B60.4050100@huawei.com>
 <20150211154054.GD9058@e104818-lin.cambridge.arm.com>
 <54DDAF2B.2070707@huawei.com>
 <20150213104455.GA3508@e104818-lin.cambridge.arm.com>
 <54DE730D.3090100@ezchip.com> <20150214112220.GB10246@MBP.local>
 <54ECF309.3020509@ezchip.com>
 <201503161908.t2GJ8fs5021877@farm-0002.internal.tilera.com>
 <20150323120253.GA12757@e104818-lin.cambridge.arm.com>
Message-ID: <55313B31.6040803@ezchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2015 08:02 AM, Catalin Marinas wrote:
>> @@ -121,8 +119,7 @@ int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from)
>> >  
>> >  	err |= __get_user(to->si_pid, &from->si_pid);
>> >  	err |= __get_user(to->si_uid, &from->si_uid);
>> >-	err |= __get_user(ptr32, &from->si_ptr);
>> >-	to->si_ptr = compat_ptr(ptr32);
>> >+	err |= __get_user(to->si_int, &from->si_int);
> We have a memset(to, 0, sizeof(*to)) on arm64 in this function but I
> can't see it on tile. Some members or even half of si_ptr would be left
> uninitialised.

In the end I added a memset() for the tile compat case like you suggest 
for arm64.

Thanks!

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
