From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 11 Dec 2012 17:45:09 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <20121211173450.GW14363@n2100.arm.linux.org.uk>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de>
 <20121211162647.GS14363@n2100.arm.linux.org.uk>
 <20121211171610.01c2de16@pyramind.ukuu.org.uk>
 <20121211173450.GW14363@n2100.arm.linux.org.uk>
Message-ID: <20121211174509.69c8c66e@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The problem comes when you end up trying to deal with stuff which
> uses ioread{8,16} on ioport_map() cookies where it's assumed that
> adding N to the cookie is the same as adding N to the port address.

It's a cookie - this isn't a problem, you can support it via the mapping
approah. Whether you want to is another question.

> Thankfully those platforms aren't going to be a part of the single
> zImage project...

Don't blame you 8)
