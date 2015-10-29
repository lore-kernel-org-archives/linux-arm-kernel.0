From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 29 Oct 2015 11:17:21 +0300
Subject: [PATCH v3 3/4] drivers: exynos-srom: Add support for bank
 configuration
In-Reply-To: <5631C3D3.1050309@samsung.com>
References: <cover.1446018918.git.p.fedin@samsung.com>
 <048021141f295b0e70c852134d4ac9cc6f7f1da4.1446018918.git.p.fedin@samsung.com>
 <56318175.6000006@samsung.com> <006b01d11216$9831dc40$c89594c0$@samsung.com>
 <5631C3D3.1050309@samsung.com>
Message-ID: <001201d11222$3c69a6c0$b53cf440$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> But the system won't get any information about the failure. Device using
> these banks should not probe in such case.

 In order to achieve this effect, i believe, it's not enough to fail SROMc probe. Peripherials (such as smsc) should then be
declared as subnodes.
 There's one problem with this, however. I could not manage to do it. If i place device's node inside of SROMc node, it does not get
probed at all, and i don't really understand why. I tried to read the code and i suggest that only specific devices (like
compatible="simple-bus") are searched for sub-devices.
 OTOH, this patch (http://www.spinics.net/lists/arm-kernel/msg449703.html) perfectly worked, and generic timer node placed inside of
MCT node was perfectly probed by the kernel. So i still don't understand why i could not place smsc description inside of SROMc.
 May be you can help me with this?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
