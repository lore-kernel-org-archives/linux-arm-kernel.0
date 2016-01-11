From: laura@labbott.name (Laura Abbott)
Date: Mon, 11 Jan 2016 13:39:21 -0800
Subject: [RESEND][PATCHv2 0/3] Devicetree bindings for Ion
Message-ID: <1452548364-9522-1-git-send-email-laura@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There was some recent discussion
(http://thread.gmane.org/gmane.linux.ports.arm.kernel/468051/)
about Ion DT bindings and a request that I resend my proposal for common DT
bindings. This is a straight resend, no bux fixed that were pointed out.
Previous thread: http://article.gmane.org/gmane.linux.drivers.driver-project.devel/80475

>From before:

This is another attempt at devicetree bindings for Ion. The big complaint from
v1 was that too much unnecessary data was being pushed into devicetree.
v2 takes a different approach of using just compatbile strings for the heaps.
This gets closer to the devicetree philosophy of describing just the hardware.
Each heap ultimately represents some kind of memory that exists in the system.
The compatible string indicates the match for how to handle the type of memory
on this system. The details like heap-id, name etc. are now pushed out to C
files. This makes Ion heaps look closer to something like a quirks framework.
(I'd argue this isn't a complete mischaracterization given the type of setup
Ion gets used for...) The one downside here is that this leads to more new
bindings for each board that gets added.

This version also includes a sample C file which shows what the structure
might look like. As always, your comments and reviews are appreciated.


Thanks,
Laura

-- 
2.5.0
