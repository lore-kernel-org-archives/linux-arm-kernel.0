From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 07 Mar 2013 11:24:47 +0100
Subject: v3.9-rc1: swapper/0 [ INFO: possible circular locking dependency
 detected ]
In-Reply-To: <20130307080843.GG20470@nchen-desktop>
References: <51371B5E.1000508@free-electrons.com>
 <20130307080843.GG20470@nchen-desktop>
Message-ID: <51386AEF.5090703@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Le 07/03/2013 09:08, Peter Chen a ?crit :
> On Wed, Mar 06, 2013 at 11:33:02AM +0100, Maxime Ripard wrote:
>> [    2.149645] other info that might help us debug this:
>> [    2.149645] 
>> [    2.157667]  Possible unsafe locking scenario:
>> [    2.157667] 
>> [    2.163598]        CPU0                    CPU1
>> [    2.168134]        ----                    ----
>> [    2.172667]   lock(&(&cdev->lock)->rlock);
>> [    2.176790]                                lock(&(&ci->lock)->rlock);
>> [    2.183255]                                lock(&(&cdev->lock)->rlock);
>> [    2.189893]   lock(&(&ci->lock)->rlock);
> 
> The precondition of above is the chipidea interrupt can be re-entered.
> But as far as I know, the same interrupt can't be re-entered at current
> system.

Yes, it seems to work quite fine anyway, but I'm not sure simply
ignoring this would be the right answer.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
