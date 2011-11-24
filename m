From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 24 Nov 2011 12:56:16 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <alpine.LFD.2.02.1111231929050.17904@xanadu.home>
References: <20111123122855.GB7382@totoro>
 <20111123130134.GB12227@opensource.wolfsonmicro.com>
 <20111123133237.GC7382@totoro>
 <20111123135033.GA20272@opensource.wolfsonmicro.com>
 <20111123143322.GD7382@totoro>
 <20111123145517.GE20272@opensource.wolfsonmicro.com>
 <4ECD32CA.2030601@gmail.com>
 <20111123175446.GI30049@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111231402370.17904@xanadu.home>
 <alpine.LFD.2.02.1111231929050.17904@xanadu.home>
Message-ID: <20111124125615.GJ8470@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 07:32:58PM -0500, Nicolas Pitre wrote:

> That should provide you with the ability to figure out what's wrong.

Found one problem which I just sent a patch for, iotable_init() was not
coping with being passed an empty table which it had previously been OK
with.  However, the boot still dies shortly afterwards when we try to
read the CPU ID in s3c64xx_init_cpu() and presumably take an exception
due to the system address either not being mapped or mapped somewhere
other than where the code expects.
