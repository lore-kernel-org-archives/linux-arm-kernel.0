From: horms@verge.net.au (Simon Horman)
Date: Thu, 25 Jul 2013 10:06:08 +0900
Subject: ARM CPU Hotplug breakage on mach-shmobile and KZM9D
In-Reply-To: <CANqRtoRx7voEVwJG8UNNy_Jiixo=uRJCvxTD0bZdzVohoryBUA@mail.gmail.com>
References: <CANqRtoRx7voEVwJG8UNNy_Jiixo=uRJCvxTD0bZdzVohoryBUA@mail.gmail.com>
Message-ID: <20130725010607.GB31464@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 12:15:49AM +0900, Magnus Damm wrote:
> Hi everyone,
> 
> Bad news: CPU Hotplug on KZM9D seems broken on recent kernels.
> 
> On renesas-next-20130710 or earlier I can perform the following:
> 
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> CPU1: shutdown
> # echo 1 > /sys/devices/system/cpu/cpu1/online
> CPU1: Booted secondary processor
> #
> 
> While on more recent kernels the hotplug boot fails. This may be
> related to the move to v3.11-rc. The tag renesas-next-20130710
> surprisingly seems to be the final kernel based on v3.10-rc before
> jumping to v3.11-rc.
> 
> I wonder, do other ARM platforms have working CPU Hotplug in v3.11-rc?

I have a snowball that I could test if you think it would be useful.
