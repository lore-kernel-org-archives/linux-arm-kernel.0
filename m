From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 09:40:34 +0200
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <CAGsJ_4xUsw21EM2GXMt4i27MGjCP_h46tCzhDqo-MCZkAVsEiw@mail.gmail.com>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<20110706062838.GI9978@ponder.secretlab.ca>
	<CAGsJ_4xUsw21EM2GXMt4i27MGjCP_h46tCzhDqo-MCZkAVsEiw@mail.gmail.com>
Message-ID: <201107060940.34452.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011 09:03:45 Barry Song wrote:
> but it seems we will still add "sirf,alsta6-intc" in intc driver if
> that really happen in the future. in my understanding, drivers should
> explicitly claim all chips or ip cores they can support.

I don't think there is a need for that. I'd only add the second
one if there is a need in the driver to tell the difference.
In that case, you can add a data field to the device_id and use
that for making decisions in the driver.

	Arnd
