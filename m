From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2012 09:13:27 +0000
Subject: [PATCH v2 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <20120207070400.GA29238@avionic-0098.mockup.avionic-design.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
 <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
 <4F3044A9.8000202@metafoo.de>
 <20120207070400.GA29238@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120208091327.GH889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 08:04:00AM +0100, Thierry Reding wrote:
> One of the major problems when converting to a non-global namespace is how to
> represent the relationship in code. For device tree this should be easy to do
> because it has all the infrastructure in place. For non-device-tree devices I
> have no idea yet how this could be done. Perhaps by using something like the
> clock API and using names for lookup?

Well, the first step is to make sure that the pwm 'chip' drivers don't
know anything about the global numberspace.

That limits the extent of the global numberspace to the pwm core and
pwm users.  You then don't have to worry about the pwm chip drivers
while you work out how to solve the other half of the problem.
