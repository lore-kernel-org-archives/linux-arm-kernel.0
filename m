From: padma.kvr@gmail.com (padma venkat)
Date: Thu, 30 Jun 2011 14:57:43 +0530
Subject: [PATCH 0/7] ARM: SAMSUNG: Cleanup SPI platform specific code
In-Reply-To: <BANLkTin2MAsTn3UhJDOLVvsams=xRR=REQ@mail.gmail.com>
References: <1309436723-662-1-git-send-email-padma.v@samsung.com>
	<BANLkTin2MAsTn3UhJDOLVvsams=xRR=REQ@mail.gmail.com>
Message-ID: <BANLkTimaMiFgKa95Zm4AtQVFdbSqukBfwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 30, 2011 at 1:01 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Thu, Jun 30, 2011 at 5:55 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
>> This patchset does the following:
>>
>> 1. Move duplicated code to common place
>> [PATCH 1/7] ARM: SAMSUNG: Move SPI device definitions to plat-samsung
>> SPI platform devices are defined in respective machine folder of
>> Samsung S3C64XX and S5P series SoCs.This is duplicated for every SoC.
>> So all SPI platform devices are moved to a common place.
>
> The machine specific code is put in machine specific location for some reason.
> And the code is not duplicated, it's mostly data structures
> initialized with machine
> specific values.
>
> Have you considered if it would still be possible to build kernel
> image supporting
> more than 1 soc after your changes ?
I didn't consider the single image scenario. Because as far as I know,
the existing Samsung code doesn't have support for building a single kernel
image for multiple SoCs.

The intention behind my changes were
1) To reuse the dev-spi files for all the SoCs, as this reduces the code size.
Also future SoCs with SPI can use the same file.
2) To be in line with other IPs like i2c,sdhci etc

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
Thanks&Regards
Padma
