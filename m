From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Jun 2015 22:09:14 +0200
Subject: [PATCH 1/2] ARM: dts: add buffalo linkstation ls-wxl/wsxl
In-Reply-To: <CAEQ9gEkubRtcdDBuhJHpP0H=Qhc1KvG-4QAMbExopt786XbMuA@mail.gmail.com>
References: <1434713319-8691-1-git-send-email-rogershimizu@gmail.com>
 <1434713319-8691-2-git-send-email-rogershimizu@gmail.com>
 <20150619221448.GA1116@lunn.ch>
 <CAEQ9gEkSYtBtmzN3+0FXFeYJZfGFQNQz=nX+54LDTbniQREqPQ@mail.gmail.com>
 <20150620145108.GF1116@lunn.ch>
 <CAEQ9gEm9xi53oB+tOuJAcDVka-VtSc=vmU_MyKWzNMjKLeDgLw@mail.gmail.com>
 <20150620160331.GG1116@lunn.ch>
 <CAEQ9gEkubRtcdDBuhJHpP0H=Qhc1KvG-4QAMbExopt786XbMuA@mail.gmail.com>
Message-ID: <20150621200914.GB12665@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 12:16:11AM +0900, Roger Shimizu wrote:
> Dear Andrew,
> 
> > No. The name in DT should not give the name of the interface. It
> > should be possible to give this eth0 as expected, even if in DT it is
> > eth1. The names here are separate things. The kernel will assign a
> > name to the interface when it is registered to the network
> > stack. Since this is the first registered interface, if should get the
> > name eth0. What i think is happening is that something is later
> > renaming the interface to eth1. We have to find out what is doing this
> > rename.
> 
> Yes, I confirmed what you said is absolutely right.
> Your detailed info is really appreciated. Thank you!
> 
> Now I changed the ethernet part of dts like the following:
> 
> +&mdio {
> +       status = "okay";
> +
> +       ethphy1: ethernet-phy at 8 {
> +               device_type = "ethernet-phy";
> +               reg = <8>;
> +       };
> +};
> +
> +&eth1 {
> +       status = "okay";
> +
> +       ethernet1-port at 0 {
> +               phy-handle = <&ethphy1>;
> +       };
> +};

Great, much better.

> If you feel alright, I'll make the similar changes to
> "kirkwood-lswvl.dts", and submit the "PATCH v2" to you.

Great.

	Andrew
