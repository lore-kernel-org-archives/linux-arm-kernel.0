From: vitalywool@gmail.com (Vitaly Wool)
Date: Wed, 13 Oct 2010 11:06:51 +0200
Subject: [PATCH] sdio: fix suspend/resume regression
In-Reply-To: <AANLkTimTSPU3pzDscG3TSaqs45Q=eGEaqiDmk9AYyuY_@mail.gmail.com>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
	<AANLkTiki_Sky6pry+vWAoTtJ5ctVUpawAH6iRYV6L-+z@mail.gmail.com>
	<AANLkTimTSPU3pzDscG3TSaqs45Q=eGEaqiDmk9AYyuY_@mail.gmail.com>
Message-ID: <AANLkTi=oM6bzga1HffOxZ6_T7yjSNi5RTCZtTFd4r=7j@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 10:55 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Vitaly,
>
> On Wed, Oct 13, 2010 at 9:54 AM, Vitaly Wool <vitalywool@gmail.com> wrote:
>> what about moving this logic to sdio bus_ops as this seems to be
>> completely specific to sdio right now?
>
> I actually prefer not to have any SDIO-specific logic of that kind at
> all, and instead, to use the logic we already have in mmc_pm_notify
> for all types of MMC buses.

I don't really see the point. Instead of having SDIO-specific handling
in the SDIO specific code, we're trying to address SDIO specific
corner cases elsewhere. What's the rationale?

Thanks,
   Vitaly
