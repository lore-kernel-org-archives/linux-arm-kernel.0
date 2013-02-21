From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Thu, 21 Feb 2013 17:19:23 +0100
Subject: Porting 3.8-rc4-nohz3 to ARM (PandaBoard)
In-Reply-To: <B38601CE-F868-426E-8504-0DCE7CCB9BDC@enea.com>
References: <20130204200238.GA16718@enea.se>
 <CAFTL4hyNZdjmSij0DDouu0mmD5E3xApq7i=dZD941ZtCM1QyjQ@mail.gmail.com>
 <20130211190317.GA8513@enea.se>
 <CAFTL4hzzFEYq+1=n+JpTiV3WdeKXETGQVDJSm-FJCN7E6xvE9w@mail.gmail.com>
 <B38601CE-F868-426E-8504-0DCE7CCB9BDC@enea.com>
Message-ID: <CAFTL4hyR3s8mfxCk+_jFbvnkSrC4iMN4ZmjrGSMo9KRkxRr9cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/20 Mats Liljegren <mats.liljegren@enea.com>:
>
>
>> 2013/2/11 Mats Liljegren <mats.liljegren@enea.com>:
>>> Could the other guy be Kevin Hillman? The name has been mentioned to me but
>>> I don't have his e-mail address.
>>
>> Exactly :)
>>
>>>
>>> I have stumbled across a problem, I get the following error messages during
>>> boot:
>>>
>>> ---- Start snippet ----
>>> [   41.119873] INFO: task rcuo1:10 blocked for more than 20 seconds.
>>
>> This showed up upstream as well, it hshould have been fixed in linus tree now.
>
> Ok.
>
>>
>> [...]
>>> [  112.400695] VFS: Unable to mount root fs via NFS, trying floppy.
>>> [  112.407226] List of all partitions:
>>> [  112.411041] No filesystem could mount root, tried:
>>> [  112.416351] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)
>>
>> Ah, that probably not due to my patches :)
>
> By removing some kernel parameters I managed to get further. They were'nt important, just tried to disable watchdog and idle calls.
> My current problem is that it refuses to enter full nohz mode due to too many runable threads. I need to check were those extra threads come from.
>
> Could it be related to rcu problem above? If so I might need to switch to a newer version of Linus tree.

May be. If so you may need to migrate the rcuoX kthreads. You probably
need to use the sched switch tracepoint to check what's going on. And
migrate some threads affinity if needed.
