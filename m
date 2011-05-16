From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 16 May 2011 13:28:34 +0900
Subject: [PATCH] shmobile: fix map_io init usage
In-Reply-To: <20110513015653.GM18952@game.jcrosoft.org>
References: <1304267322-19022-1-git-send-email-plagnioj@jcrosoft.com>
	<20110513015653.GM18952@game.jcrosoft.org>
Message-ID: <BANLkTikorWv-9VnRG51v30YFQksRMxVS5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 10:56 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 18:28 Sun 01 May ? ? , Jean-Christophe PLAGNIOL-VILLARD wrote:
>> switch early init to init_early and introduce soc map_io
>>
>> with this Patch we will not do any more early device setup during the map io
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> Cc: Paul Mundt <lethal@linux-sh.org>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
> ping

Why? The device init order is changed by this patch to setup the
serial console later. I fail to see the benefit. Basically, the serial
console setup is delayed to happen in ->init_early() instead of
->map_io(). In practice this means that we restrict ourselves to not
be able to output debug messages on the serial console from a bunch of
calls in setup_arch().

/ magnus
