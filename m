From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 24 Jan 2013 16:45:14 +0100
Subject: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
In-Reply-To: <51015663.8080109@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
 <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch>
Message-ID: <5101570A.1030303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 04:42 PM, Florian Vaussard wrote:
> I did it at first, but the led API executes in atomic context, where the
> pwm-twl-led driver uses i2c communication. Setting a trigger will result in a
> kernel panic.

Now that you mentioned it, this might be true.

> I am working on a patch for pwm-twl-led to defer using a workqueue right now.

Great!
The only thing I worry about is the latency we are going to get with the
workqueue.

-- 
P?ter
