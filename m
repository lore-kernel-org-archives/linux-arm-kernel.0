From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Dec 2013 09:07:03 -0800
Subject: [PATCH 0/3] ARM Coresight: Enhance ETM tracing control
In-Reply-To: <CANsc=4UHEG5cmg9SD3r3rsuJnM9zqq2WiTQdUwrYFr_kkbsVvg@mail.gmail.com>
References: <CANsc=4VRLWhaVA15HrBEeM+FJC0tS+b5KKopDb7bP8nxzR8=zA@mail.gmail.com>
 <20131204070442.GA31665@kroah.com>
 <CANsc=4UHEG5cmg9SD3r3rsuJnM9zqq2WiTQdUwrYFr_kkbsVvg@mail.gmail.com>
Message-ID: <20131204170703.GA14859@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 11:52:34AM -0500, Adrien Verg? wrote:
> Hi all,
> 
> First, please excuse me for these misformatted patches that my email
> client messed up. Next time I will use git send-email. The 3 patches
> can be found on
> http://git.dorsal.polymtl.ca/~averge?p=linux.git;a=shortlog;h=refs/heads/etm_with_addr_and_pid
> 
> Greg: you're right, sysfs is a questionable place for tracing/debug
> code. Debugfs or /dev entries would be the right place.

Why would /dev be correct?

What's wrong with the existing tracing infrastructure that you need to
create a new one?

> Though, the only support for ETM in Linux is there, and currently very
> limited because tracing options such as address and pid are not
> configurable. The code I propose would make it usable, until someone
> with time (and more experience than me ;)) moves it out from sysfs.

Your pid implementation is broken, see my other email about that :(

And again, what's wrong with the existing tracing functionalty that is
processor agnostic?  Why can't we just delete this driver today and use
the existing trace code?

thanks,

greg k-h
