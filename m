From: slash.tmp@free.fr (Mason)
Date: Sun, 24 Jan 2016 14:27:25 +0100
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <20160123235905.GE10826@n2100.arm.linux.org.uk>
References: <56A268E7.7040004@free.fr>
 <20160122174814.GD19062@n2100.arm.linux.org.uk> <56A27C00.5060004@free.fr>
 <20160122193408.GE19062@n2100.arm.linux.org.uk> <56A2B811.8010306@free.fr>
 <20160122235704.GF19062@n2100.arm.linux.org.uk> <56A3609E.3000400@free.fr>
 <20160123113438.GG19062@n2100.arm.linux.org.uk> <56A3E84A.1000604@free.fr>
 <20160123235905.GE10826@n2100.arm.linux.org.uk>
Message-ID: <56A4D13D.3030906@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/2016 00:59, Russell King - ARM Linux wrote:

> I'll quote what you said in previous mails in this thread,
> so there's no misunderstanding.

Russell,

Our "software stack" provides the kernel API under discussion:

  {read,write}_data{8,16,32}

These 6 functions must be implemented, because they are part
of the API we provide to customers. As the "page domain fault"
underscores, my own implementation is incorrect. I am grateful
for the implementation you suggested up-thread, and will test
its performance on Monday.


Our "software stack" also provides several user-space tools,
some of which use the above kernel API. One of those tools is
the one I described, to copy files to remote RAM.

The current code uses write_data8, but the implementation is
irrelevant. Any implementation is acceptable, as long as the
tool works as expected. So I can take advantage of the tool's
specificities to optimize.


Anyway, thanks again for the guidance and advice, and please
give a little more credit.

Regards.
