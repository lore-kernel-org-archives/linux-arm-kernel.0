From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 02 Oct 2012 09:42:19 +0200
Subject: How many cores does the ARM branch support?
In-Reply-To: <20121002043106.GD21233@work1>
References: <20121002043106.GD21233@work1>
Message-ID: <506A9ADB.4060306@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2012 06:31 AM, Michelle Konzack wrote:
> Hello OverGeeks and *,
> 

Hello Michelle,

> I have gotten a new gadget which run only with 700MHz but has  32 cores. Support 16 GE Interfaces a 50 Gbit universal interface and 4 PCIe ports, SATA HDD and much more...
> 
> ...and yes, this ARM microcontroller is a telecommunications controller.
> 
> However, I have the Evaluation  Kit  and  a  PCIe  graphiccard  and  now installed Debian ARMEL.  Unfortunately I get only 2 cores working...
> 
> What must I do to get the other 30 cores?

You have to check that your kernel was compiled with CONFIG_NR_CPUS = 32.
Checks also that you don't have "nr_cpus=2" in your kernel parameter.

> 
> (without them, my Marvel Discovery MV78200 us 5 times faster)
> 
> And is it possibel, to get 100 cores running? (this is the bigger version of the microcontroller I have)

Currently the maximum number of core supported is limited to 32.
the NR_CPUS range is from 2 to 32 for ARM.

Regards,
Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
