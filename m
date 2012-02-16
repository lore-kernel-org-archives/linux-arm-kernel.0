From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2012 12:12:34 +0000
Subject: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
In-Reply-To: <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com>
Message-ID: <20120216121234.GJ15338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 05:30:59PM +0530, Nayak, Rajendra wrote:
> > One more patch is needed to sort out the remaining issue with
> > omap4 that has yet another luck based initialization for the
> > same issue..
> >
> 
> I did this patch on top of your series which should fix the
> issue on all omap4 boards too. Tested on omap4panda and
> omap4sdp boards.

Can you test something with these patches?

1. Build the gpio-twl4030.c as a module, but with HSMMC support built in
2. Boot on the 4430SDP
3. Load the gpio-twl4030 module
4. Remove the gpio-twl4030 module
5. Re-load the gpio-twl4030.ko module

and report back what you get.  Thanks.
