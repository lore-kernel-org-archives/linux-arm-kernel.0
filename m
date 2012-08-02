From: zonque@gmail.com (Daniel Mack)
Date: Thu, 02 Aug 2012 21:56:57 +0200
Subject: Current state of AM33xx patches
In-Reply-To: <98DC2F80-9AD6-4A65-8FA8-3B2AABF72692@dominion.thruhere.net>
References: <4FD5BA4C.9070706@gmail.com> <4FE9A00B.6010908@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
 <4FEC7394.9030208@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com>
 <4FEDF54D.4030609@gmail.com>
 <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com>
 <4FEEC7F2.8070507@gmail.com>
 <alpine.DEB.2.00.1207040403010.6760@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA635DC@DBDE01.ent.ti.com>
 <4FF42761.2000701@gmail.com>
 <EB1619762EAF8B4E97A227FB77B7E0293E9C2548@DBDE01.ent.ti.com>
 <500CEF97.4050207@gmail.com>
 <EB1619762EAF8B4E97A227FB77B7E0293E9D04EB@DBDE01.ent.ti.com>
 <501159C3.3020109@gmail.com>
 <704C899A-606B-41A3-99E8-6D92C0EA5BC5@dominion.thruhere.net>
 <50116926.4060309@gmail.com>
 <587C7FB9-2DD3-48EE-B74D-BEBDF199BE23@dominion.thruhere.net>
 <50118272.1050209@gmail.com>
 <9F9237B3-55BD-471B-ADD1-1A18F3644387@dominion.thruhere.net>
 <501A9D1C.8080305@gmail.com>
 <98DC2F80-9AD6-4A65-8FA8-3B2AABF72692@dominion.thruhere.net>
Message-ID: <501ADB89.4030405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.08.2012 17:37, Koen Kooi wrote:
>  But I still can't get it working:
> 
> root at beaglebone:~# dmesg | grep -i cpsw [   13.504425] net eth0:
> initializing cpsw version 1.12 (0)
> 
> root at beaglebone:~# dmesg | grep -i phy [    0.000000] Booting Linux
> on physical CPU 0 [    0.228496] nop_usb_xceiv phy.17: transceiver
> type USB2 PHY already exists [   13.512056] libphy: PHY
> davinci_mdio-0:00 not found [   13.517168] net eth0: phy
> davinci_mdio-0:00 not found on slave 0 [   13.523516] libphy: PHY
> davinci_mdio-0:01 not found [   13.528675] net eth0: phy
> davinci_mdio-0:01 not found on slave 1
> 
> root at beaglebone:~# ifconfig -a | grep eth eth0      Link
> encap:Ethernet  HWaddr 00:04:9F:01:1B:B8

Ok, I got it up and and running now on my board using the two
davinci_mdio drivers and the hwmod addition I just posted.

With those applied on top of Mugunthan work, I can link my cpsw slave
with the phy id "davinci_mdio.18-:04", but the 18 is just the global
device counter which will change again once I add more devices. That
still needs some cleanup.

Anyway, at least I can boot into my NFS root now :) Koen, can you try
this on your board and see if that works for you as well?


Thanks,
Daniel
