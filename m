From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Sep 2014 11:12:48 +0200
Subject: [RFC 0/4] i2c: slave support framework for Linux devices
In-Reply-To: <20140912085836.GS3755@pengutronix.de>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <20140912085836.GS3755@pengutronix.de>
Message-ID: <20140912091247.GA1930@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> - If I understand correctly you cannot register an i2c slave without
>   also registering a master, right? I don't think this is troubling in
>   practice, is it?
>   For abstraction I would prefer to make these different concepts
>   though.

You need to register an adapter, yes. It does not need to populate the
callback for sending messages, so it could be slave only. But an adapter
is needed, because it is the glue between a client and the wired lines.

> - The IMHO most (even only?) useful slave is "i2cslvdev", i.e. a
>   userspace device. With that you wouldn't need device tree stuff, the
>   driver would just offer the device if supported. Userspace then could
>   care about the rest (slave address, functionality, ...).

I don't think it is the only useful one. A callback into userspace is
expensive, so stuff like shared memory (my eeprom simulator) or a shared
ringbuffer will come in handy, too. That being said, a slave device like
you described is probably the next user we see using the slave interface
:)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/cc886d62/attachment.sig>
