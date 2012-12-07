From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Dec 2012 12:33:43 +0000
Subject: [PATCH] I2C: EXYNOS: Add slave support to i2c
In-Reply-To: <50C1DB05.7090500@linaro.org>
References: <1354354961-28833-1-git-send-email-giridhar.maruthy@linaro.org>
 <CAHuqX+EQ0pZnm27yAVqC=NRX8huQ5EvbC8PGn2G3xYw4D71gQA@mail.gmail.com>
 <50C1DB05.7090500@linaro.org>
Message-ID: <20121207123343.GU14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 07, 2012 at 05:33:17PM +0530, Tushar Behera wrote:
> On 12/03/2012 05:46 PM, Giridhar Maruthy wrote:
> > This patch adds slave support to i2c. The dt entry i2c-mode
> > decides at probe time if the controller needs to work in
> > slave mode and the controller is accordingly programmed.

(I don't have the original patches.)

Hmm.  How has slave-mode support been tested?

Remembering that I2C slave devices do not initiate bus accesses, all
accesses will be started by some other master.  How are you dealing
with the bytes received from the master, and how are you returning a
response to the master in reply to a read request?

We had support for this on PXA I2C through a callback from the driver
into PXA code (used for the Psion Teklogix Netbook device) and it worked
really well, but what you can't do is use the standard I2C interfaces
for slave mode.
