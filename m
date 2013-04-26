From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Apr 2013 17:03:17 +0200
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <CALrVBkuyby_KY_M+yp0e=PLk=7_W_kSxxm62YYSwwp8rwLsCAQ@mail.gmail.com>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
 <1577576.O1Cm2pf5KD@wuerfel>
 <CALrVBkuyby_KY_M+yp0e=PLk=7_W_kSxxm62YYSwwp8rwLsCAQ@mail.gmail.com>
Message-ID: <201304261703.17798.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 April 2013, Anup Patel wrote:
> I am curious about how smh-based or hypercall-based early prints would
> be handled in following scenario:
> 
> "A board is running KVM ARM enabled kernel and linux console on serial
> port. Now a user remotely connects to the board via telnet/ssh and
> launches a VM with smh-based or hypercall-based earlyprintk."
> 
> In the above scenario, will smh-based or hypercall-based earlyprints
> appear to user on remote shell or not ?

The implementation of the console device would still be done by KVM,
as for any other virtual device, so it shows up whereever kvm is
configured to output the console data.

	Arnd
