From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 15 Aug 2014 14:41:20 -0400
Subject: Random MAC address on my BeagleBone White
In-Reply-To: <53EE5233.6000605@yahoo.com>
References: <20140815134221.08c546a0@gandalf.local.home>
 <53EE5233.6000605@yahoo.com>
Message-ID: <20140815144120.58597f37@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 16 Aug 2014 00:02:19 +0530
Anand Moon <moon.linux@yahoo.com> wrote:

> Hi Steven,
> 
> Please follow the bellow link to set mac address.
> 
> http://www.armadeus.com/wiki/index.php?title=Ethernet_MAC_address
> 
> -Anand Moon

Hi,

My U-Boot already has a ethaddr defined. It's what is used by the
default kernel that came with the board (3.2).

U-Boot# printenv
[...]
ethaddr=d4:94:a1:8b:ec:78

The problem is that this is ignored by the latest kernel and it
replaces it with some random mac.

Note, I boot via bootp, thus it has to have a mac. That mac is what
tells my dhcp server what kernel image to load this board.

-- Steve
