From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Aug 2017 15:47:29 +0200
Subject: [RFC 1/3] dt-bindings: rtc: Add Realtek RTD1295
In-Reply-To: <629b9ed0-7b2d-7c5c-20b8-17289a76f097@suse.de>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-2-afaerber@suse.de>
 <20170823002911.y35nn7jkt34dvjbc@rob-hp-laptop>
 <629b9ed0-7b2d-7c5c-20b8-17289a76f097@suse.de>
Message-ID: <20170827134729.GE13622@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thanks. Did you read the RFC question in the cover letter as well and
> have any comments? Downstream has an rtc-base-year = <2014>; property
> that I had left out in this RFC and due to your ack not included in v2.
> 
> Should we default to 2014 in the driver and add an optional base-year
> property once we encounter a diverging device, or should we make it
> required from the beginning? I did not spot any other rtc binding with
> such a property and would appreciate a clarification.

Hi Andreas

>From the perspective of the hardware, does it care what the base is?

A device using a different base will initially return the wrong
time. But once the correct time has been written back, it will be O.K.

This only becomes an issue if a device is used with different OSs,
which have different bases. Swapping back and forth between OSs then
becomes an issue.

KISS suggests not having a base in DT until it is actually
required. Since it is an additional property, it does not break
backwards compatibility when added.

	  Andrew
