From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 10 Jul 2015 14:09:07 +0200
Subject: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
In-Reply-To: <559F7AC4.6050008@atmel.com>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150710060350.GA3127@piout.net> <559F7AC4.6050008@atmel.com>
Message-ID: <20150710120907.GC3127@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/07/2015 at 15:56:52 +0800, Josh Wu wrote :
> I would agree with Maxime. Currently all latest chip reset function is
> compatible with the atmel,sama5d3-rstc.
> So check compatible string is enough for now.
> But of cause if we have other incompatible reset in future with new chip,
> the structure like you said is needed.

We managed to avoid using of_machine_is_compatible() in all the at91
drivers. I'd like to keep it that way. It was painful enough to remove
all those cpu_is_at91xxx calls.
Also, using it is trying to match strings and will result in longer boot
times.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
