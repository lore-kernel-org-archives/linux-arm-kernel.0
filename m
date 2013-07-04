From: mpfj-list@newflow.co.uk (Mark Jackson)
Date: Thu, 04 Jul 2013 17:00:14 +0100
Subject: Boot hang regression 3.10.0-rc4 -> 3.10.0
In-Reply-To: <51D59146.3070002@newflow.co.uk>
References: <51D577E6.5010507@newflow.co.uk> <51D59146.3070002@newflow.co.uk>
Message-ID: <51D59C0E.8080003@newflow.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/13 16:14, Mark Jackson wrote:
> On 04/07/13 14:25, Mark Jackson wrote:
>> Our custom AM335x board has been booting just fine under 3.10.0-rc4.
>>
>> I've just done a git pull to update to 3.10 (now that it's released)
>> and the board now hangs.
>>
>> Before I start trying to bisect the issue, does anyone have an clues ?
> 
> Okay ... I've now bisected it to:-
> 
> a630fbfbb1beeffc5bbe542a7986bf2068874633 is the first bad commit
> commit a630fbfbb1beeffc5bbe542a7986bf2068874633
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Mon Jun 10 07:39:09 2013 -0700
> 
>     serial: omap: Fix device tree based PM runtime

However, reverting the commit does *not* fix the issue, weird !!

But I have now tested:-

v3.10-rc4     -> works
v3.10-rc5     -> works
v3.10-rc6     -> works
v3.10-rc7     -> works
v3.10         -> works
origin/master -> hangs

Any ideas ?
