From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Mar 2015 17:50:24 -0700
Subject: Setting reboot type at run time for ARM
In-Reply-To: <5508A047.7060308@broadcom.com>
References: <5508A047.7060308@broadcom.com>
Message-ID: <5508CBD0.5060508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/15 14:44, Arun Ramamurthy wrote:
> Hello
> 
> I would like to specify a reset type just before issuing the reboot
> command in the kernel. I know the kernel command line parameter can be
> set as "reboot=w" to indicate warm reset but I want to be able to decide
> this at run time before issuing a reboot command. What would be the best
> way to implement this? Modify the reboot command
> to accept a parameter or is there a standard hook I can use?

If you use the reboot(2) system call you can already specify a large
number of options, for options that are currently not supported by
coreutils' reboot or busybox's reboot, you could probably provide a
shell script wrapper which calls into either your own reboot
implementation or the regular one, would that work?
-- 
Florian
