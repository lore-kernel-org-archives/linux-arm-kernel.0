From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 13 Oct 2010 10:55:39 +0200
Subject: [PATCH] sdio: fix suspend/resume regression
In-Reply-To: <AANLkTiki_Sky6pry+vWAoTtJ5ctVUpawAH6iRYV6L-+z@mail.gmail.com>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
	<AANLkTiki_Sky6pry+vWAoTtJ5ctVUpawAH6iRYV6L-+z@mail.gmail.com>
Message-ID: <AANLkTimTSPU3pzDscG3TSaqs45Q=eGEaqiDmk9AYyuY_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vitaly,

On Wed, Oct 13, 2010 at 9:54 AM, Vitaly Wool <vitalywool@gmail.com> wrote:
> what about moving this logic to sdio bus_ops as this seems to be
> completely specific to sdio right now?

I actually prefer not to have any SDIO-specific logic of that kind at
all, and instead, to use the logic we already have in mmc_pm_notify
for all types of MMC buses.

I resent this patch in the hope of stimulating this discussion, since
it seemed to have stalled since the last message:

http://lkml.org/lkml/2010/10/11/70

It seems to work ;)

Thanks,
Ohad.
