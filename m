From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 9 Jun 2014 12:52:42 +0200
Subject: [PATCH 4/9] usb: phy: add the Berlin USB PHY driver
In-Reply-To: <5395886D.9090606@gmail.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401983326-19205-5-git-send-email-antoine.tenart@free-electrons.com>
 <53919DCE.1050708@gmail.com> <20140609162631.76bd2ad7@xhacker>
 <5395886D.9090606@gmail.com>
Message-ID: <20140609105241.GC3112@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2014 at 12:11:57 +0200, Sebastian Hesselbarth wrote :
> > Some BG2Q boards hardwired the vbus to be always powered on, we should continue
> > the probe if vbus gpio is missing.
> 
> Yeah, the same applies for regulators. But with the comments above, it
> should move to the controller stub instead.
> 

We should use a regulator and in the case it is hardwired, use a fixed
regulator. Then, we can stop if it is missing.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
