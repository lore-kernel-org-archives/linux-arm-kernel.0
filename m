From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 16 Nov 2017 17:52:02 +0100
Subject: [PATCH v3 3/4] net: nb8800: Move HW init to ndo_open()
In-Reply-To: <20171116162349.GG7627@lunn.ch>
References: <103bc878-9311-a727-1c21-2070e0a480e5@sigmadesigns.com>
 <yw1xwp2t11ap.fsf@mansr.com>
 <4e22ef54-d823-fc29-fedc-d447fa3d9c88@sigmadesigns.com>
 <yw1xfu9h0xv7.fsf@mansr.com>
 <30042004-4e13-b7e2-b49d-754db54cc5ce@sigmadesigns.com>
 <yw1xbmk4241h.fsf@mansr.com>
 <a047ecbd-c8a2-a8c0-7c9d-947b28aa8b9a@sigmadesigns.com>
 <yw1xr2szzie5.fsf@mansr.com>
 <bed48cd4-dfc3-2572-ef76-4f5b449be6e2@sigmadesigns.com>
 <691f71bc-9e1b-5281-1482-fc532151f5ce@sigmadesigns.com>
 <20171116162349.GG7627@lunn.ch>
Message-ID: <ffe4be7c-746d-86b3-54d3-0ddc5f70e266@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/11/2017 17:23, Andrew Lunn wrote:

> Maybe take a look at your memory barriers. Most accesses using the
> _relaxed() version, i.e, no barrier. And then there are specific
> barriers when needed. One could be missing.
> 
> As a quick test, drop the _relaxed. Force a barrier with each
> access. If that works, it is a clear indication you have a barrier
> problem.

That was an interesting suggestion, thanks!

Unfortunately, adding wmb() in dozens of strategic places doesn't
prevent the issue where network connectivity is lost :-(

Regards.
