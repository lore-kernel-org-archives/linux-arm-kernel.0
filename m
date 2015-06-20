From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Jun 2015 18:03:31 +0200
Subject: [PATCH 1/2] ARM: dts: add buffalo linkstation ls-wxl/wsxl
In-Reply-To: <CAEQ9gEm9xi53oB+tOuJAcDVka-VtSc=vmU_MyKWzNMjKLeDgLw@mail.gmail.com>
References: <1434713319-8691-1-git-send-email-rogershimizu@gmail.com>
 <1434713319-8691-2-git-send-email-rogershimizu@gmail.com>
 <20150619221448.GA1116@lunn.ch>
 <CAEQ9gEkSYtBtmzN3+0FXFeYJZfGFQNQz=nX+54LDTbniQREqPQ@mail.gmail.com>
 <20150620145108.GF1116@lunn.ch>
 <CAEQ9gEm9xi53oB+tOuJAcDVka-VtSc=vmU_MyKWzNMjKLeDgLw@mail.gmail.com>
Message-ID: <20150620160331.GG1116@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Please inform me whether it's OK to keep what kirkwood-lsxl.dtsi is
> now for the power slider.
 
> > In DT, eth1 is correct, not eth0. The kernel should be giving out
> > names on a first come, first served bases, unless something is
> > renaming them.  What user space are you running?  Debian? Do you have
> > a /etc/udev/rules.d/70-persistent-net.rules?  Does it have entries
> > based on the MAC addresses?
> 
> I understand and agree that from DT spec point of view, the only
> network device on board should be called "eth1" still.

No. The name in DT should not give the name of the interface. It
should be possible to give this eth0 as expected, even if in DT it is
eth1. The names here are separate things. The kernel will assign a
name to the interface when it is registered to the network
stack. Since this is the first registered interface, if should get the
name eth0. What i think is happening is that something is later
renaming the interface to eth1. We have to find out what is doing this
rename.

> Yes, I have Debian running on the NAS boxes and there's
> /etc/udev/rules.d/70-persistent-net.rules.
> It has the entry to create "eth0" based on MAC address, which I
> believe was generated automatically:
> 
> > # Unknown net device (/devices/platform/mv643xx_eth_port.0/net/eth0) (mv643xx_eth_port)
> > SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="xx:xx:xx:xx:xx:xx", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth0"

So delete this entry and reboot. See if that helps.

   Andrew
