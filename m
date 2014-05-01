From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 May 2014 10:11:02 +0100
Subject: [RFC PATCH 0/4] drivers/base: Generic framework for tracking
 internal interfaces
In-Reply-To: <5361F1F3.7070005@wp.pl>
References: <1398866574-27001-1-git-send-email-a.hajda@samsung.com>
 <20140430154914.GA898@kroah.com> <53616E31.3050404@wp.pl>
 <20140430222839.GE26756@n2100.arm.linux.org.uk> <5361F1F3.7070005@wp.pl>
Message-ID: <20140501091102.GF26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 09:04:19AM +0200, Andrzej Hajda wrote:
> 2. You replace calls of component_add and component_del with calls
> to interface_tracker_ifup(dev, INTERFACE_TRACKER_TYPE_COMPONENT,  
> &specific_component_ops),
> or interface_tracker_ifdown.
> Thats all for components.

How does the master get to decide which components are for it?  As
I see it, all masters see all components of a particular "type".
What if you have a system with two masters each of which are bound
to a set of unique components but some of the components are of a
the same type?

How does the master know what "type" to use?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
