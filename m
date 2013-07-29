From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sun, 28 Jul 2013 21:30:22 -0400
Subject: Defining schemas for Device Tree
In-Reply-To: <2469263.vMN09Q7Tzi@flatron>
References: <2469263.vMN09Q7Tzi@flatron>
Message-ID: <CAKON4OzgqH5AiOtismEGop5Y++gvu1ZVZEXhwJB3f-6_eczkqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is another angle to this problem -- how do we make a single
schema for all device trees accepted by the kernel? We certainly don't
want a schema for each vendor where they can do whatever they want.

Obviously all devices in a device class are not identical but many of
their attributes are. The purpose of a unified schema is stop one
vendor from naming an attribute VOLTAGE, another VOLTS, another V, etc
when all of these attributes are doing the same thing - setting a
voltage. It is possible to use different names right now since they
are different device drivers. There's no overall architecture glue
(schema) holding the device class design together.

The main point of this unified schema is to help people creating new
device drivers. When ypu construct your device tree representation you
should first try your best to get it to fit into the existing device
class schema. Only after you determine that it is impossible to make
do with the current schema should you ask for the generic schema to be
extended to include whatever attribute you think you need. At that
point peer review will happen and hopefully a good solution will
ensue.

----------------

Imagine what might be possible with device trees in a few years...

A single kernel image can load on any embedded system. The device tree
sorts out all of the driver loading and tells how everything is wired
together. There is zero board specific code in the kernel. We're
getting close to this one.

And in the far future - send your device tree off to a cloud PCB
printer and get your custom embedded system back in the mail. Sign me
up for this one!

-- 
Jon Smirl
jonsmirl at gmail.com
