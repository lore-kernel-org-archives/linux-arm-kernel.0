From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 09 Apr 2013 16:44:17 +0400
Subject: [PATCH v2 0/9] Reorganize R8A7779/Marzen USB code
In-Reply-To: <87zjx89rfb.wl%kuninori.morimoto.gx@renesas.com>
References: <201304090110.50154.sergei.shtylyov@cogentembedded.com>
 <87zjx89rfb.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <51640D21.3090800@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-04-2013 9:58, Kuninori Morimoto wrote:

>>     Here's the set of 9 patches against the Simon Horman's 'renesas.git' repo,
>> 'renesas-next-20130405v2' tag.  It was created to fix the shortcomings in the
>> R8A7779/Marzen USB platform code and R8A7779 USB common PHY driver, and so
>> spans both arch/arm/mach-shmobile/ and drivers/usb/ subtrees (some patches have
>> to touch both subtrees). The patches were conceived with the complete
>> bisectability goal in mind. The patches have been tested on the Marzen board.

> Please add this "tested on xxx" comment on each patch's log area, not only on [0/x].
> We need it on "git log"

    I'm going to post R8A7778/BOCK-W series following this one, and all the 
patches in 1st series should additionally be tested on BOCK-W. Well, I 
probably can hold up posting version 3 until I have the second series verified.
    BTW, about R8A7778/BOCK-W, R-Car M1A user manual talks about a ferrite 
bead in 49.4.1 (3) Setting USB-PHY. Do you know for sure if it's used or not
on BOCK-W board? PHY initialization seems to work with either settings...

>> [1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
>> [2/9] ehci-platform: add pre_setup() method to platform data
>> [3/9] ARM: shmobile: R8A7779: setup EHCI internal buffer
>> [4/9] rcar-phy: remove EHCI internal buffer setup
>> [5/9] ARM: shmobile: R8A7779: remove USB PHY 2nd memory resource
>> [6/9] rcar-phy: correct base address
>> [7/9] rcar-phy: add platform data
>> [8/9] ARM: shmobile: Marzen: pass platform data to USB PHY device
>> [9/9] rcar-phy: handle platform data

> I didn't get [7/9][9/9] patch somehow

    Here they are in the archive:

http://marc.info/?l=linux-usb&m=136545680506170
http://marc.info/?l=linux-usb&m=136545698906257

WBR, Sergei
