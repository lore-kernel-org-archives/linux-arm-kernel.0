From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 12:54:13 -0500
Subject: [PATCH v2 1/3] input: touchscreen: edt-ft5x06: don't make device
 a wakeup source by default
In-Reply-To: <20180517090552.5704-2-daniel@zonque.org>
References: <20180517090552.5704-1-daniel@zonque.org>
 <20180517090552.5704-2-daniel@zonque.org>
Message-ID: <20180522175413.GA24850@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 11:05:50AM +0200, Daniel Mack wrote:
> Allow configuring the device as wakeup source through device properties, as
> not all platforms want to wake up on touch screen activity.
> 
> The I2C core automatically reads the "wakeup-source" DT property to
> configure a device's wakeup capability, and board supports files can set
> I2C_CLIENT_WAKE in the flags.

This will break wake-up on working systems. Looks like mostly i.MX, but 
there's one AM437x board. If that board doesn't care, then it is up to 
Shawn.

Rob
