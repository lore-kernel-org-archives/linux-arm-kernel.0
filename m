From: richard.weinberger@gmail.com (richard -rw- weinberger)
Date: Sun, 15 Apr 2012 14:10:00 +0200
Subject: [NEW]: Introducing shrink_all_memory from user space
In-Reply-To: <1334490429.67558.YahooMailNeo@web162006.mail.bf1.yahoo.com>
References: <1334483226.20721.YahooMailNeo@web162003.mail.bf1.yahoo.com>
 <CAFLxGvwJCMoiXFn3OgwiX+B50FTzGZmo6eG3xQ1KaPsEVZVA1g@mail.gmail.com>
 <1334490429.67558.YahooMailNeo@web162006.mail.bf1.yahoo.com>
Message-ID: <CAFLxGvz5tmEi-39CZbJN+0zNd3ZpHXzZcNSFUpUWS_aMDJ4t6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 15, 2012 at 1:47 PM, PINTU KUMAR <pintu_agarwal@yahoo.com> wrote:
> Moreover, this is mainly meant for mobile phones where there is only *one* user.

I see. Jet another awful hack.
Mobile phones are nothing special. They are computers.

>>
>> If we expose it to user space *every* program/user will try too free
>> memory such that it
>> can use more.
>> Can you see the problem?
>>
> As indicated above, every program/user cannot use it, as it requires root privileges.
> Ok, you mean to say, every driver can call "shrink_all_memory" simultaneously??
> Well, we can implement locking for that.
> Anyways, I wrote a simple script to do this (echo 512 > /dev/shrinkmem) in a loop for 20 times from 2 different terminal (as root) and it works.
> I cannot see any problem.

Every program which is allowed to use this interface will (ab)use it.
Anyway, by exposing this interface to user space (or kernel modules)
you'll confuse the VM system.

-- 
Thanks,
//richard
