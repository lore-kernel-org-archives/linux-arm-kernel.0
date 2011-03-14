From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Mon, 14 Mar 2011 10:04:44 +0100
Subject: [PATCH 06/10] ux500: added snowball-netev with latest fixes
In-Reply-To: <201103121058.05897.arnd@arndb.de>
References: <201103121058.05897.arnd@arndb.de>
	<1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-7-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20110314090444.GA25815@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd.

>> +       volatile u32 *ptr = ioremap(0x80000000, 0x10000);
> 
> I suppose you mean "u32 __iomem *" here, not "volatile u32 *ptr".

Yes, full ack. And also for the rest (as you note, the comment
says "horribly").

Actually, this patch was a quick fix to make things work and proceed
with the board. While other people were working on other devices, I
preferred to (temporarily) have a self-contained hack.

Then I forgot to make it clear to Mathieu that this was not, in my
opinion, ready to get submitted.  Please wait for us to sort this out;
currently I think the patch set should be parked.

> Better use platform_device_register_simple() instead of
> the static device.

Thanks, I didn't know about this.
