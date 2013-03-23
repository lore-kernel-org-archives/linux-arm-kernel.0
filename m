From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 23 Mar 2013 17:26:41 +0100
Subject: [PATCH 1/2] gpio: mvebu: add dbg_show function
In-Reply-To: <20130323154317.GN4977@n2100.arm.linux.org.uk>
References: <1363978188-31200-1-git-send-email-simon.guinot@sequanux.org>
 <1363978188-31200-2-git-send-email-simon.guinot@sequanux.org>
 <20130323162118.7bb6bbe3@skate>
 <20130323154317.GN4977@n2100.arm.linux.org.uk>
Message-ID: <20130323172641.79ba1dfb@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, 23 Mar 2013 15:43:18 +0000, Russell King - ARM Linux wrote:

> I don't think this is a good idea - and it's wrong.  test_bit() operates
> on an array of bits, and needs to be passed an unsigned long pointer.
> blink etc are "u32"s which aren't unsigned long.
> 
> Moreover, what if ngpio becomes greater than 32 (for whatever reason)?
> test_bit(), when used correctly, will access the following word, which
> is probably a bad thing.  The original won't have that behaviour,
> which is safer.

You're right, indeed.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
