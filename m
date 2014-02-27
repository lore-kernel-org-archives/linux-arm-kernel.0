From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Feb 2014 23:49:49 +0000
Subject: [PATCH] Documentation: clk: Add locking documentation
In-Reply-To: <8346510.ElnkWC0c6c@avalon>
References: <1393451575-23758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140226222925.GE21483@n2100.arm.linux.org.uk>
 <20140226233053.12081.45765@quantum> <8346510.ElnkWC0c6c@avalon>
Message-ID: <20140227234949.GM21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 12:07:55AM +0100, Laurent Pinchart wrote:
> Hi Mike and Russell,
> 
> If I'm not mistaken that document explains CCF from a driver point of view, 
> not from a user point of view. The clk_enable() and clk_prepare() functions 
> are only mentioned in one example to describe the internal call stack.
> While I totally agree that the enable/prepare relationship and the
> spinlock/mutex pair is a very important part of CCF, I believe they would
> rather belong to a CCF user API documentation.

The type of lock is relevant on both sides of the API.  Users need to
know that the prepare/unprepare may sleep during those calls, and
implementations need to know that they can sleep during those calls.
Conversely, with enable/disable, users can see they will never sleep
(because sleeping with a spinlock held is illegal) and implementations
need to know that too.

So, I think there's value in adding that information here.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
