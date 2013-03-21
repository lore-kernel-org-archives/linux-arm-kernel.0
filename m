From: alior@marvell.com (Lior Amsalem)
Date: Thu, 21 Mar 2013 23:35:21 +0200
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130321221523.7ede6ccc@skate>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <20130321201533.GN21478@lunn.ch>	<20130321212236.1015295d@skate>
 <20130321205545.GA8358@obsidianresearch.com> <20130321221523.7ede6ccc@skate>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801A56C7B6D24@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Jason,

> From: Thomas Petazzoni [mailto:thomas.petazzoni at free-electrons.com]
> Sent: Thursday, March 21, 2013 11:15 PM
> 
> Dear Jason Gunthorpe,
> 
> On Thu, 21 Mar 2013 14:55:45 -0600, Jason Gunthorpe wrote:
> 
> > Or, better, locate all the internal registers above 8G and use
> > contiguous DRAM mapping from 0 -> 8GB
> 
> I see two potential issues with this idea:
> 
>  *) It only works when LPAE is enabled, so we would have to have
>     different internal register addresses depending on whether LPAE is
>     enabled or not. Probably not impossible, but not very
>     straightforward either.
> 
>  *) It would require Linux to change the internal registers address
>     (for now the kernel relies on the bootloader). The problem is that
>     we can't do it early enough to preserve the earlyprintk
>     functionality. Maybe you have suggestions on how to achieve that?
> 

Please note that all registers and IOs are still 32bit, the 40bit extension is on 
the CPU to DRAM path (windows) only.

Therefore, the register that sets the internal register base is 32bit :)

> Best regards,
> 
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux development, consulting,
> training and support.
> http://free-electrons.com

Regards,
Lior Amsalem
