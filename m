From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 2 Jan 2015 20:53:51 +0100
Subject: [PATCHv5 0/2] INPUT: Route keyboard LEDs through the generic
 LEDs layer
In-Reply-To: <20141226232116.GA5069@type>
References: <20141226232116.GA5069@type>
Message-ID: <20150102195350.GB27538@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Here is v5 coming, with separate patches for the kbd and the input
> parts.

After booting with this, capslock led does not seem to work on text
console.

input4::capsl/trigger was none by default, that can't be right, right?

I tried putting kbd-capslock and input4-capsl there, but that did not
seem to help.

It works with heartbeat trigger, but not with input4-numl
trigger. (But numlock led works ok with that trigger, weird).

vt::capsl/brightness controls capslock led, even when
input4-capsl/trigger is set to input4-numl.

Confused,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
