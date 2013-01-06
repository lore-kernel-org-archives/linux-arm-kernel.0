From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 06 Jan 2013 22:36:58 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <20130104190345.460151d1@skate>
References: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357315498-4570-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50E710CB.8070007@lunn.ch> <20130104183139.20492204@skate>
 <50E71356.3030203@lunn.ch> <20130104190345.460151d1@skate>
Message-ID: <50E9EE7A.1080301@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013 07:03 PM, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Fri, 04 Jan 2013 18:37:26 +0100, Andrew Lunn wrote:
> 
>> It would be nice to have a sample size bigger than two.
> 
> Indeed.
> 
>> Anybody else have a OpenBlocks AX3-4 and can report if it works or not?
> 
> At least Gr?gory has one.

Until now I didn't notice any problem on this board with the 3GB enable.

I made more tests since I received this email, I booted (cold and hot boot)
the board dozens of times, and indeed every 5 or 10 reboot the kernel hanged
during boot at line:
"UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)"

After applying your patch, I didn't notice any hang after 20 boots. Do you
have a test pattern which make the kernel to hang each time to be sure that
it is the root of the problem?

> 
>> Thomas, could you swap out the RAM module you have for a known good one?
>> Can you test the RAM module in some other board you know works?
> 
> Unfortunately, I don't see off-hand which other board I have in which I
> could test this RAM module, nor if I have a compatible RAM module to
> test things with.
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
