From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Wed, 24 Aug 2011 16:45:48 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20110824135109.GP32688@e102144-lin.cambridge.arm.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
	<20051.57876.785018.498967@mariner.uk.xensource.com>
	<20110824135109.GP32688@e102144-lin.cambridge.arm.com>
Message-ID: <20053.7340.865511.561798@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> From discussions that I've been having with the technical architects at ARM
> and various bootloader people, it looks like we have two scenarios [this is
> reiterating a lot of what you've said but I think it's important]:

Right.

>   After the system has taken care of whatever secure initialisation was
>   required, it moves into HYP mode. At this point there are two things that
>   can happen:
> 
>   1.0: HYP mode boot loader (uboot, UEFI) runs and installs Linux at the
>        same privilege level
>   1.1: Raw Linux boots, and detects HYP mode
>   1.2: Sets up basic init, with HVC trampoline for installing KVM/Xen later
>   1.3: Switch to SVC mode
>   1.4: Continue booting Linux as normal

Since we have discovered that this approach will work fine with
existing kernels, even ones which are completely unaware of Hyp mode,
I think this is the right approach.  It can be implemented by boot
loaders etc. right away.

Ian.
