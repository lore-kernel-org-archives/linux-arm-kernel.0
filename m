From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 13 Oct 2010 11:46:36 +0200
Subject: [PATCH] sdio: fix suspend/resume regression
In-Reply-To: <AANLkTi=oM6bzga1HffOxZ6_T7yjSNi5RTCZtTFd4r=7j@mail.gmail.com>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
	<AANLkTiki_Sky6pry+vWAoTtJ5ctVUpawAH6iRYV6L-+z@mail.gmail.com>
	<AANLkTimTSPU3pzDscG3TSaqs45Q=eGEaqiDmk9AYyuY_@mail.gmail.com>
	<AANLkTi=oM6bzga1HffOxZ6_T7yjSNi5RTCZtTFd4r=7j@mail.gmail.com>
Message-ID: <AANLkTimqo5exLf46ONKvMs5=aPwXgLrBGPAexVZJHje0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 11:06 AM, Vitaly Wool <vitalywool@gmail.com> wrote:
> I don't really see the point. Instead of having SDIO-specific handling
> in the SDIO specific code, we're trying to address SDIO specific
> corner cases elsewhere. What's the rationale?

MMC core already has a card-removal mechanism which is bus independent
(in mmc_pm_notify).

Why would you prefer to duplicate this code for SDIO ?

Thanks,
Ohad.
