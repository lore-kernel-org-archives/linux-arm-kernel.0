From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 4 Apr 2016 14:15:48 +0200
Subject: [PATCH] ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500
In-Reply-To: <5702555C.1020408@biot.com>
References: <1459601753-31193-1-git-send-email-bert@biot.com>
 <20160402161639.GF32554@lunn.ch> <5702555C.1020408@biot.com>
Message-ID: <20160404121548.GC21828@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >Could you dual license this under X11 as well? You will need agreement
> >from the copyright holders above, if they wrote DT fragments.
> >
> > Not many kirkwood boards are, but we encourage most Marvell SoCs DT
> > files to be dual license.
> 
> I did not get responses from all authors, so no dice.

O.K. We can change this later if they do reply.
 
> >The 6171 is a 7 port device. Is the last port also a 'cpu' port?
> 
> I don't think so. I didn't manage to get anything through it, and I
> can't see the CPU traces on the PCB (neither 5 nor 6).

You might need to set the RGMII delay. Here is an example i use with
another board:

port at 6 {
	reg = <6>;
        label = "cpu";
	phy-mode = "rgmii-txid";
};

	Andrew
