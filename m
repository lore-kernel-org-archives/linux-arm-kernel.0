From: pintu_agarwal@yahoo.com (PINTU KUMAR)
Date: Sun, 15 Apr 2012 04:47:09 -0700 (PDT)
Subject: [NEW]: Introducing shrink_all_memory from user space
In-Reply-To: <CAFLxGvwJCMoiXFn3OgwiX+B50FTzGZmo6eG3xQ1KaPsEVZVA1g@mail.gmail.com>
References: <1334483226.20721.YahooMailNeo@web162003.mail.bf1.yahoo.com>
 <CAFLxGvwJCMoiXFn3OgwiX+B50FTzGZmo6eG3xQ1KaPsEVZVA1g@mail.gmail.com>
Message-ID: <1334490429.67558.YahooMailNeo@web162006.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> 
> This is fundamentally flawed.
> You're assuming that only one program will use this interface.
> Linux is a multi/user-tasking system

Dear Richard, Thank you for your comments.
I am sorry but this is meant only for *root* user.
That is only root user can do this: "echo 512 > /dev/shrinkmem"
If other user try to write in it: it says permission denied as follows:
pintu at pintu-ubuntu:~$ echo 512 > /dev/shrinkmem
-bash: /dev/shrinkmem: Permission denied

Moreover, this is mainly meant for mobile phones where there is only *one* user.

> 
> If we expose it to user space *every* program/user will try too free
> memory such that it
> can use more.
> Can you see the problem?
> 
As indicated above, every program/user cannot use it, as it requires root privileges.
Ok, you mean to say, every driver can call "shrink_all_memory" simultaneously??
Well, we can implement locking for that.
Anyways, I wrote a simple script to do this (echo 512 > /dev/shrinkmem) in a loop for 20 times from 2 different terminal (as root) and it works.
I cannot see any problem.
Can you elaborate more please?


Thanks,
Pintu
